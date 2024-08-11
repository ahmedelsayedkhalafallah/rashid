part of 'sign_in_bloc.dart';

sealed class SignInEvent extends Equatable {
  const SignInEvent();

  @override
  List<Object> get props => [];
}

class SignInRequired extends SignInEvent{
  final String email;
  final String Password;

  const SignInRequired(this.email, this.Password);
}

class SignInCheckUser extends SignInEvent{
  final String phoneNumber;

  const SignInCheckUser(this.phoneNumber);
}

class SignOutEvent extends SignInEvent{
  const SignOutEvent();
}