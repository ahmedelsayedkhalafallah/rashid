part of 'my_user_bloc.dart';

enum MyUserStatus { loading, success, failure }

class MyUserState extends Equatable {
  final MyUserStatus? status ;
  final MyUser? myUser;
  final String? failureMessage;
  const MyUserState._({this.myUser, this.failureMessage,  this.status });
  MyUserState.loading() : this._(status: MyUserStatus.loading);
  MyUserState.success(MyUser myUser)
      : this._(myUser: myUser, status: MyUserStatus.success);
  MyUserState.failure(String failureMessage)
      : this._(failureMessage: failureMessage, status: MyUserStatus.failure);

  @override
  List<Object> get props => [];
}
