import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:noteeapp/Data/repository/Authrepository.dart';
import 'package:noteeapp/Data/repository/NoteService.dart';
import 'package:noteeapp/bloc/Authbloc/auth_bloc.dart';
import 'package:noteeapp/bloc/NoteBLoc/note_bloc.dart';
import 'package:noteeapp/bloc/ProfilePicBloc/UserProfileCubit.dart';
import 'package:noteeapp/bloc/userBloc/UserCubit.dart';

import 'Presentation/Pages/SigninScreen.dart';
import 'Theme/ThemeService .dart';
import 'bloc/Theme Bloc/bloc/cubit/theme_cubit.dart';
import 'firebase_options.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   // await initializeFirebaseApp();
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return RepositoryProvider<AuthRepository>(
//         create: (context) => AuthRepository(),
//         child: RepositoryProvider<NoteRepository>(
//           create: (context) => NoteRepository(),
//           child: RepositoryProvider<UserRepository>(
//             create: (context) => UserRepository(),
//             child: MultiBlocProvider(
//               providers: [
//                 BlocProvider<AuthBloc>(
//                   create: (context) =>
//                       AuthBloc(RepositoryProvider.of<AuthRepository>(context)),
//                 ),
//                 BlocProvider<NoteBloc>(
//                   create: (context) => NoteBloc(
//                       RepositoryProvider.of<NoteRepository>(context),
//                       RepositoryProvider.of<UserRepository>(context))..add(FetchNotesEvent()),
//                 ),
//               ],
//               child: MaterialApp(
//                 title: 'Flutter Demo',
//                 debugShowCheckedModeBanner: false,
//                 theme: ThemeData(
//                   // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//                   useMaterial3: true,
//                 ),
//                 home: SigninScreen(),
//               ),
//             ),
//           ),
//         ));
//   }
// }




void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await initializeblocstorage();
  // await initializeFirebaseApp();
  runApp(const MyApp());
}

Future<void> initializeblocstorage() async {
  WidgetsFlutterBinding.ensureInitialized();
   final appDocumentsDirectory = await path_provider.getApplicationDocumentsDirectory();
   final storageDirectory = Directory('${appDocumentsDirectory.path}/hydrated_bloc');
   
   if (!storageDirectory.existsSync()) {
     storageDirectory.createSync(recursive: true);
   }
   
   HydratedBloc.storage = await HydratedStorage.build(storageDirectory: storageDirectory);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<AuthRepository>(
      create: (context) => AuthRepository(),
      child: RepositoryProvider<NoteRepository>(
        create: (context) => NoteRepository(),
        child: RepositoryProvider<UserRepository>(
          create: (context) => UserRepository(),
          child: BlocProvider<ThemeCubit>( // Add this BlocProvider
            create: (context) => ThemeCubit(),
            lazy: false, // Initialize your ThemeCubit
            child: MultiBlocProvider(
              providers: [
                BlocProvider<AuthBloc>(
                  create: (context) =>
                      AuthBloc(RepositoryProvider.of<AuthRepository>(context)),
                ),
                BlocProvider<NoteBloc>(
                  create: (context) => NoteBloc(
                    RepositoryProvider.of<NoteRepository>(context),
                    RepositoryProvider.of<UserRepository>(context))..add(FetchNotesEvent()),
                ),
                BlocProvider<UserProfileCubit>
                (create: (context) => UserProfileCubit(context))
              ],
              child: Builder(
                builder:(BuildContext context) { 
                return MaterialApp(
                title: 'Flutter Demo',
                debugShowCheckedModeBanner: false,
                themeMode: context.watch<ThemeCubit>().getThemeData(),
                theme: ThemeService().lightTheme,
                darkTheme: ThemeService().darkTheme,
                home: SigninScreen(),
               );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}