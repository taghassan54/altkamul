import 'package:altkamul/app/questions/presentation/pages/questions_page.dart';
import 'package:altkamul/config/dependencies_provider.dart';
import 'package:altkamul/config/global_app_bloc_delegate.dart';
import 'package:altkamul/config/user_session.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart'
as transitions_type;

void main() async {
  await GetStorage.init();
  DependenciesProvider.build();

  runApp( MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({Key? key}) : super(key: key);
  final UserSession _session = DependenciesProvider.provide();

  @override
  Widget build(BuildContext context) {
    Bloc.observer = SimpleBlocObserver();
    return GetMaterialApp(
      title: 'Flutter Demo',

      enableLog: true,
      defaultTransition: transitions_type.Transition.zoom,
      locale: Locale(_session.getLanguage()),
      fallbackLocale: Locale(_session.getLanguage()),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
home: const QuestionPage(),
    );
  }
}
