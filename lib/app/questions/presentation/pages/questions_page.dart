import 'package:altkamul/app/questions/data/models/QuestionsModel.dart';
import 'package:altkamul/app/questions/presentation/blocs/bloc.dart';
import 'package:altkamul/app/questions/presentation/pages/single_question_page.dart';
import 'package:altkamul/app/questions/presentation/widgets/question_card.dart';
import 'package:altkamul/config/dependencies_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class QuestionPage extends StatefulWidget {
  const QuestionPage({Key? key}) : super(key: key);

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage>
    with WidgetsBindingObserver {
  late QuestionBloc _questionBloc, _questionNextBloc;
  late ScrollController _scrollController;
  var loadNextLoading = false;
  int pageSize = 1;
  final List<Items>? _items = [];

  @override
  void initState() {
    _questionBloc = QuestionBloc(DependenciesProvider.provide());
    _questionNextBloc = QuestionBloc(DependenciesProvider.provide());
    _questionBloc.add(GetAllQuestions(pageSize: pageSize));

    _scrollController = ScrollController(keepScrollOffset: true);
    watchChange();
    super.initState();
  }

  @override
  void dispose() {
    _questionNextBloc.close();
    _questionBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        /* app Bar + load Next Loading */
        title: Column(
          children: [
            const Text("All Questions"),
            if (loadNextLoading)
              const Text(
                "load Next Loading ...",
                style: TextStyle(fontSize: 10),
              ),
          ],
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          /* watch state change */
          BlocListener(
            listener: (context, state) {
              if (state is QuestionsLoadedSuccess) {
                setState(() {
                  loadNextLoading = false;
                  _items!.addAll(state.questions.items!);
                });
              }
            },
            child: Container(),
            bloc: _questionBloc,
          ),
          BlocListener(
            listener: (context, state) {
              if (state is QuestionsNexLoadedSuccess) {
                setState(() {
                  loadNextLoading = false;
                  _items!.addAll(state.questions.items!);
                });
              }
            },
            child: Container(),
            bloc: _questionNextBloc,
          ),
          SizedBox(
            height: Get.height * 0.89,
            child: BlocBuilder(
              builder: (context, state) {
                /* handle error state */
                if (state is ErrorState) {
                  return Center(
                    child: Text("${state.message}"),
                  );
                }
                /* handle loadin state */
                if (state is LoadingState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                /* handle data loaded state */
                if (state is QuestionsLoadedSuccess) {
                  return ListView.builder(
                    controller: _scrollController,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                          onTap: () => Get.to(() => SingleQuestionPage(
                                item: _items![index],
                              )),
                          child: QuestionCard(
                            item: _items![index],
                          ));
                    },
                    itemCount: _items?.length,
                  );
                }


                return Container();
              },
              bloc: _questionBloc,
            ),
          ),
        ],
      ),
    );
  }

  void watchChange() {
    _scrollController.addListener(() async {
      if (!loadNextLoading) {
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          setState(() {
            loadNextLoading = true;
            pageSize = pageSize + 1;
          });

          _questionNextBloc.add(GetAllNextQuestions(pageSize: pageSize));

          await Future.delayed(const Duration(seconds: 2));
        }
      }
    });
  }
}
