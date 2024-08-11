part of 'ask_question_bloc.dart';

sealed class AskQuestionState extends Equatable {
  const AskQuestionState();
  
  @override
  List<Object> get props => [];
}

final class AskQuestionInitial extends AskQuestionState {}
final class AskQuestionLoading extends AskQuestionState {}
final class AskQuestionSuccess extends AskQuestionState {
  final String response;
  AskQuestionSuccess({required this.response});
}
final class AskQuestionFailure extends AskQuestionState {
  final String message;
  AskQuestionFailure({required this.message});
}
