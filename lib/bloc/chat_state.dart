import 'package:flutter/cupertino.dart';

import '../models/chat_message_model.dart';

@immutable
sealed class ChatState{}

  final class ChatInitial extends ChatState{}

  class ChatSucessState extends ChatState{
  final List<ChatMessageModel> messages;

  ChatSucessState({
  required this.messages
});
}
