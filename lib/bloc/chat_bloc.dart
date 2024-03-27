import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chatbot/models/chat_message_model.dart';

import 'chat_event.dart';
import 'chat_state.dart';

import 'package:chatbot/repos/chat_repo.dart';


class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(ChatSucessState(messages: [])) {
    on<ChatGenerateNewTextMessageEVent>(chatGenerateNewTextMessageEVent);
  }

  List<ChatMessageModel> messagesss = [];
  bool generating = false;

  FutureOr<void> chatGenerateNewTextMessageEVent(
      ChatGenerateNewTextMessageEVent event, Emitter<ChatState> emit) async {
    messagesss.add(ChatMessageModel(
        role: "user", parts: [ChatPartModel(text: event.inputmessage)]));
    emit(ChatSucessState(messages: messagesss));
    generating = true;
    String generatedText = await ChatRepo.chatTextGeneration(messagesss);
    if (generatedText.length > 0) {
      messagesss.add(ChatMessageModel(
          role: 'model', parts: [ChatPartModel(text: generatedText)]));
      emit(ChatSucessState(messages: messagesss));

    }
    generating = false;
  }
}
