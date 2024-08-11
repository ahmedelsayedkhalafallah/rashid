import 'dart:developer';

import 'package:ai_courses_repository/ai_courses_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';

part 'delete_curriculum_event.dart';
part 'delete_curriculum_state.dart';

class DeleteCurriculumBloc extends Bloc<DeleteCurriculumEvent, DeleteCurriculumState> {
  AiCoursesRepo aiCoursesRepo;
  DeleteCurriculumBloc(this.aiCoursesRepo) : super(DeleteCurriculumInitial()) {
    on<DeleteCurriculum>((event, emit) async{
      try {
        emit(DeleteCurriculumLoading());
        await aiCoursesRepo.deleteCurriculum(event.curriculum, event.myUser);
        emit(DeleteCurriculumSuccess());
      } catch (e) {
        log(e.toString());
        emit(DeleteCurriculumFailure(message: e.toString()));
      }
    });
  }
}
