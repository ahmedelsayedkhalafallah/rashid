import 'package:ai_courses_repository/ai_courses_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'get_lesson_content_event.dart';
part 'get_lesson_content_state.dart';

class GetLessonContentBloc extends Bloc<GetLessonContentEvent, GetLessonContentState> {
  AiCoursesRepo aiCoursesRepo;
  GetLessonContentBloc(this.aiCoursesRepo) : super(GetLessonContentInitial()) {
    on<GetLessonContent>((event, emit)async {
      try {
        emit(GetLessonContentLoading());
        Curriculum updatedCurriculum = await aiCoursesRepo.generateContent(event.lesson!, event.curriculum, event.courseTitle, event.unitTitle, event.lessonTitle);
        if(updatedCurriculum.accessId ==''){
          emit(GetLessonContentFailure(message: 'Curriculum not found'));
        }else{
          emit(GetLessonContentSuccess(curriculum: updatedCurriculum));
          emit(GetLessonContentInitial());
        }
      } catch (e) {
        emit(GetLessonContentFailure(message: e.toString()));
      }
    });
  }
}
