part of 'delete_curriculum_bloc.dart';

sealed class DeleteCurriculumEvent extends Equatable {
  const DeleteCurriculumEvent();

  @override
  List<Object> get props => [];
}
class DeleteCurriculum extends DeleteCurriculumEvent{
  final Curriculum curriculum;
  final MyUser myUser;
  DeleteCurriculum({required this.curriculum, required this.myUser});
}