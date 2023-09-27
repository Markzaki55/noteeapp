import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Presentation/Pages/HomePage.dart';
import 'UserProfileState.dart';
class UserProfileCubit extends Cubit<UserProfileState> {
  final BuildContext context;

  UserProfileCubit(this.context) : super(UserProfileInitial());

  Future<void> selectProfilePhoto(File photo) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final photoFileName = 'profile_${user.uid}.jpg';
        final Reference storageReference =
            FirebaseStorage.instance.ref().child(photoFileName);
        final UploadTask uploadTask = storageReference.putFile(photo);

        await uploadTask.whenComplete(() async {
          final downloadUrl = await storageReference.getDownloadURL();
          emit(UserProfilePhotoUploaded(downloadUrl));

          // Navigate to HomePage when the photo is uploaded
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => NoteHomePage(),
            ),
          );
        });
      }
    } catch (e) {
      // Handle errors
      print('Error uploading photo: $e');
    }
  }
}