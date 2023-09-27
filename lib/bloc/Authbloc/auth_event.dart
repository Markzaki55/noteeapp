part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent  extends Equatable{
  @override
 
  List<Object?> get props => [];
}

class registerRequestEvent extends AuthEvent
{
  final String email;
  final String password;

  registerRequestEvent(this.email, this.password);
  @override
 
  List<Object?> get props => [email,password];
}
class SigninRequestEvent extends AuthEvent
{
  final String email;
  final String password;

  SigninRequestEvent(this.email, this.password);
  @override
 
  List<Object?> get props => [email,password];
}


class SignoutRequestEvent extends AuthEvent
{
  @override
 
  List<Object?> get props => [];
}

class RegisterUserEvent extends AuthEvent {
  final String email;
  final String password;
  final String name;

  RegisterUserEvent(this.email, this.password, this.name);

  

  @override
  List<Object?> get props => [email, password, name];
}
