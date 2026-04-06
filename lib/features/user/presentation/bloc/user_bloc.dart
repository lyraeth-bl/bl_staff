import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/core.dart';
import '../../domain/entities/user_entity/user_entity.dart';
import '../../domain/usecases/fetch_me_use_case.dart';
import '../../domain/usecases/get_saved_user_detail_use_case.dart';
import '../../domain/usecases/save_user_detail_use_case.dart';

part 'user_bloc.freezed.dart';
part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc(
    this._fetchMeUseCase,
    this._getSavedUserDetailUseCase,
    this._saveUserDetailUseCase,
  ) : super(const UserState.initial()) {
    on<_Started>(_onStarted);
    on<_FetchUser>(_onFetchUser);
  }

  final GetSavedUserDetailUseCase _getSavedUserDetailUseCase;
  final SaveUserDetailUseCase _saveUserDetailUseCase;
  final FetchMeUseCase _fetchMeUseCase;

  void _onStarted(_Started event, Emitter<UserState> emit) {
    final savedUser = _getSavedUserDetailUseCase();

    if (savedUser != null) {
      emit(UserState.success(user: savedUser));
    } else {
      add(const UserEvent.fetchUser());
    }
  }

  Future<void> _onFetchUser(_FetchUser event, Emitter<UserState> emit) async {
    emit(const UserState.loading());

    final result = await _fetchMeUseCase();

    result.match((failure) => emit(UserState.failure(failure)), (user) async {
      await _saveUserDetailUseCase(user);
      emit(UserState.success(user: user));
    });
  }
}
