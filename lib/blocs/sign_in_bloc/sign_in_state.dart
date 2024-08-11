part of 'sign_in_bloc.dart';

sealed class SignInState extends Equatable {
  const SignInState();
  
  @override
  List<Object> get props => [];
}

final class SignInInitial extends SignInState {}
class SignInCheck extends SignInState {}
class SignInUserExist extends SignInState {
  final MyUser? myUser;

  const SignInUserExist({required this.myUser});
}
class SignInUserDoesNotExist extends SignInState {}
class SignInLoading extends SignInState {}
class SignInSuccess extends SignInState {}
class SignInFailure extends SignInState {
  final String? message;

  const SignInFailure({required this.message});
} 
class SignOut extends SignInState {}
