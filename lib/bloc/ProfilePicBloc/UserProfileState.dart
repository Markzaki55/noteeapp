abstract class UserProfileState {}



class UserProfileInitial extends UserProfileState {}

class UserProfilePhotoUploaded extends UserProfileState {
  final String photoUrl;

  UserProfilePhotoUploaded(this.photoUrl);
}