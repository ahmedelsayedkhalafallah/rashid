part of 'make_single_syllable_bloc.dart';

sealed class MakeSingleSyllableState extends Equatable {
  const MakeSingleSyllableState();
  
  @override
  List<Object> get props => [];
}

final class MakeSingleSyllableInitial extends MakeSingleSyllableState {}
final class MakeSingleSyllableloading extends MakeSingleSyllableState {}
final class MakeSingleSyllableTopicNotValid extends MakeSingleSyllableState {}
final class MakeSingleSyllableSuccess extends MakeSingleSyllableState {
  final Curriculum curriculum;
  MakeSingleSyllableSuccess({required this.curriculum});
}
final class MakeSingleSyllableFailure extends MakeSingleSyllableState {
  final String message;
  MakeSingleSyllableFailure({required this.message});
}