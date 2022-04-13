import 'package:altkamul/app/questions/data/models/AnswersModel.dart';
import 'package:altkamul/app/questions/data/models/QuestionsModel.dart';
import 'package:altkamul/config/dependencies_provider.dart';
import 'package:altkamul/config/user_session.dart';
import 'package:dio/dio.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class QuestionRepository {
  final Dio _client;
  final UserSession _session = DependenciesProvider.provide();

  QuestionRepository(this._client);

  getAllQuestions({required int pageSize}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.none) {
      return _session.getQuestions();
    }

    try {
      var response = await _client.get(
          '/questions?page=$pageSize&pagesize=20&key=U4DMV*8nvpm3EOpvf69Rxw((&site=stackoverflow&order=desc&sort=activity&filter=default');

      _session.saveQuestions(QuestionsModel.fromJson(response.data));
      return QuestionsModel.fromJson(response.data);
    } catch (ex) {
      rethrow;
    }
  }

  geQuestionAnswers({int? questionId}) async {

    try {
      var response = await _client.get(
          'questions/$questionId/answers?order=desc&sort=activity&site=stackoverflow');

      _session.saveQuestions(QuestionsModel.fromJson(response.data));
      return AnswersModel.fromJson(response.data);
    } catch (ex) {
      rethrow;
    }

  }
}
