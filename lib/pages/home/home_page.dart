import 'package:flutter/material.dart';
import 'package:knowledge_test/data/model/question.dart';
import 'package:knowledge_test/pages/home/home_controller.dart';
import 'package:knowledge_test/pages/questions/questions_route.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late TextEditingController _controller;
  final GlobalKey<FormState> _form = GlobalKey();
  late HomeController homeController;
  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    homeController = context.read();
    return Scaffold(
      body: ListenableBuilder(
        listenable: homeController,
        builder: (context, snapshot) {
          return Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Expanded(
                        child: Center(
                      child: Form(
                        key: _form,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Bem vindo ao teste de conhecimento!',
                              style: Theme.of(context).textTheme.headlineLarge,
                            ),
                            Text(
                              'Digite o assunto que deseja testar seu conhecimento e click em gerar',
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            TextFormField(
                              controller: _controller,
                              decoration: const InputDecoration(
                                labelText: 'Digite o assunto',
                              ),
                              validator: (value) {
                                if ((value ?? '').isEmpty) {
                                  return 'Campo Obrigatório';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                    )),
                    SizedBox(
                      width: double.maxFinite,
                      child: ElevatedButton(
                        onPressed: homeController.loading ? null : _submit,
                        style: const ButtonStyle(
                          shape: MaterialStatePropertyAll(StadiumBorder()),
                        ),
                        child: const Text('Gerar e iniciar'),
                      ),
                    )
                  ],
                ),
              ),
              if (homeController.loading)
                Container(
                  color: Colors.black.withOpacity(0.5),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                )
            ],
          );
        },
      ),
    );
  }

  void _submit() {
    if (_form.currentState?.validate() == true) {
      homeController.loadQuestions(
        _controller.text,
        _goQuestionsPage,
      );
    }
  }

  void _goQuestionsPage(List<Question> value) {
    Future.delayed(Duration.zero, () {
      QuestionsRoute.open(context, value, _controller.text);
    });
  }
}
