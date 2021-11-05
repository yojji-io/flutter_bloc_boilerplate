import 'package:dio/dio.dart';
import 'package:flutter_skeleton/repositories/authentication_repository/src/models/access_tokens.dart';

const baseUrl = 'https://dev-api.symptomatical.com/api/v1/';

class MainApiProvider {
  late Dio _dio;
  String? accessToken;
  String? refreshToken;

  static final MainApiProvider _instance = MainApiProvider._initialize();

  factory MainApiProvider() {
    return _instance;
  }

  get dio => _dio;

  MainApiProvider._initialize() {
    _dio = Dio(BaseOptions(
      baseUrl: baseUrl,
    ));
  }
  setTokens(AccessTokens? tokens) {
    accessToken = tokens?.accessToken;
    refreshToken = tokens?.refreshToken;
  }

  configureDio() {
    if (accessToken != null) {
      dio.options.headers['Authorization'] = 'Bearer $accessToken';
      dio.interceptors.clear();
      dio.interceptors.add(InterceptorsWrapper(
        onError: (DioError e, ErrorInterceptorHandler handler) async =>
            refreshTokenInterceptor(e, accessToken, refreshToken, handler),
      ));
    }
  }
}

refreshTokenInterceptor(
  DioError err,
  accessToken,
  refreshoToken,
  ErrorInterceptorHandler handler,
) =>
    print('refreshTokenInterceptor');
// refreshTokenInterceptor(
//   DioError err,
//   accessToken,
//   refreshoToken,
//   ErrorInterceptorHandler handler,
// ) async {
//   Dio dio = NetworkProvider().dio;
//   if (err.response == null) return;
//   if (err.response?.statusCode == HttpStatus.unauthorized &&
//       err.response?.data['message'] == TOKEN_EXPIRED_ERROR) {
//     try {
//       dio.interceptors.requestLock.lock();
//       dio.interceptors.responseLock.lock();
//       final newTokens = await AuthHttpProvider.refreshTokens(RefreshTokenDTO(
//         accessToken: accessToken,
//         refreshToken: refreshoToken,
//       ));
//       dio.interceptors.requestLock.unlock();
//       dio.interceptors.responseLock.unlock();

//       if (newTokens == null ||
//           newTokens['message'] == REFRESH_TOKEN_EXPIRED_ERROR ||
//           newTokens['message'] == USER_WAS_NOT_FOUND_ERROR) {
//         await deleteTokens();
//         Get.offAllNamed(WelcomeScreen.path);
//       }
//       await configureNetworkProvider(
//           newTokens['accessToken'], newTokens['refreshToken']);
//       await writeTokens(newTokens);
//       RequestOptions options = err.requestOptions;
//       options.headers['Authorization'] = dio.options.headers['Authorization'];
//       final res = await dio.fetch(options);
//       handler.resolve(res);

//       return res;
//     } catch (e) {
//       print('error when try to refresh token $e');
//     }
//   }
//   if (err.response?.statusCode == HttpStatus.unauthorized &&
//       err.response?.data['message'] == TOKEN_MALFORMED_ERROR) {
//     print('token malformed');
//   }
// }
