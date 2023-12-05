import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:knowledge_test/provides/llm_provider/llm_provider.dart';
import 'package:knowledge_test/provides/llm_provider/open_chat/model/open_chat_request.dart';

class OpenChatLLMProvider implements LLMProvider {
  static const url = 'https://openchat.team/api/chat';

  @override
  Future<String> prompt(String prompt) {
    return http
        .post(
          Uri.parse(url),
          body: OpenChatRequest.fromPrompt(prompt).toJson(),
        )
        .then((value) => utf8.decode(value.bodyBytes));
  }
}
