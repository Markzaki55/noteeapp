import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noteeapp/Data/repository/Authrepository.dart';

class UserBloc extends Cubit<UserBlocState?> {
  UserBloc(String userId) : super(null) {
    loadUserData(userId);
  }

  void loadUserData(String userId) async {
    try {
      final userName = await UserRepository().getUserName(userId);
      final photoUrl = await UserRepository().getUserProfilePhotoUrl(userId);
      emit(UserBlocState(userName!, photoUrl!)); // UserData is a custom class to hold user data
    } catch (e) {
      print('Error loading user data: $e');
      emit(null);
    }
  }
}



class UserBlocState {

  final String userName;
  final String? photoUrl;

  UserBlocState(this.userName, this.photoUrl);
}

