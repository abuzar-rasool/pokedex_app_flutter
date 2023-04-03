import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_app_flutter/app/data/repositories/authentication_repository/authentication_repository.dart';
import 'package:pokedex_app_flutter/core/faliure.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final AuthenticationRepository _authRepository;
  RegisterCubit({required AuthenticationRepository authenticationRepository})
      : _authRepository = authenticationRepository,
        super(RegisterInitial());

  Future<void> register(String email, String password) async {
    emit(RegisterLoading());
    try {
      await _authRepository.register(email, password);
      emit(RegisterSucess());
    } on Failure catch (e) {
      emit(RegisterFailure(errorMessage: e.message));
    }
  }
}
