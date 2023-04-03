import 'package:pokedex_app_flutter/app/entities/authentication_status.dart';
import 'package:pokedex_app_flutter/app/entities/user.dart';

abstract class AuthenticationRepository {
  Stream<AuthenticationStatus> get authenticationStatus;
  Future<void> login(String email, String password);
  Future<void> register(String email, String password);
  Future<void> logout();
  User? get getLoggedInUser;
  void dispose();
}
