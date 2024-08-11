part of 'make_single_syllable_bloc.dart';

sealed class MakeSingleSyllableEvent extends Equatable {
  const MakeSingleSyllableEvent();

  @override
  List<Object> get props => [];
}

class CreateSingleSyllable extends MakeSingleSyllableEvent{}
