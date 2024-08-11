part of 'get_lesson_content_bloc.dart';

sealed class GetLessonContentState extends Equatable {
  const GetLessonContentState();
  
  @override
  List<Object> get props => [];
}

final class GetLessonContentInitial extends GetLessonContentState {}
final class GetLessonContentLoading extends GetLessonContentState {}
final class GetLessonContentSuccess extends GetLessonContentState {
  final Curriculum curriculum;
  GetLessonContentSuccess({required this.curriculum});
}
final class GetLessonContentFailure extends GetLessonContentState {
  final String message;
  GetLessonContentFailure({required this.message});
}
