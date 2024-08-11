import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';

part 'my_user_event.dart';
part 'my_user_state.dart';

class MyUserBloc extends Bloc<MyUserEvent, MyUserState> {
  final UserRepository _userRepository;
  MyUserBloc(UserRepository userRepository) :
  _userRepository = userRepository, super(MyUserState.loading()) {
    on<GetMyUserEvent>((event, emit) async {
      
      try {
      
      MyUser myUser =  await userRepository.getCurrentUser();
        
      emit(MyUserState.success(myUser));
      
      } catch (e) {
        
        emit(MyUserState.failure( e.toString()));
        
        rethrow;
      }
    });
  }
}

