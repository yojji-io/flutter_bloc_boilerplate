part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AuthenticationStatusChanged extends AuthenticationEvent {
  const AuthenticationStatusChanged(
    this.status, {
    this.tokens,
  });

  final AuthenticationStatus status;
  final AccessTokens? tokens;

  @override
  List<Object> get props => [status];
}

class AuthenticationRequested extends AuthenticationEvent {}

class AuthenticationLogoutRequested extends AuthenticationEvent {}
