import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:user_repository/user_repository.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  UserRepository _userRepository;
  SignInBloc({required UserRepository userRepository}) :_userRepository = userRepository, super(SignInInitial()) {
    
    
    on<SignInCheckUser>((event, emit) async {
      emit(SignInCheck());
      try {
      MyUser myUser =   await _userRepository.getUser('phoneNumber', event.phoneNumber);
        if(myUser.email == ''){
          emit(SignInUserDoesNotExist());
        }else{
          emit(SignInUserExist(myUser: myUser));
        }
      }catch(e){
        emit(SignInFailure(message: e.toString()));
      }      
    });

       on<SignInRequired>((event, emit) async {
      emit(SignInLoading());
      try {
        await _userRepository.signInWithEmailAndPassword(event.email, event.Password);
        emit(SignInSuccess());
      }on FirebaseAuthException catch (e) {
        emit(SignInFailure(message: e.toString()));
      }catch(e){
        emit(SignInFailure(message: e.toString()));
      }      
    });


  on<SignOutEvent>((event,emit) async{
    await _userRepository.signOut();
    emit(SignOut());
  });
  }


}
