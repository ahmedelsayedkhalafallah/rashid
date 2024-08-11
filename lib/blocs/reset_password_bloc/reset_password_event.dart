part of 'reset_password_bloc.dart';

sealed class ResetPasswordEvent extends Equatable {
  const ResetPasswordEvent();

  @override
  List<Object> get props => [];
}

class SendResetLink extends ResetPasswordEvent{
  final String email;
  SendResetLink({required this.email});
}