import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:pokedex_app_flutter/app/data/repositories/authentication_repository/authentication_repository.dart';
import 'package:pokedex_app_flutter/app/entities/authentication_status.dart';
import 'package:pokedex_app_flutter/app/entities/user.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  final AuthenticationRepository _authenticationRepository;
  late StreamSubscription<AuthenticationStatus> _authenticationStatusSubscription;

  AuthenticationCubit({required AuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository,
        super(const AuthenticationState.unknown()) {
    Future.delayed(
        const Duration(seconds: 3), () => _authenticationStatusSubscription = _authenticationRepository.authenticationStatus.listen((status) => _authStatusChanged(status)));
  }

  @override
  Future<void> close() {
    _authenticationStatusSubscription.cancel();
    return super.close();
  }

  void _authStatusChanged(AuthenticationStatus authenticationStatus) async {
    switch (authenticationStatus) {
      case AuthenticationStatus.unauthenticated:
        return emit(const AuthenticationState.unauthenticated());
      case AuthenticationStatus.authenticated:
        final user = _authenticationRepository.getLoggedInUser;
        return emit(
          user != null ? AuthenticationState.authenticated(user) : const AuthenticationState.unauthenticated(),
        );
      case AuthenticationStatus.unknown:
        return emit(const AuthenticationState.unknown());
    }
  }

  void logout() {
    _authenticationRepository.logout();
  }
}
