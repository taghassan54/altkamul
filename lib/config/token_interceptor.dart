
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:altkamul/config/user_session.dart';



class TokenInterceptor extends Interceptor {
  final UserSession userSession;

  TokenInterceptor(this.userSession);

  @override
  onRequest(RequestOptions options,RequestInterceptorHandler handler) async {
    if ( userSession.hasToken()) {
      var token =  userSession.token();
      if (token != null && token.isNotEmpty) {
        options.headers['authorization'] = 'Bearer $token';
        options.headers['token'] = token;
        // options.headers['token'] = '$token';

        debugPrint("token found.");
      }
    } else {
      debugPrint("token not found,ignored. probably a guest.");
    }
    return super.onRequest(options, handler);
  }
}