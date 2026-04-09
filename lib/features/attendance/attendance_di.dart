import 'package:hive_flutter/adapters.dart';

import '../../core/core.dart';
import '../../utils/shared/constant.dart';
import 'data/datasources/attendance_local_data_source.dart';
import 'data/datasources/attendance_remote_data_source.dart';
import 'data/repositories/attendance_repository_impl.dart';
import 'domain/repositories/attendance_repository.dart';
import 'domain/usecases/fetch_monthly_attendance_use_case.dart';
import 'domain/usecases/fetch_today_attendance_use_case.dart';
import 'presentation/bloc/attendance_bloc.dart';
import 'presentation/bloc/today_attendance/today_attendance_cubit.dart';

/// Initializes the dependency injection for the attendance feature.
///
/// This function registers the repositories, data sources, use cases,
/// and BLoCs required for attendance functionality into the service locator.
void initAttendanceDI() {
  getIt.registerLazySingleton<AttendanceRepository>(
    () => AttendanceRepositoryImpl(
      getIt<AttendanceRemoteDataSource>(),
      getIt<AttendanceLocalDataSource>(),
    ),
  );

  getIt.registerLazySingleton<AttendanceRemoteDataSource>(
    () => AttendanceRemoteDataSourceImpl(getIt<ApiClient>()),
  );
  getIt.registerLazySingleton<AttendanceLocalDataSource>(
    () => AttendanceLocalDataSourceImpl(getIt<HiveInterface>()),
  );

  getIt.registerLazySingleton<FetchMonthlyAttendanceUseCase>(
    () => FetchMonthlyAttendanceUseCase(getIt<AttendanceRepository>()),
  );
  getIt.registerLazySingleton<FetchTodayAttendanceUseCase>(
    () => FetchTodayAttendanceUseCase(getIt<AttendanceRepository>()),
  );

  getIt.registerFactory<AttendanceBloc>(
    () => AttendanceBloc(getIt<FetchMonthlyAttendanceUseCase>()),
  );
  getIt.registerFactory<TodayAttendanceCubit>(
    () => TodayAttendanceCubit(getIt<FetchTodayAttendanceUseCase>()),
  );
}
