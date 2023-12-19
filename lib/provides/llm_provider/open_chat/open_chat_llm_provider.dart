import 'package:flutter_openchat/flutter_openchat.dart';
import 'package:knowledge_test/provides/llm_provider/llm_provider.dart';

class OpenChatLLMProvider implements MyLLMProvider {
  final OpenChatTeamLLM llm;

  OpenChatLLMProvider({required this.llm});

  @override
  Future<String> prompt(String prompt) async {
    return llm.prompt(prompt);
  }
}
