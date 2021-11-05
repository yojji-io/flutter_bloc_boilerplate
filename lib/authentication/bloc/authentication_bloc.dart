import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_skeleton/providers/main_api_provider.dart';
import 'package:flutter_skeleton/repositories/authentication_repository/authentication_repository.dart';
import 'package:flutter_skeleton/repositories/authentication_repository/src/models/access_tokens.dart';
import 'package:flutter_skeleton/repositories/user_repository/user_repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({
    required AuthenticationRepository authenticationRepository,
    required UserRepository userRepository,
  })  : _authenticationRepository = authenticationRepository,
        _userRepository = userRepository,
        super(const AuthenticationState.unknown()) {
    on<AuthenticationStatusChanged>(_onAuthenticationStatusChanged);
    on<AuthenticationLogoutRequested>(_onAuthenticationLogoutRequested);
    on<AuthenticationRequested>(_onAuthenticationRequested);
  }

  final AuthenticationRepository _authenticationRepository;
  final UserRepository _userRepository;
  late StreamSubscription<AuthenticationStatus>
      _authenticationStatusSubscription;

  @override
  Future<void> close() {
    _authenticationStatusSubscription.cancel();
    return super.close();
  }

  void _onAuthenticationStatusChanged(
    AuthenticationStatusChanged event,
    Emitter<AuthenticationState> emit,
  ) async {
    switch (event.status) {
      case AuthenticationStatus.unauthenticated:
        return emit(const AuthenticationState.unauthenticated());
      case AuthenticationStatus.authenticated:
        final apiProvider = MainApiProvider();
        apiProvider.setTokens(event.tokens);
        apiProvider.configureDio();

        final user = await _tryGetUser();
        return emit(user != null
            ? AuthenticationState.authenticated(user)
            : const AuthenticationState.unauthenticated());
      default:
        return emit(const AuthenticationState.unknown());
    }
  }

  void _onAuthenticationRequested(
    AuthenticationRequested event,
    Emitter<AuthenticationState> emit,
  ) async {
    print('reading secured storage for tokens');
    emit(const AuthenticationState.unauthenticated());
  }

  void _onAuthenticationLogoutRequested(
    AuthenticationLogoutRequested event,
    Emitter<AuthenticationState> emit,
  ) {
    final apiProvider = MainApiProvider();
    apiProvider.setTokens(const AccessTokens());
    apiProvider.configureDio();
    emit(const AuthenticationState.unauthenticated());
  }

  Future<User?> _tryGetUser() async {
    try {
      final User user = await _userRepository.getAuthenticatedUser();
      return user;
    } catch (_) {
      return null;
    }
  }
}
