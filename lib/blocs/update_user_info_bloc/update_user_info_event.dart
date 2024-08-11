part of 'update_user_info_bloc.dart';

sealed class UpdateUserInfoEvent extends Equatable {
  const UpdateUserInfoEvent();

  @override
  List<Object> get props => [];
}

class UploadPicture extends UpdateUserInfoEvent{
  final String imageFilePath;
  final String userId;

  UploadPicture({required this.imageFilePath, required this.userId});
    @override
  List<Object> get props => [];
}