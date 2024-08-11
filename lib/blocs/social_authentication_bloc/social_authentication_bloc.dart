import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';

part 'social_authentication_event.dart';
part 'social_authentication_state.dart';

class SocialAuthenticationBloc extends Bloc<SocialAuthenticationEvent, SocialAuthenticationState> {
  final UserRepository _userRepository;
  SocialAuthenticationBloc(UserRepository userRepository ):this._userRepository = userRepository, super(SocialAuthenticationInitial()) {
    on<signInWithGoogleEvent>((event, emit) async {
      emit(SocialAuthenticationLoading());
      try {
        MyUser myUser = await _userRepository.signInWithGoogle();
        emit(SocialAuthenticationSuccess(myUser: myUser));
      } catch (e) {
        emit(SocialAuthenticationFailure(message: e.toString()));
        rethrow;
      }
    });
  }
}
