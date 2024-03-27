class ChatMessageModel {
  final String role;
  final List<ChatPartModel> parts;

  ChatMessageModel({
    required this.role,
    required this.parts,
  });

  Map<String, dynamic> toJson() {
    return {
      "role": role,
      "parts": List<dynamic>.from(parts.map((x) => x.toJson())),
    };
  }

  factory ChatMessageModel.fromMap(Map<String, dynamic> map) {
    return ChatMessageModel(
      role: map['role'] ?? '',
      parts: List<ChatPartModel>.from(
        map['parts']?.map((x) => ChatPartModel.fromMap(x)) ?? [],
      ),
    );
  }
}

class ChatPartModel {
  final String text;

  ChatPartModel({
    required this.text,
  });

  Map<String, dynamic> toJson() {
    return {
      "text": text,
    };
  }

  factory ChatPartModel.fromMap(Map<String, dynamic> map) {
    return ChatPartModel(
      text: map['text'] ?? '',
    );
  }
}
