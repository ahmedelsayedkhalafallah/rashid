part of 'delete_curriculum_bloc.dart';

sealed class DeleteCurriculumState extends Equatable {
  const DeleteCurriculumState();
  
  @override
  List<Object> get props => [];
}

final class DeleteCurriculumInitial extends DeleteCurriculumState {}
final class DeleteCurriculumLoading extends DeleteCurriculumState {}
final class DeleteCurriculumSuccess extends DeleteCurriculumState {}
final class DeleteCurriculumFailure extends DeleteCurriculumState {
  final String message;
  DeleteCurriculumFailure({required this.message});
}
