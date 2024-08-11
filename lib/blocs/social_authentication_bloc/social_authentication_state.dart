part of 'social_authentication_bloc.dart';

sealed class SocialAuthenticationState extends Equatable {
  const SocialAuthenticationState();
  
  @override
  List<Object> get props => [];
}

final class SocialAuthenticationInitial extends SocialAuthenticationState {}
final class SocialAuthenticationLoading extends SocialAuthenticationState {}
final class SocialAuthenticationSuccess extends SocialAuthenticationState {
  final MyUser myUser;
  SocialAuthenticationSuccess({required this.myUser});
}
final class SocialAuthenticationFailure extends SocialAuthenticationState {
  final String message;
  SocialAuthenticationFailure({required this.message});
}
