import 'package:altkamul/app/questions/data/models/AnswersModel.dart';
import 'package:altkamul/app/questions/data/models/QuestionsModel.dart';
import 'package:equatable/equatable.dart';

abstract class QuestionState extends Equatable {
  const QuestionState();
}

class QuestionInitial extends QuestionState {
  @override
  List<Object> get props => [];
}
class ErrorState extends QuestionState {
  final String? message;

  const ErrorState(this.message);
  @override
  List<Object> get props => [];
}

class LoadingState extends QuestionState {
  @override
  List<Object> get props => [];
}

class QuestionsLoadedSuccess extends QuestionState {
 final QuestionsModel questions;

  const QuestionsLoadedSuccess(this.questions);
  @override
  List<Object> get props => [];
}
class QuestionsNexLoadedSuccess extends QuestionState {
 final QuestionsModel questions;

  const QuestionsNexLoadedSuccess(this.questions);
  @override
  List<Object> get props => [];
}
class AnswersLoadedSuccess extends QuestionState {
 final AnswersModel answers;

  const AnswersLoadedSuccess(this.answers);
  @override
  List<Object> get props => [];
}