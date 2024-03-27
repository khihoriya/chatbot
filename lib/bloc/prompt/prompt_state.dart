import 'package:flutter/cupertino.dart';



@immutable
sealed class PromptState{}

final class PromptIntial extends PromptState{}

final class PromptGeneratingImageLoadState extends PromptState{}

final class PromptGeneratingImageErrorState extends PromptState{}

final class PromptGeneratingImageSuccessState extends PromptState{}

