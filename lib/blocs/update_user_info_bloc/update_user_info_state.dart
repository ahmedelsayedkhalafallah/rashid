part of 'update_user_info_bloc.dart';

sealed class UpdateUserInfoState extends Equatable {
  const UpdateUserInfoState();
  
  @override
  List<Object> get props => [];
}

 class UpdateUserInfoInitial extends UpdateUserInfoState {}
  class UploadPictureLoading extends UpdateUserInfoState {}
 class UploadPictureFailure extends UpdateUserInfoState {
  final String message;
  UploadPictureFailure({ required this.message});
}
 class UploadPictureSuccess extends UpdateUserInfoState {
  final String userImageDownloadUrl;
  UploadPictureSuccess({ required this.userImageDownloadUrl});
}
