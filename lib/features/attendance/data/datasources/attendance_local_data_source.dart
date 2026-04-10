import 'package:fpdart/fpdart.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../../core/core.dart';
import '../models/attendance_model/attendance_model.dart';

/// A data source for persisting and retrieving attendance data locally.
///
/// This interface defines methods for caching attendance records, allowing
/// the application to function or show data when offline.
///
/// See also:
/// * [AttendanceLocalDataSourceImpl], for the Hive-based implementation.
abstract class AttendanceLocalDataSource {
  /// Returns the cached attendance record for the current day.
  ///
  /// Returns null if no record is found for today.
  AttendanceModel? getSavedTodayAttendance();

  /// Returns a list of cached attendance records for the specified [month] and [year].
  ///
  /// Returns null if no records are found for the given period.
  List<AttendanceModel>? getSavedMonthlyAttendance({
    required int month,
    required int year,
  });

  /// Persists the [attendanceEntity] to local storage for the current day.
  ///
  /// Returns [unit] upon successful completion.
  Future<Unit> saveTodayAttendance(AttendanceModel attendanceEntity);

  /// Persists a list of [listAttendanceModel] to local storage for the specified [month] and [year].
  ///
  /// Returns [unit] upon successful completion.
  Future<Unit> saveMonthlyAttendance({
    required int month,
    required int year,
    required List<AttendanceModel> listAttendanceModel,
  });
}

/// An implementation of [AttendanceLocalDataSource] that uses [HiveInterface]
/// for local persistence.
///
/// This class handles key generation for daily and monthly records and
/// manages serialization to and from the Hive box.
class AttendanceLocalDataSourceImpl implements AttendanceLocalDataSource {
  /// Creates an [AttendanceLocalDataSourceImpl] with the given [hive] instance.
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
