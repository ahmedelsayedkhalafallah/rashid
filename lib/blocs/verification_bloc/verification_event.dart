part of 'verification_bloc.dart';

sealed class VerificationEvent extends Equatable {
  const VerificationEvent();

  @override
  List<Object> get props => [];
}
class SendVerificationCode extends VerificationEvent{
   final String? phoneNumber;
  SendVerificationCode({required this.phoneNumber});
}

class VerifyCode extends VerificationEvent{
  final String smsCode;
  
  final String phoneNumber;
  VerifyCode(  {required this.phoneNumber, required this.smsCode});
}