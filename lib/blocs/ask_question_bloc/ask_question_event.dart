part of 'ask_question_bloc.dart';

sealed class AskQuestionEvent extends Equatable {
  const AskQuestionEvent();

  @override
  List<Object> get props => [];
}

class AskQuestion extends AskQuestionEvent{
  final List<Content> chatMessages;
  AskQuestion({required this.chatMessages});
}