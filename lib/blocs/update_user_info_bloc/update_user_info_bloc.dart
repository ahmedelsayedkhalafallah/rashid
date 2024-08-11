import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';

part 'update_user_info_event.dart';
part 'update_user_info_state.dart';

class UpdateUserInfoBloc extends Bloc<UpdateUserInfoEvent, UpdateUserInfoState> {
 final UserRepository _userRepository;
  UpdateUserInfoBloc(UserRepository userRepository) :_userRepository = userRepository, super(UpdateUserInfoInitial()) {
    on<UploadPicture>((event, emit) async{
      try {
        String userImageDownloadUrl = await _userRepository.uploadPicture(event.imageFilePath,event.userId);
        emit(UploadPictureSuccess(userImageDownloadUrl: userImageDownloadUrl));
      } catch (e) {
        emit(UploadPictureFailure(message: e.toString()));
      }
    });
  }
}
