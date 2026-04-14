import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/core.dart';
import '../../domain/entities/attendance_entity/attendance_entity.dart';
import '../../domain/entities/attendance_summary/attendance_summary.dart';
import '../../domain/usecases/fetch_monthly_attendance_use_case.dart';

part 'attendance_bloc.freezed.dart';
part 'attendance_event.dart';
part 'attendance_state.dart';

/// A BLoC that manages the state of the attendance history.
///
/// This BLoC handles fetching and refreshing attendance records for specific
/// months and years. It coordinates with [FetchMonthlyAttendanceUseCase] to
/// retrieve data and emits [AttendanceState] to represent the current UI state.
///
/// See also:
/// * [AttendanceEvent], for the events handled by this BLoC.
/// * [AttendanceState], for the states emitted by this BLoC.
class AttendanceBloc extends Bloc<AttendanceEvent, AttendanceState> {
  /// Creates an [AttendanceBloc] with the given use case.
  AttendanceBloc(this._fetchMonthlyAttendanceUseCase)
    : super(const AttendanceState.initial()) {
    on<_Started>(_onStarted);
    on<_MonthChanged>(_onMonthChanged);
    on<_Refreshed>(_onRefreshed);
  }

  final FetchMonthlyAttendanceUseCase _fetchMonthlyAttendanceUseCase;

  int _currentMonth = DateTime.now().month;
  int _currentYear = DateTime.now().year;

  /// Builds an [AttendanceSummary] by counting each [AttendanceStatus] variant
  /// in [attendances].
  ///
  /// This is intentionally kept in the BLoC — it is pure derived/presentation
  /// data and does not belong in the domain or data layers.
  AttendanceSummary _buildSummary(List<AttendanceEntity> attendances) {
    int hadir = 0;
    int terlambat = 0;
    int absen = 0;
    int lupaCheckin = 0;
    int lupaCheckout = 0;

    for (final a in attendances) {
      switch (a.status) {
        case AttendanceStatus.hadir:
          hadir++;
        case AttendanceStatus.terlambat:
          terlambat++;
        case AttendanceStatus.absen:
          absen++;
        case AttendanceStatus.lupaCheckin:
          lupaCheckin++;
        case AttendanceStatus.lupaCheckout:
          lupaCheckout++;
        case AttendanceStatus.belumAbsen:
          // Not counted — no record has been created yet for the day.
          break;
      }
    }

    return AttendanceSummary(
      totalHadir: hadir,
      totalTerlambat: terlambat,
      totalAbsen: absen,
      totalLupaCheckin: lupaCheckin,
      totalLupaCheckout: lupaCheckout,
    );
  }

  /// Extracts the last known [AttendanceSummary] from the current state,
  /// returning null when no prior successful fetch has occurred.
  AttendanceSummary? _lastSummary() => state.whenOrNull(
    success: (_, summary, _, _) => summary,
    failure: (_, _, lastSummary, _, _) => lastSummary,
  );

  /// Extracts the last known attendance list from the current state for the
  /// given [month] and [year], returning null when the cached data belongs to
  /// a different period or no prior fetch has occurred.
  List<AttendanceEntity>? _lastAttendances({
    required int month,
    required int year,
  }) => state.whenOrNull(
    success: (attendances, _, m, y) =>
        (m == month && y == year) ? attendances : null,
    failure: (_, lastAttendances, _, lastMonth, lastYear) =>
        (lastMonth == month && lastYear == year) ? lastAttendances : null,
  );

  void _onStarted(_Started event, Emitter<AttendanceState> emit) {
    add(AttendanceEvent.monthChanged(month: _currentMonth, year: _currentYear));
  }

  Future<void> _onMonthChanged(
    _MonthChanged event,
    Emitter<AttendanceState> emit,
  ) async {
    _currentMonth = event.month;
    _currentYear = event.year;

    final lastAttendances = _lastAttendances(
      month: event.month,
      year: event.year,
    );
    final lastSummary = _lastSummary();

    emit(const AttendanceState.loading());

    final result = await _fetchMonthlyAttendanceUseCase.call(
      month: event.month,
      year: event.year,
    );

    result.match(
      (failure) => emit(
        AttendanceState.failure(
          failure: failure,
          lastAttendances: lastAttendances,
          lastSummary: lastSummary,
          lastMonth: _currentMonth,
          lastYear: _currentYear,
        ),
      ),
      (attendances) => emit(
        AttendanceState.success(
          attendances: attendances,
          summary: _buildSummary(attendances),
          month: event.month,
          year: event.year,
        ),
      ),
    );
  }

  Future<void> _onRefreshed(
    _Refreshed event,
    Emitter<AttendanceState> emit,
  ) async {
    final lastAttendances = _lastAttendances(
      month: _currentMonth,
      year: _currentYear,
    );
    final lastSummary = _lastSummary();

    emit(const AttendanceState.loading());

    final result = await _fetchMonthlyAttendanceUseCase.call(
      month: _currentMonth,
      year: _currentYear,
      forceRefresh: true,
    );

    result.match(
      (failure) => emit(
        AttendanceState.failure(
          failure: failure,
          lastAttendances: lastAttendances,
          lastSummary: lastSummary,
          lastMonth: _currentMonth,
          lastYear: _currentYear,
        ),
      ),
      (attendances) => emit(
        AttendanceState.success(
          attendances: attendances,
          summary: _buildSummary(attendances),
          month: _currentMonth,
          year: _currentYear,
        ),
      ),
    );
  }
}
