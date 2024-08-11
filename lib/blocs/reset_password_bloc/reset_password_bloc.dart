import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';

part 'reset_password_event.dart';
part 'reset_password_state.dart';

class ResetPasswordBloc extends Bloc<ResetPasswordEvent, ResetPasswordState> {
  UserRepository _userRepository;
  ResetPasswordBloc(UserRepository userRepository) :_userRepository = userRepository, super(ResetPasswordInitial()) {
    on<SendResetLink>((event, emit) async {
      emit(ResetPasswordLoading());
      try {
        MyUser myUser = await _userRepository.getUser('email', event.email);
        if(myUser.email == ''){
          
          emit(ResetPasswordFailure(message:"User Not Registered" ));
          throw Exception("User Not Registered");
        }else{
          _userRepository.sendResetEmail(event.email);
          emit(ResetPasswordSuccess());
        }
      } catch (e) {
        emit(ResetPasswordFailure(message: e.toString()));
        log(e.toString());
        rethrow;
      }
    });
  }
}
