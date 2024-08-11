part of 'get_user_curriculum_bloc.dart';

sealed class GetUserCurriculumState extends Equatable {
  const GetUserCurriculumState();
  
  @override
  List<Object> get props => [];
}

final class GetUserCurriculumInitial extends GetUserCurriculumState {}
final class GetUserCurriculumLoading extends GetUserCurriculumState {}
final class GetUserCurriculumSuccess extends GetUserCurriculumState {
  final Map<String, Curriculum> userCurriculums;
  GetUserCurriculumSuccess({required this.userCurriculums});
}
final class GetUserCurriculumFailure extends GetUserCurriculumState {
  final String message;
  GetUserCurriculumFailure({required this.message});
}
