import 'package:pokedex_app_flutter/app/data/models/user_model.dart';


abstract class AuthRepository {

  Future<void> login(String email, String password);
  Future<void> register(String email, String password);
  Future<void> logout();
  Future<UserModel> getCurrentUser();
  UserModel? get getLoggedInUser;
}