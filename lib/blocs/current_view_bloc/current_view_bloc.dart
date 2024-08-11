import 'package:ai_courses_repository/ai_courses_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'current_view_event.dart';
part 'current_view_state.dart';

class CurrentViewBloc extends Bloc<CurrentViewEvent, CurrentViewState> {
  CurrentViewBloc() : super(CurrentViewInitial()) {
    on<CurrentViewEvent>((event, emit) {
      emit(CurrentViewInitial());
    });
    on<LaunchInitialView>((event, emit) {
      emit(CurrentViewInitial());
    });
    on<LaunchLearnToGetJobInputView>((event, emit) {
      emit(CurrentViewLearnToGetJobInput());
    });
    on<LaunchLearnToDoInputView>((event, emit) {
      emit(CurrentViewLearnToDoInput());
    });
    on<LaunchLearnToReseachInputView>((event, emit) {
      emit(CurrentViewLearnToResearchInput());
    });
    on<LaunchSelectCourseTypeInputView>((event, emit) {
      emit(CurrentViewSelectType());
    });
    on<LaunchLoadingCard>((event, emit) {
      emit(CurrentViewLoadingCard());
    });
    on<LaunchCurriculumLoaded>((event, emit) {
      emit(CurrentViewCurriculumLoaded(curriculum: event.curriculum));
    });
    on<LaunchTopicNotValid>((event, emit) {
      emit(CurrentViewTopicNotValid());
    });
    on<LaunchCurriculumView>((event, emit) {
      emit(CurrentViewCurriculumView(curriculum: event.curriculum));
    });
    on<LaunchExplainLessonView>((event, emit) {
      emit(CurrentViewExplainLessonView(curriculum: event.curriculum, lesson: event.lesson, courseTitle: event.courseTitle, unitTitle: event.unitTitle));
    });
    on<LaunchAskQuestionView>((event, emit) {
      emit(CurrentViewAskQuestionView(curriculum: event.curriculum, lesson: event.lesson, courseTitle: event.courseTitle, unitTitle: event.unitTitle));
    });
  }
}
