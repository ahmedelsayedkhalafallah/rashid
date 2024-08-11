part of 'current_view_bloc.dart';

sealed class CurrentViewEvent extends Equatable {
  const CurrentViewEvent();

  @override
  List<Object> get props => [];
}

class LaunchInitialView extends CurrentViewEvent{}
class LaunchLearnToGetJobInputView extends CurrentViewEvent{}
class LaunchLearnToDoInputView extends CurrentViewEvent{}
class LaunchLearnToReseachInputView extends CurrentViewEvent{}
class LaunchSelectCourseTypeInputView extends CurrentViewEvent{}
class LaunchLoadingCard extends CurrentViewEvent{}
class LaunchCurriculumLoaded extends CurrentViewEvent{
  final Curriculum curriculum;
  LaunchCurriculumLoaded({required this.curriculum});
}
class LaunchTopicNotValid extends CurrentViewEvent{}
class LaunchCurriculumView extends CurrentViewEvent{
   final Curriculum curriculum;
  LaunchCurriculumView({required this.curriculum});
}
class LaunchExplainLessonView extends CurrentViewEvent{
   final Curriculum curriculum;
   final Lesson? lesson;
   final String courseTitle;
  final String unitTitle;
  LaunchExplainLessonView({required this.curriculum, required this.lesson, required this.courseTitle, required this.unitTitle});
}

class LaunchAskQuestionView extends CurrentViewEvent{
   final Curriculum curriculum;
   final Lesson? lesson;
   final String courseTitle;
  final String unitTitle;
  LaunchAskQuestionView({required this.curriculum, required this.lesson, required this.courseTitle, required this.unitTitle});
}