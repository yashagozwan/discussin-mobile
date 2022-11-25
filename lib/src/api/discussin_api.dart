import 'package:dio/dio.dart';
import 'package:discussin_mobile/src/service/shared_service.dart';

class _DioInterceptor extends Interceptor {
  final _sharedService = SharedService();

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await _sharedService.getToken();

    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    super.onRequest(options, handler);
  }
}

class DiscussinApi {
  static const _baseUrl = 'http://35.78.120.202';

  Dio getClient() {
    final dio = Dio();
    dio.interceptors.add(_DioInterceptor());
    dio.options.baseUrl = _baseUrl;
    return dio;
  }
}
