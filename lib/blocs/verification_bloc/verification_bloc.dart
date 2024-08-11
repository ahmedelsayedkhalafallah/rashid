import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';

part 'verification_event.dart';
part 'verification_state.dart';

class VerificationBloc extends Bloc<VerificationEvent, VerificationState> {
  UserRepository _userRepository;
  VerificationBloc({required UserRepository userRepository}) :_userRepository = userRepository, super(VerificationInitial()) {
    
    
    on<SendVerificationCode>((event, emit) async{
      emit(VerificationSendCode());
      try {
     //  await _userRepository.sendPhoneNumberVerification(event.phoneNumber.toString());
      emit(VerificationSendSuccess());
      } catch (e) {
        emit(VerificationSendFaild(message: e.toString()));
        rethrow;
      }
    });

    on<VerifyCode>((event, emit) async{
      emit(VerificationMatching());
      try {
       await _userRepository.verifyPhoneNumber(event.smsCode,event.phoneNumber);
      emit(VerificationMatchingSuccess());
      } catch (e) {
        emit(VerificationMatchingError());
        rethrow;
      }
    });
  }
  }

  


