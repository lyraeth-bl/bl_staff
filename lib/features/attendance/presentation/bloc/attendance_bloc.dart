import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/core.dart';
import '../../domain/entities/attendance_entity/attendance_entity.dart';
import '../../domain/usecases/fetch_monthly_attendance_use_case.dart';

part 'attendance_bloc.freezed.dart';
part 'attendance_event.dart';
part 'attendance_state.dart';

class AttendanceBloc extends Bloc<AttendanceEvent, AttendanceState> {
  AttendanceBloc(this._fetchMonthlyAttendanceUseCase)
    : super(const AttendanceState.initial()) {
    on<_Started>(_onStarted);
    on<_MonthChanged>(_onMonthChanged);
    on<_Refreshed>(_onRefreshed);
  }

  final FetchMonthlyAttendanceUseCase _fetchMonthlyAttendanceUseCase;

  int _currentMonth = DateTime.now().month;
  int _currentYear = DateTime.now().year;

  void _onStarted(_Started event, Emitter<AttendanceState> emit) {
    add(AttendanceEvent.monthChanged(month: _currentMonth, year: _currentYear));
  }

  Future<void> _onMonthChanged(
    _MonthChanged event,
    Emitter<AttendanceState> emit,
  ) async {
    _currentMonth = event.month;
    _currentYear = event.year;

    emit(const AttendanceState.loading());

    final result = await _fetchMonthlyAttendanceUseCase.call(
      month: event.month,
      year: event.year,
    );

    result.match(
      (failure) => emit(AttendanceState.failure(failure)),
      (attendances) => emit(
        AttendanceState.success(
          attendances: attendances,
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
    emit(const AttendanceState.loading());

    final result = await _fetchMonthlyAttendanceUseCase.call(
      month: _currentMonth,
      year: _currentYear,
      forceRefresh: true,
    );

    result.match(
      (failure) => emit(AttendanceState.failure(failure)),
      (attendances) => emit(
        AttendanceState.success(
          attendances: attendances,
          month: _currentMonth,
          year: _currentYear,
        ),
      ),
    );
  }
}
