
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noteeapp/Data/repository/Authrepository.dart';
import 'package:noteeapp/Presentation/Pages/SigninScreen.dart';
import 'package:noteeapp/Presentation/Widgets/NoteCard.dart';
import 'package:noteeapp/bloc/Authbloc/auth_bloc.dart';
import 'package:noteeapp/bloc/Theme%20Bloc/bloc/cubit/theme_cubit.dart';
import 'package:noteeapp/bloc/userBloc/UserCubit.dart';
import '../../Data/repository/Model/NoteModel.dart';
import '../../bloc/NoteBLoc/note_bloc.dart';
import 'NoteDetailPage.dart';

class NoteHomePage extends StatelessWidget {
  final User? user = FirebaseAuth.instance.currentUser;
  final UserRepo = UserRepository();
  final userBloc = UserBloc(FirebaseAuth.instance.currentUser!.uid.toString());

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is UnAuthenticated) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => SigninScreen(),
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('logging out.'),
            ),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
       //  backgroundColor: Theme.of(context).,
          
         title: Text("Notee"),
          actions: [
            IconButton(
              icon: Icon(Icons.dark_mode_outlined),
              onPressed: () {
                context.read<ThemeCubit>().toggleTheme();
              },
            ),
          ],
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              UserAccountsDrawerHeader(
                accountName: BlocBuilder<UserBloc, UserBlocState?>(
                  bloc: userBloc,
                  builder: (context, Snapshot) {
                    return Text("Hi, ${Snapshot!.userName!}" ?? "User");
                  },
                ),
                accountEmail: Text(user?.email ?? ""),
                currentAccountPicture: BlocBuilder<UserBloc, UserBlocState?>(
                  bloc: userBloc,
                  builder: (context, userData) {
                    if (userData == null) {
                      return CircularProgressIndicator();
                    } else if (userData.photoUrl != null) {
                      return CircleAvatar(
                        backgroundImage: NetworkImage(userData.photoUrl!),
                        radius: 30.0, // Adjust the size as needed
                      );
                    } else {
                      return Icon(
                        Icons.person,
                        color: Colors.blue,
                        size: 48.0,
                      );
                    }
                  },
                ),
              ),
              ListTile(
                leading: Icon(Icons.home),
                title: Text("Home"),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(Icons.logout),
                title: Text("Logout"),
                onTap: () {
                  context.read<AuthBloc>().add(SignoutRequestEvent());
                },
              ),
            ],
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            context.read<NoteBloc>().add(FetchNotesEvent());
          },
          child: BlocBuilder<NoteBloc, NoteState>(
            builder: (context, state) {
              if (state is NoteLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is NoteLoadedState) {
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16.0,
                    mainAxisSpacing: 16.0,
                  ),
                  itemCount: state.notes.length,
                  itemBuilder: (context, index) {
                    final note = state.notes[index];
                    return NoteCard(note: note);
                  },
                );
              } else if (state is NoteErrorState) {
                return Center(
                  child: Text(state.errorMessage),
                );
              } else {
                return Center(
                  child: Column(
                    children: [
                      Text("No notes available."),
                      ElevatedButton(
                        onPressed: () {
                          context.read<NoteBloc>().add(FetchNotesEvent());
                        },
                        child: Icon(Icons.abc),
                      ),
                    ],
                  ),
                );
              }
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => NoteDetailPage(),
              ),
            );
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}

