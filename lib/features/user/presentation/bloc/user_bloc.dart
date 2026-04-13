import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/core.dart';
import '../../domain/entities/user_entity/user_entity.dart';
import '../../domain/usecases/fetch_me_use_case.dart';

part 'user_bloc.freezed.dart';
part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc(this._fetchMeUseCase) : super(const UserState.initial()) {
    on<_Started>(_onStarted);
    on<_FetchUser>(_onFetchUser);
  }

  final FetchMeUseCase _fetchMeUseCase;

  Future<void> _onStarted(_Started event, Emitter<UserState> emit) async {
    add(const UserEvent.fetchUser());
  }

  Future<void> _onFetchUser(_FetchUser event, Emitter<UserState> emit) async {
    final lastUserData = state.whenOrNull(
      success: (user) => user,
      failure: (_, lastUserData) => lastUserData,
    );

    emit(const UserState.loading());

    final result = await _fetchMeUseCase.call(forceRefresh: event.forceRefresh);

    result.match(
      (failure) =>
          emit(UserState.failure(failure: failure, lastUserData: lastUserData)),
      (user) => emit(UserState.success(user: user)),
    );
  }
}
