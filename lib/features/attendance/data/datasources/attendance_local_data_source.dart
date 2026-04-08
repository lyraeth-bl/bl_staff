import 'package:fpdart/fpdart.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../../core/core.dart';
import '../models/attendance_model/attendance_model.dart';

abstract class AttendanceLocalDataSource {
  AttendanceModel? getSavedTodayAttendance();

  List<AttendanceModel>? getSavedMonthlyAttendance({
    required int month,
    required int year,
  });

  Future<Unit> saveTodayAttendance(AttendanceModel attendanceEntity);

  Future<Unit> saveMonthlyAttendance({
    required int month,
    required int year,
    required List<AttendanceModel> listAttendanceModel,
  });
}

class AttendanceLocalDataSourceImpl implements AttendanceLocalDataSource {
  AttendanceLocalDataSourceImpl(this._hive);

  final HiveInterface _hive;

  String _monthlyKey(int month, int year) =>
      '${monthlyAttendanceKey}_${year}_$month';

  String get _todayKey {
    final now = DateTime.now();
    return '${todayAttendanceKey}_${now.year}_${now.month.toString().padLeft(2, '0')}_${now.day.toString().padLeft(2, '0')}';
  }

  @override
  List<AttendanceModel>? getSavedMonthlyAttendance({
    required int month,
    required int year,
  }) {
    final rawData =
        _hive.box(attendanceBoxKey).get(_monthlyKey(month, year))
            as List<dynamic>?;

    if (rawData == null) return null;

    return rawData
        .map((e) => AttendanceModel.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }

  @override
  AttendanceModel? getSavedTodayAttendance() {
    final rawData = _hive.box(attendanceBoxKey).get(_todayKey) as Map?;

    if (rawData == null) return null;

    return AttendanceModel.fromJson(Map<String, dynamic>.from(rawData));
  }

  @override
  Future<Unit> saveMonthlyAttendance({
    required int month,
    required int year,
    required List<AttendanceModel> listAttendanceModel,
  }) async {
    final jsonList =
        listAttendanceModel.map((e) => e.toJson()).toList() as List<dynamic>?;

    await _hive.box(attendanceBoxKey).put(_monthlyKey(month, year), jsonList);

    return unit;
  }

  @override
  Future<Unit> saveTodayAttendance(AttendanceModel attendanceEntity) async {
    await _hive.box(attendanceBoxKey).put(_todayKey, attendanceEntity.toJson())
        as List<Map<String, dynamic>>?;

    return unit;
  }
}
