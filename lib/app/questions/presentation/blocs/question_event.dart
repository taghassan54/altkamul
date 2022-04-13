import 'package:equatable/equatable.dart';

abstract class QuestionEvent extends Equatable {
  const QuestionEvent();
}

class GetAllQuestions extends QuestionEvent{
 final int pageSize;

  const GetAllQuestions({required this.pageSize});
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class GetAllNextQuestions extends QuestionEvent{
 final int pageSize;

  const GetAllNextQuestions({required this.pageSize});
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class GeQuestionAnswers extends QuestionEvent{
  final int? questionId;

  const GeQuestionAnswers({required this.questionId});
  @override
  // TODO: implement props
  List<Object?> get props => [];
}