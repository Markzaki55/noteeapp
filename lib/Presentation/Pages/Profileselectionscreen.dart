import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../bloc/ProfilePicBloc/UserProfileCubit.dart';
import '../../bloc/ProfilePicBloc/UserProfileState.dart';
import 'HomePage.dart';

class ProfileSelectionScreen extends StatelessWidget {
  final UserProfileCubit userProfileCubit;

  const ProfileSelectionScreen({required this.userProfileCubit});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Profile Photo'),
      ),
      body: BlocListener<UserProfileCubit, UserProfileState>(
        listener: (context, state) {
         if(state is UserProfilePhotoUploaded){
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => NoteHomePage(),
            ),
      );}
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              BlocBuilder<UserProfileCubit, UserProfileState>(
                builder: (context, state) {
                  if (state is UserProfileInitial) {
                    return Text('Select a profile photo');
                  } else if (state is UserProfilePhotoUploaded) {
                    return Column(
                      children: [
                        Image.network(state.photoUrl),
                        Text('Profile photo uploaded!'),
                      ],
                    );
                  }
                  return CircularProgressIndicator();
                },
              ),
              ElevatedButton(
                onPressed: () async {
                  try {
                    final pickedFile = await ImagePicker().pickImage(
                      source: ImageSource.gallery,
                    );
                    if (pickedFile != null) {
                      userProfileCubit
                          .selectProfilePhoto(File(pickedFile.path));
                    }
                  } catch (e) {
                    print('Error picking image: $e');
                  }
                },
                child: Text('Select Photo'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
