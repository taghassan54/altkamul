import 'package:altkamul/app/questions/data/models/QuestionsModel.dart';
import 'package:altkamul/app/questions/presentation/blocs/bloc.dart';
import 'package:altkamul/app/questions/presentation/widgets/answer_card.dart';
import 'package:altkamul/app/questions/presentation/widgets/question_card.dart';
import 'package:altkamul/app/questions/presentation/widgets/single_question_card.dart';
import 'package:altkamul/config/dependencies_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class SingleQuestionPage extends StatefulWidget {
  final Items item;

  SingleQuestionPage({Key? key, required this.item}) : super(key: key);

  @override
  State<SingleQuestionPage> createState() => _SingleQuestionPageState();
}

class _SingleQuestionPageState extends State<SingleQuestionPage> {
  late QuestionBloc _questionBloc;

  @override
  void initState() {
    _questionBloc = QuestionBloc(DependenciesProvider.provide());
    _questionBloc.add(GeQuestionAnswers(questionId: widget.item.questionId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("${widget.item.title}"),
      ),
      body: Column(
        children: [
          SizedBox(
            height: Get.height * 0.28,
            child: SingleQuestionCard(item: widget.item),
          ),
          SizedBox(
            height: Get.height * 0.61,
            child: BlocBuilder(
              builder: (context, state) {
                if (state is ErrorState) {
                  return Center(
                    child: Text("${state.message}"),
                  );
                }
                if (state is LoadingState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is AnswersLoadedSuccess) {
                  return ListView.builder(itemBuilder: (context, index) => AnswerCard(item:state.answers.items![index]),itemCount: state.answers.items!.length,);
                }
                return Container();
              },
              bloc: _questionBloc,
            ),
          )
        ],
      ),
    );
  }
}
