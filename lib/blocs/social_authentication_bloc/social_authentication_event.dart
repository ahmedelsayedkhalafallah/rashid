part of 'social_authentication_bloc.dart';

sealed class SocialAuthenticationEvent extends Equatable {
  const SocialAuthenticationEvent();

  @override
  List<Object> get props => [];
}

class signInWithGoogleEvent extends SocialAuthenticationEvent{}