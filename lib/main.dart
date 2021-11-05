import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_skeleton/app.dart';
import 'package:flutter_skeleton/providers/main_api_provider.dart';
import 'package:flutter_skeleton/repositories/authentication_repository/src/authentication_repository.dart';

import 'repositories/authentication_repository/src/models/access_tokens.dart';
import 'repositories/user_repository/src/user_repository.dart';

void main() async {
  const _storage = FlutterSecureStorage();
  WidgetsFlutterBinding.ensureInitialized();

  final accessToken = await _storage.read(key: 'accessToken');
  final refreshToken = await _storage.read(key: 'refreshToken');
  final mainApiProvider = MainApiProvider();
  mainApiProvider.setTokens(AccessTokens(
    accessToken: accessToken,
    refreshToken: refreshToken,
  ));
  mainApiProvider.configureDio();

  return runApp(App(
    authenticationRepository: AuthenticationRepository(mainApiProvider.dio),
    userRepository: UserRepository(mainApiProvider.dio),
  ));
}
