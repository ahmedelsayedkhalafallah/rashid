import 'dart:developer';

import 'package:ai_courses_repository/ai_courses_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rashid/constants/global.dart';
import 'package:user_repository/user_repository.dart';

part 'approve_syllable_event.dart';
part 'approve_syllable_state.dart';

class ApproveSyllableBloc extends Bloc<ApproveSyllableEvent, ApproveSyllableState> {
  AiCoursesRepo aiCoursesRepo;
  ApproveSyllableBloc(this.aiCoursesRepo) : super(ApproveSyllableInitial()) {
    on<ApproveSyllable>((event, emit)async {
      try {
        emit(ApproveSyllableLoading());
        Curriculum curriculum = await aiCoursesRepo.makeSyllableContent(event.curriculum);
        curriculum = curriculum.copyWith(curriculumPurpose: learningPurpose,curriculumTopic: learningTopic,curriculumType: learningType);
        emit(SavingSyllable());
        await aiCoursesRepo.saveCurriculum(curriculum,event.myUser,);
        emit(SyllableSavingSuccess(curriculum: curriculum));
      } catch (e) {
        emit(ApproveSyllableFailure(message: e.toString()));
        log(e.toString());
        rethrow;
      }
    });
  }
}
