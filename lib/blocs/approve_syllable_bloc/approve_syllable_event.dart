part of 'approve_syllable_bloc.dart';

sealed class ApproveSyllableEvent extends Equatable {
  const ApproveSyllableEvent();

  @override
  List<Object> get props => [];
}

class ApproveSyllable extends ApproveSyllableEvent{
  final MyUser? myUser;
  final Curriculum curriculum;
  ApproveSyllable({required this.curriculum, required this.myUser});
}