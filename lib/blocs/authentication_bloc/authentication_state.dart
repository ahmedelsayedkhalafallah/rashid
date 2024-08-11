part of 'authentication_bloc.dart';

enum AuthenticationStatus{ authenticated,notVerified, unauthenticated, unknown}
class AuthenticationState extends Equatable{
final AuthenticationStatus status;

final MyUser? myUser;

const AuthenticationState._({
  this.status = AuthenticationStatus.unknown,

  this.myUser
});

 const AuthenticationState.unknown() : this._();

 const AuthenticationState.authenticated()
  : this._(status: AuthenticationStatus.authenticated);

  const AuthenticationState.unauthenticated()
  : this._(status: AuthenticationStatus.unauthenticated);

    const AuthenticationState.notVerified(MyUser myUser)
  : this._(status: AuthenticationStatus.notVerified, myUser: myUser);


  @override
  List<Object?> get props => [status];

}