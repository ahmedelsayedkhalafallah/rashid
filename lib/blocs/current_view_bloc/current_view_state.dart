part of 'current_view_bloc.dart';

sealed class CurrentViewState extends Equatable {
  const CurrentViewState();
  
  @override
  List<Object> get props => [];
}

final class CurrentViewInitial extends CurrentViewState {}
final class CurrentViewLearnToGetJobInput extends CurrentViewState {}
final class CurrentViewLearnToDoInput extends CurrentViewState {}
final class CurrentViewLearnToResearchInput extends CurrentViewState {}
final class CurrentViewSelectType extends CurrentViewState {}
final class CurrentViewLoadingCard extends CurrentViewState {}
final class CurrentViewCurriculumLoaded extends CurrentViewState {
  final Curriculum curriculum;
  CurrentViewCurriculumLoaded({required this.curriculum});
}
final class CurrentViewTopicNotValid extends CurrentViewState {}
final class CurrentViewCurriculumView extends CurrentViewState {
  final Curriculum curriculum;
  CurrentViewCurriculumView({required this.curriculum});
}
final class CurrentViewExplainLessonView extends CurrentViewState {
  final Curriculum curriculum;
  final Lesson? lesson;
  final String courseTitle;
  final String unitTitle;
  CurrentViewExplainLessonView({required this.curriculum, required this.lesson, required this.courseTitle, required this.unitTitle});
}
final class CurrentViewAskQuestionView extends CurrentViewState {
  final Curriculum curriculum;
  final Lesson? lesson;
  final String courseTitle;
  final String unitTitle;
  CurrentViewAskQuestionView({required this.curriculum, required this.lesson, required this.courseTitle, required this.unitTitle});
}