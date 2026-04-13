import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../core/core.dart';
import '../../../domain/entities/attendance_entity/attendance_entity.dart';
import '../../../domain/usecases/fetch_today_attendance_use_case.dart';

part 'today_attendance_cubit.freezed.dart';
part 'today_attendance_state.dart';

/// A Cubit that manages the state of the current day's attendance.
///
/// This Cubit handles fetching today's attendance record and maintains the
/// state of whether a staff member has clocked in or out for the day. It
/// interacts with [FetchTodayAttendanceUseCase].
///
/// See also:
/// * [TodayAttendanceState], for the states emitted by this Cubit.
class TodayAttendanceCubit extends Cubit<TodayAttendanceState> {
  /// Creates a [TodayAttendanceCubit] with the given use case.
  TodayAttendanceCubit(this._fetchTodayAttendanceUseCase)
    : super(const TodayAttendanceState.initial());

  final FetchTodayAttendanceUseCase _fetchTodayAttendanceUseCase;

  /// Loads today's attendance record.
  ///
  /// Setting [forceRefresh] to true triggers a fresh fetch from the remote
  /// source, bypassing local caches.
  Future<void> load({bool forceRefresh = false}) async {
    final lastDataAttendance = state.whenOrNull(
      success: (attendance) => attendance,
      failure: (_, dataBeforeFailure) => dataBeforeFailure,
    );
    emit(const TodayAttendanceState.loading());

    final result = await _fetchTodayAttendanceUseCase.call(
      forceRefresh: forceRefresh,
    );

    result.match(
      (failure) => emit(
        TodayAttendanceState.failure(
          failure: failure,
          dataBeforeFailure: lastDataAttendance,
        ),
      ),
      (attendance) {
        if (attendance == null) {
          return emit(TodayAttendanceState.noAttendanceToday());
        }

        return emit(TodayAttendanceState.success(attendance: attendance));
      },
    );
  }

  /// Manually refreshes today's attendance record from the remote source.
  Future<void> refresh() => load(forceRefresh: true);

  /// The attendance record for today if the current state is success.
  ///
  /// Returns null if the record hasn't been loaded or doesn't exist.
  AttendanceEntity? get todayAttendance =>
      state.whenOrNull(success: (attendance) => attendance);
}
