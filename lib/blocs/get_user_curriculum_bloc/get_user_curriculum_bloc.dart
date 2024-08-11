import 'dart:developer';

import 'package:ai_courses_repository/ai_courses_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rashid/constants/global.dart';
import 'package:user_repository/user_repository.dart';

part 'get_user_curriculum_event.dart';
part 'get_user_curriculum_state.dart';

class GetUserCurriculumBloc extends Bloc<GetUserCurriculumEvent, GetUserCurriculumState> {
  AiCoursesRepo aiCoursesRepo;
  GetUserCurriculumBloc(this.aiCoursesRepo,) : super(GetUserCurriculumInitial()) {
    on<GetUserCurriculum>((event, emit) async{
      try {
        emit(GetUserCurriculumInitial());
        
        if(curriculums.isEmpty||event.refresh!){
          
Map<String, Curriculum> userCurriculums = await aiCoursesRepo.getUserCurriculums(event.myUser);
        emit(GetUserCurriculumSuccess(userCurriculums: userCurriculums));
        curriculums = userCurriculums;
        }else{
          emit(GetUserCurriculumSuccess(userCurriculums: curriculums));
        }
        
      } catch (e) {
        log(e.toString());
        emit(GetUserCurriculumFailure(message: e.toString()));
      }
    });
  }
}
