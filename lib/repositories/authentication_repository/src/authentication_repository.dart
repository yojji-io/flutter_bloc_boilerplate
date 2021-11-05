import 'package:dio/dio.dart';
import 'package:flutter_skeleton/repositories/authentication_repository/src/dto/login_request_dto.dart';
import 'package:retrofit/retrofit.dart';
import './models/access_tokens.dart';

part 'authentication_repository.g.dart';

@RestApi()
abstract class AuthenticationRepository {
  factory AuthenticationRepository(Dio dio) = _AuthenticationRepository;

  @POST("/auth/sign-in")
  Future<AccessTokens> login(@Body() LoginRequestDto credentials);

  @POST("/logout")
  Future<void> logout();
}
