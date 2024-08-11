import 'dart:developer';

import 'package:ai_courses_repository/ai_courses_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

part 'ask_question_event.dart';
part 'ask_question_state.dart';

class AskQuestionBloc extends Bloc<AskQuestionEvent, AskQuestionState> {
  AiCoursesRepo aiCoursesRepo;
  AskQuestionBloc(this.aiCoursesRepo) : super(AskQuestionInitial()) {
    on<AskQuestion>((event, emit) async{
      try {
        emit(AskQuestionLoading());
        String response = await aiCoursesRepo.getChatResponse(event.chatMessages);
        log("response = $response");
        emit(AskQuestionSuccess(response: response));
      } catch (e) {
        log(e.toString());
        emit(AskQuestionFailure(message: e.toString()));
      }
    });
  }
}
