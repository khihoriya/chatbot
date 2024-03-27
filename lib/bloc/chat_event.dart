import 'package:flutter/cupertino.dart';

@immutable
sealed class ChatEvent {

}


class ChatGenerateNewTextMessageEVent extends ChatEvent {
  final String inputmessage;
  ChatGenerateNewTextMessageEVent({
    required this.inputmessage
});
}