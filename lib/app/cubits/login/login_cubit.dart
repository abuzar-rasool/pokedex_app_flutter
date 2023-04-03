import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_app_flutter/app/data/repositories/authentication_repository/authentication_repository.dart';
import 'package:pokedex_app_flutter/core/faliure.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthenticationRepository _authRepository;
  LoginCubit({ required AuthenticationRepository authRepository})  : _authRepository = authRepository, super(LoginInitial());

  Future<void> login(String email, String password) async {
    emit(LoginLoading());
    try {
      await _authRepository.login(email, password);
      emit(LoginSucess());
    } on Failure catch (e) {
      emit(LoginFailure(errorMessage: e.message));
    }
  }
}
