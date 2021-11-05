import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_skeleton/authentication/authentication.dart';
import 'package:flutter_skeleton/login/login.dart';
import 'package:flutter_skeleton/providers/main_api_provider.dart';
import 'package:flutter_skeleton/repositories/authentication_repository/authentication_repository.dart';
import 'package:flutter_skeleton/repositories/authentication_repository/src/dto/login_request_dto.dart';
import 'package:flutter_skeleton/repositories/authentication_repository/src/models/access_tokens.dart';
import 'package:formz/formz.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({
    required AuthenticationBloc authenticationBloc,
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        _authenticationBloc = authenticationBloc,
        super(const LoginState()) {
    on<LoginUsernameChanged>(_onUsernameChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
    on<LoginSubmitted>(_onSubmitted);
  }

  final AuthenticationRepository _authenticationRepository;
  final AuthenticationBloc _authenticationBloc;

  void _onUsernameChanged(
    LoginUsernameChanged event,
    Emitter<LoginState> emit,
  ) {
    final username = Username.dirty(event.username);
    emit(state.copyWith(
      username: username,
      status: Formz.validate([state.password, username]),
    ));
  }

  void _onPasswordChanged(
    LoginPasswordChanged event,
    Emitter<LoginState> emit,
  ) {
    final password = Password.dirty(event.password);
    emit(state.copyWith(
      password: password,
      status: Formz.validate([password, state.username]),
    ));
  }

  void _onSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    if (state.status.isValidated) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      try {
        final credentials = LoginRequestDto(
          email: state.username.value,
          password: state.password.value,
        );
        final tokens = await _authenticationRepository.login(credentials);

        _authenticationBloc.add(
          AuthenticationStatusChanged(AuthenticationStatus.authenticated,
              tokens: tokens),
        );
        emit(state.copyWith(status: FormzStatus.submissionSuccess));
      } catch (_) {
        emit(state.copyWith(status: FormzStatus.submissionFailure));
      }
    }
  }
}
