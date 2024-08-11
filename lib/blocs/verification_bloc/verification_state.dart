part of 'verification_bloc.dart';

sealed class VerificationState extends Equatable {
  const VerificationState();
  
  @override
  List<Object> get props => [];
}

final class VerificationInitial extends VerificationState {}
final class VerificationSendCode extends VerificationState {}
final class VerificationSendFaild extends VerificationState {
  final String? message;
  VerificationSendFaild({required this.message});
}
final class VerificationSendSuccess extends VerificationState {}
final class VerificationMatching extends VerificationState {}
final class VerificationMatchingError extends VerificationState {}
final class VerificationMatchingSuccess extends VerificationState {}