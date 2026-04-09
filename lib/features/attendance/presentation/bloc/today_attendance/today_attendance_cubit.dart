import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../core/core.dart';
import '../../../domain/entities/attendance_entity/attendance_entity.dart';
import '../../../domain/usecases/fetch_today_attendance_use_case.dart';

part 'today_attendance_cubit.freezed.dart';
part 'today_attendance_state.dart';

class TodayAttendanceCubit extends Cubit<TodayAttendanceState> {
  TodayAttendanceCubit(this._fetchTodayAttendanceUseCase)
    : super(const TodayAttendanceState.initial());

  final FetchTodayAttendanceUseCase _fetchTodayAttendanceUseCase;

  Future<void> load({bool forceRefresh = false}) async {
    emit(const TodayAttendanceState.loading());

    final result = await _fetchTodayAttendanceUseCase.call(
      forceRefresh: forceRefresh,
    );

    result.match((failure) => emit(TodayAttendanceState.failure(failure)), (
      attendance,
    ) {
      if (attendance == null) {
        return emit(TodayAttendanceState.noAttendanceToday());
      }

      return emit(TodayAttendanceState.success(attendance: attendance));
    });
  }

  Future<void> refresh() => load(forceRefresh: true);

  AttendanceEntity? get todayAttendance =>
      state.whenOrNull(success: (attendance) => attendance);
}
