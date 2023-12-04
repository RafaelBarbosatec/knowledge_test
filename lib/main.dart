import 'package:flutter/material.dart';
import 'package:knowledge_test/data/questions_repository.dart';
import 'package:knowledge_test/pages/home/home_controller.dart';
import 'package:knowledge_test/pages/home/home_page.dart';
import 'package:knowledge_test/pages/questions/questions_route.dart';
import 'package:knowledge_test/provides/llm_provider/llm_provider.dart';
import 'package:knowledge_test/provides/llm_provider/open_chat/open_chat_llm_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<LLMProvider>(
          create: (context) => OpenChatLLMProvider(),
        ),
        Provider(
          create: (context) => QuestionRepository(llm: context.read()),
        ),
        ChangeNotifierProvider(
          create: (context) => HomeController(context.read()),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        routes: {
          '/': (context) => const HomePage(),
          ...QuestionsRoute.builder,
        },
      ),
    );
  }
}
