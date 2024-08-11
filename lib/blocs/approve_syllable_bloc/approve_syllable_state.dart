part of 'approve_syllable_bloc.dart';

sealed class ApproveSyllableState extends Equatable {
  const ApproveSyllableState();
  
  @override
  List<Object> get props => [];
}

final class ApproveSyllableInitial extends ApproveSyllableState {}
final class ApproveSyllableLoading extends ApproveSyllableState {}
final class SavingSyllable extends ApproveSyllableState {}
final class SyllableSavingSuccess extends ApproveSyllableState {
  final Curriculum curriculum;
  SyllableSavingSuccess({required this.curriculum});
}
final class ApproveSyllableFailure extends ApproveSyllableState {
  final String message;
  ApproveSyllableFailure({required this.message});
}
