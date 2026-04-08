import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../utils/utils_export.dart';
import '../../domain/entities/attendance_entity/attendance_entity.dart';
import '../../domain/repositories/attendance_repository.dart';
import '../datasources/attendance_local_data_source.dart';
import '../datasources/attendance_remote_data_source.dart';
import '../mapper/attendance_mapper.dart';
import '../models/monthly_attendance_response/monthly_attendance_response.dart';
import '../models/today_attendance_response/today_attendance_response.dart';

class AttendanceRepositoryImpl implements AttendanceRepository {
  AttendanceRepositoryImpl(this._remoteDataSource, this._localDataSource);

  final AttendanceLocalDataSource _localDataSource;
  final AttendanceRemoteDataSource _remoteDataSource;

  @override
  Future<Result<List<AttendanceEntity>>> fetchMonthlyAttendance({
    required int month,
    required int year,
    bool forceRefresh = false,
  }) async {
    if (!forceRefresh) {
      final cachedListData = _localDataSource.getSavedMonthlyAttendance(
        month: month,
        year: year,
      );

      if (cachedListData != null) {
        final toEntities = cachedListData.map((m) => m.toEntity()).toList();
        debugPrint("monthlyAttendance using data from local");
        return right(toEntities);
      }
    }

    final response = await _remoteDataSource.fetchMonthlyAttendance(
      month: month,
      year: year,
    );

    return response.match((failure) => left(failure), (
      MonthlyAttendanceResponse monthlyAttendanceResponse,
    ) async {
      final rawModel = monthlyAttendanceResponse.listAttendanceModel;

      await _localDataSource.saveMonthlyAttendance(
        month: month,
        year: year,
        listAttendanceModel: rawModel,
      );
      debugPrint("monthlyAttendance data saved to local");

      final convertToEntity = rawModel.map((m) => m.toEntity()).toList();

      return right(convertToEntity);
    });
  }

  @override
  Future<Result<AttendanceEntity?>> fetchTodayAttendance({
    bool forceRefresh = false,
  }) async {
    if (!forceRefresh) {
      final cachedData = _localDataSource.getSavedTodayAttendance();
      if (cachedData != null) {
        debugPrint("todayAttendance using data from local");
        return right(cachedData.toEntity());
      }
    }

    final response = await _remoteDataSource.fetchTodayAttendance();

    return response.match((failure) => left(failure), (
      TodayAttendanceResponse todayAttendanceResponse,
    ) async {
      final entities = todayAttendanceResponse.attendanceModel?.toEntity();

      if (entities != null) {
        debugPrint("todayAttendance data saved to local");
        await _localDataSource.saveTodayAttendance(entities.toModel());
      }

      return right(entities);
    });
  }
}
