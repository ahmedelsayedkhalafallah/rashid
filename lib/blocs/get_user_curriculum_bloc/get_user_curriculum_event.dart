part of 'get_user_curriculum_bloc.dart';

sealed class GetUserCurriculumEvent extends Equatable {
  const GetUserCurriculumEvent();

  @override
  List<Object> get props => [];
}
class GetUserCurriculum extends GetUserCurriculumEvent{
  final MyUser? myUser;
  final bool? refresh;
  GetUserCurriculum({required this.myUser, required this.refresh});
}
