import 'package:altkamul/app/questions/data/repositories/question_repository.dart';
import 'package:dio/dio.dart';

import 'package:get_it/get_it.dart';
import 'package:altkamul/config/accept_interceptor.dart';
import 'package:altkamul/config/token_interceptor.dart';
import 'package:altkamul/config/user_session.dart';

final getIt = GetIt.instance;

class DependenciesProvider {
  DependenciesProvider._();
  static void build() {

    final Dio client = Dio();
    final UserSession userSession = UserSession();
    String _baseUrl = 'https://api.stackexchange.com/2.3/';

    client.options = BaseOptions(
      baseUrl: _baseUrl,
      responseType: ResponseType.json,
    );
    client.options.headers['X-localization'] = 'ar';
    client.options.headers['Accept']='application/json';
    client.interceptors.add(LogInterceptor(
      request: true,
      responseBody: true,
      requestHeader: true,
      error: true,
      requestBody: true,
      responseHeader: true,
    ));
    client.interceptors.add(TokenInterceptor(userSession));
    client.interceptors.add(AcceptInterceptor());
    getIt.registerSingleton<UserSession>(userSession);
    getIt.registerSingleton<Dio>(client);

    getIt.registerFactory<QuestionRepository>(() => QuestionRepository(client));

  }

  static T provide<T extends Object>() {
    return getIt.get<T>();
  }
}