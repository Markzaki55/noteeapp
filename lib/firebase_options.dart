import 'package:firebase_core/firebase_core.dart';

Future<void> initializeFirebaseApp() async {
  await Firebase.initializeApp(
    name: 'NoteeApp',
    options: const FirebaseOptions(
        apiKey: "AIzaSyBjUDhjZxeP7Poutdl0fw-c35KBTNEV_Q0",
        authDomain: "noteeapp-61932.firebaseapp.com",
        projectId: "noteeapp-61932",
        storageBucket: "noteeapp-61932.appspot.com",
        messagingSenderId: "988414560609",
        appId: "1:988414560609:web:ba5550f7c97dafaa085d20"),
  );
}
