import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:pokedex_app_flutter/app/data/repositories/authentication_repository/authentication_repository.dart';
import 'package:pokedex_app_flutter/app/entities/authentication_status.dart';
import 'package:pokedex_app_flutter/app/entities/user.dart';
import 'package:pokedex_app_flutter/core/faliure.dart';
import 'package:pokedex_app_flutter/services/local_storage_service.dart';

class FirebaseAuthRepository implements AuthenticationRepository {
  final firebase.FirebaseAuth _auth;
  final _authenticationStreamController = StreamController<AuthenticationStatus>();
  final LocalStorageService _localStorageService;

  FirebaseAuthRepository({
    required LocalStorageService localStorageService
  }) : _auth = firebase.FirebaseAuth.instance, _localStorageService = localStorageService {
    _auth.authStateChanges().listen((user) {
      if (user != null) {
        _authenticationStreamController.add(AuthenticationStatus.authenticated);
      } else {
        _authenticationStreamController.add(AuthenticationStatus.unauthenticated);
      }
    });
  }

  @override
  User? get getLoggedInUser {
    if (_auth.currentUser != null) {
      return User(
        id: _auth.currentUser!.uid,
      );
    } else {
      return null;
    }
  }

  @override
  Future<void> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on firebase.FirebaseAuthException catch (e) {
      throw Failure(message: e.message!);
    } on Exception {
      throw Failure();
    }
  }

  @override
  Future<void> logout() async {
    await _localStorageService.clear();
    await _auth.signOut();
  }

  @override
  Future<void> register(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
    } on firebase.FirebaseAuthException catch (e) {
      throw Failure(message: e.message!);
    } on Exception {
      throw Failure();
    }
  }

  @override
  Stream<AuthenticationStatus> get authenticationStatus => _authenticationStreamController.stream;

  @override
  void dispose() => _authenticationStreamController.close();
}
