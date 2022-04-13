
import 'package:altkamul/app/questions/data/models/AnswersModel.dart';
import 'package:altkamul/app/questions/data/models/QuestionsModel.dart';
import 'package:get_storage/get_storage.dart';


const String TOKEN_KEY = "token";
const String LANGUAGE_KEY = "lang";
const FIRST_TIME_LAUNCH_KEY = "firstTimeLaunch";


class UserSession {
  final box = GetStorage();

  bool save() {

    return true;
  }

  saveLanguage({String lang = "en"}) {
    box.write(LANGUAGE_KEY, lang);
  }

  getLanguage() {
    return box.read(LANGUAGE_KEY) ?? 'en';
  }

  getFirstTime() {
    return box.read(FIRST_TIME_LAUNCH_KEY) ?? false;
  }

  setFirstTime() {
    return box.write(FIRST_TIME_LAUNCH_KEY, true);
  }

  /// this  function check if user has access token */
  bool hasToken() {
    return box.read(TOKEN_KEY) != null ? true : false;
  }

  /// this  function retrieve user  access token */
  String? token() {
    return box.read(TOKEN_KEY);
  }

  logout() {
    box.remove(TOKEN_KEY);
  }

  void saveQuestions(QuestionsModel questionsModel) {
    box.write('questions', questionsModel);
  }

  Object? getQuestions() {
   var questions=  box.read('questions')??[];

    return QuestionsModel.fromJson(questions);
  }

  void saveQuestionAnswers(AnswersModel answersModel) {}


}