sealed class PromptEvent{}

class PromptEnteredEvent extends PromptEvent{
  final String prompt;
  PromptEnteredEvent({
    required this.prompt
  });
}