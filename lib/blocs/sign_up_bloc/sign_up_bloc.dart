import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:user_repository/user_repository.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final UserRepository _userRepository;
  SignUpBloc({
    required UserRepository userRepository,
  })  : _userRepository = userRepository,
        super(SignUpInitial()) {
    on<SignUpRequired>((event, emit) async {
      emit(SignUpProcess());
      try {
        MyUser myUser = await _userRepository.getUser(
            'phoneNumber', event.user.phoneNumber);
        if (myUser.email == '') {
          MyUser user =
              await _userRepository.signUp(event.user, event.password);

          if (user.email == '') {
            emit(SignUpFailure(message: "Email already in use"));
          } else {
            await _userRepository.setUserData(user);
            emit(SignUpSuccess());
          }
        } else {
          emit(SignUpFailure(message: "Phone already in use"));
        }
      } catch (e) {
        emit(SignUpFailure(message: e.toString()));
      }
    });
  }
}
