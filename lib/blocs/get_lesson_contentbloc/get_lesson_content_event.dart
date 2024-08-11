part of 'get_lesson_content_bloc.dart';

sealed class GetLessonContentEvent extends Equatable {
  const GetLessonContentEvent();

  @override
  List<Object> get props => [];
}
class GetLessonContent extends GetLessonContentEvent{
  final Lesson? lesson;
final Curriculum curriculum;
     final String courseTitle;final String unitTitle;final String lessonTitle;
     GetLessonContent( {required this.lesson ,required this.curriculum,required  this.courseTitle,required  this.unitTitle, required this.lessonTitle,});
}