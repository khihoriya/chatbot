import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chatbot/bloc/prompt/prompt_event.dart';
import 'package:chatbot/bloc/prompt/prompt_state.dart';

class PromptBloc extends Bloc<PromptEvent, PromptState> {
  PromptBloc() : super(PromptIntial()) {
on<PromptEvent>(promptEnteredEvent);
  }

  FutureOr<void> promptEnteredEvent(PromptEvent event, Emitter<PromptState> emit) {
  }
}