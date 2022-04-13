import 'dart:async';

import 'package:altkamul/app/questions/data/models/AnswersModel.dart';
import 'package:altkamul/app/questions/data/models/QuestionsModel.dart';
import 'package:altkamul/app/questions/data/repositories/question_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';

import 'bloc.dart';

class QuestionBloc extends Bloc<QuestionEvent, QuestionState> {
  final QuestionRepository _repository;

  QuestionBloc(this._repository) : super(QuestionInitial());

  Stream<QuestionState> mapEventToState(
    QuestionEvent event,
  ) async* {
    if (event is GetAllQuestions) {
      try {
        yield LoadingState();

        QuestionsModel model =
            await _repository.getAllQuestions(pageSize: event.pageSize);

        yield QuestionsLoadedSuccess(model);
      } on DioError catch (e) {
        yield ErrorState(e.message);
      } catch (e) {
        yield ErrorState(e.toString());
      }
    }

    if (event is GetAllNextQuestions) {

      try {
        yield LoadingState();
        QuestionsModel model =
            await _repository.getAllQuestions(pageSize: event.pageSize);

        yield QuestionsNexLoadedSuccess(model);
      } on DioError catch (e) {

        yield ErrorState(e.message);
      } catch (e) {

        yield ErrorState(e.toString());
      }
    }

    if (event is GeQuestionAnswers) {
      try {
        yield LoadingState();
        AnswersModel model =
            await _repository.geQuestionAnswers(questionId: event.questionId);
        yield AnswersLoadedSuccess(model);
      } on DioError catch (e) {
        yield ErrorState(e.message);
      } catch (e) {
        yield ErrorState(e.toString());
      }
    }
  }
}
