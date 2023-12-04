import 'dart:convert';

class OpenChatRequest {
  Model? model;
  List<Messages>? messages;
  String? key;
  String? prompt;
  double? temperature;

  OpenChatRequest({
    this.model,
    this.messages,
    this.key,
    this.prompt,
    this.temperature,
  });

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (model != null) {
      data['model'] = model!.toJson();
    }
    if (messages != null) {
      data['messages'] = messages!.map((v) => v.toJson()).toList();
    }
    data['key'] = key;
    data['prompt'] = prompt;
    data['temperature'] = temperature;
    return data;
  }

  String toJson() {
    return jsonEncode(toMap());
  }

  factory OpenChatRequest.fromPrompt(String prompt) {
    return OpenChatRequest(
      model: Model(
        id: 'openchat_v3.2_mistral',
        name: 'OpenChat Aura',
        maxLength: 24576,
        tokenLimit: 8192,
      ),
      key: '',
      prompt: ' ',
      temperature: 0.5,
      messages: [
        Messages.fromUser(prompt),
      ],
    );
  }
}

class Model {
  String? id;
  String? name;
  int? maxLength;
  int? tokenLimit;

  Model({this.id, this.name, this.maxLength, this.tokenLimit});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['maxLength'] = maxLength;
    data['tokenLimit'] = tokenLimit;
    return data;
  }
}

class Messages {
  String? role;
  String? content;

  Messages({this.role, this.content});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['role'] = role;
    data['content'] = content;
    return data;
  }

  factory Messages.fromUser(String prompt) {
    return Messages(
      role: 'user',
      content: prompt,
    );
  }
}
