import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:noteeapp/Data/repository/Authrepository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authrepo;
  AuthBloc(this.authrepo) : super(UnAuthenticated()) {
    on<AuthEvent>(_HandleAuth);
  }


FutureOr<void> _HandleAuth(AuthEvent event, Emitter<AuthState> emit) async {
  if (event is RegisterUserEvent) {
    try {
      await authrepo.registerWithUserInfo(
        email: event.email,
        password: event.password,
        name: event.name,
      );
      emit(Authenticated());
    } catch (e) {
      emit(AuthError(errormessage: e.toString()));
    }
  } else if (event is SigninRequestEvent) {
    try {
      await authrepo.signIn(email: event.email, password: event.password);
      emit(Authenticated());
    } catch (e) {
      emit(AuthError(errormessage: e.toString()));
    }
  } else if (event is SignoutRequestEvent) {
    print("Logging out...");
    emit(UnAuthenticated());
    await authrepo.signOut();
    print("Logged out.");
  }
}

  // FutureOr<void> _HandleAuth(AuthEvent event, Emitter<AuthState> emit) async {
  //   if (event is registerRequestEvent) {
  //     try {
  //       await authrepo.register(email: event.email, password: event.password);
  //       emit(Authenticated());
  //     } catch (e) {
  //       emit(AuthError(errormessage: e.toString()));
  //     }
  //   } else if (event is SigninRequestEvent) {
  //     try {
  //       await authrepo.signIn(email: event.email, password: event.password);
  //       emit(Authenticated());
  //     } catch (e) {
  //       emit(AuthError(errormessage: e.toString()));
  //     }
  //   } else if (event is SignoutRequestEvent) {
  //     print("Logging out...");
  //     emit(UnAuthenticated());
  //     await authrepo.signOut();
  //     print("Logged out.");
  //   }
  // }
}
