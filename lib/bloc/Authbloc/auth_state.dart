// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'auth_bloc.dart';

@immutable
abstract class AuthState extends Equatable {}

class UnAuthenticated extends AuthState{
  @override
 
  List<Object?> get props => [];

}
class Authenticated extends AuthState{
  @override
 
  List<Object?> get props => [];

}

class AuthError extends AuthState {
  String errormessage;
  AuthError({
    required this.errormessage,
  });
  @override
  
  List<Object?> get props => [];
}

