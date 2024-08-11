import 'dart:developer';

import 'package:ai_courses_repository/ai_courses_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../constants/global.dart';

part 'make_single_syllable_event.dart';
part 'make_single_syllable_state.dart';

class MakeSingleSyllableBloc
    extends Bloc<MakeSingleSyllableEvent, MakeSingleSyllableState> {
  AiCoursesRepo aiCoursesRepo;
  Future<Curriculum> getCurriculum() async {
    Curriculum curriculum = await aiCoursesRepo.getSingleLevelCurriculum(
        learningTopic, learningPurpose, learningType);
    if (curriculum.levels.isNotEmpty) {
      if (curriculum.levels['1']!.courses.isNotEmpty &&
          curriculum.levels['1']!.courses['1'] != null) {
        String firstLessonTitle = curriculum
            .levels['1']!.courses['1']!.units['1']!.lessons['1']!.title;
        if (firstLessonTitle == 'Lesson 1' || firstLessonTitle == 'lesson 1') {
          return Curriculum(accessId: '', levels: {});
        }
      } else {
        return Curriculum(accessId: '', levels: {});
      }
    } else {
      return Curriculum(accessId: '', levels: {});
    }

    return curriculum;
  }

  MakeSingleSyllableBloc(this.aiCoursesRepo)
      : super(MakeSingleSyllableInitial()) {
    on<CreateSingleSyllable>((event, emit) async {
      emit(MakeSingleSyllableloading());
      bool isValid = false;
      try {
        for (int i = 1; i < 4; i++) {
          isValid = await aiCoursesRepo.validateTopicAndPurpose(
              learningTopic, learningPurpose);
          if (isValid) {
            break;
          }
        }
        if (!isValid) {
          emit(MakeSingleSyllableTopicNotValid());
        }
      } catch (e) {
        log(e.toString());
        rethrow;
      }
      if (isValid) {
        try {
          Curriculum finalCurriculum =  Curriculum.empty;
          while (finalCurriculum.levels.isEmpty) {
            try {
              Curriculum curriculum = await getCurriculum();
              finalCurriculum = finalCurriculum.copyWith(
                  accessId: curriculum.accessId,
                  levels: curriculum.levels,
                  curriculumPurpose: curriculum.curriculumPurpose,
                  curriculumTopic: curriculum.curriculumTopic,
                  curriculumType: curriculum.curriculumType);
            } catch (e) {}
          }
          emit(MakeSingleSyllableSuccess(curriculum: finalCurriculum));
        } catch (e) {
          log(e.toString());
          Curriculum finalExceptionCurriculum = Curriculum.empty;
          while (finalExceptionCurriculum.levels.isEmpty) {
            try {
              Curriculum exceptionCurriculum = await getCurriculum();
              finalExceptionCurriculum = finalExceptionCurriculum.copyWith(
                  accessId: exceptionCurriculum.accessId,
                  levels: exceptionCurriculum.levels,
                  curriculumPurpose: exceptionCurriculum.curriculumPurpose,
                  curriculumTopic: exceptionCurriculum.curriculumTopic,
                  curriculumType: exceptionCurriculum.curriculumType);
            } catch (e) {}
          }
          emit(MakeSingleSyllableSuccess(curriculum: finalExceptionCurriculum));
        }
      }
    });
  }
}
