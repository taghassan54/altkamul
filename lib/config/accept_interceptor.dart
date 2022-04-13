import 'package:dio/dio.dart';

class AcceptInterceptor extends Interceptor {
  @override
  onRequest(RequestOptions options,RequestInterceptorHandler handler) async {
    options.headers['Accept'] = 'application/json';
    return super.onRequest(options, handler);
  }
}