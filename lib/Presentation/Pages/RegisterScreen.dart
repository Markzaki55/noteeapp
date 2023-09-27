// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:noteeapp/Presentation/Pages/HomePage.dart';
// import 'package:noteeapp/Presentation/Pages/SigninScreen.dart';
// import 'package:noteeapp/bloc/Authbloc/auth_bloc.dart';

// class RegisterScreen extends StatefulWidget {
//   @override
//   _RegisterScreenState createState() => _RegisterScreenState();
// }

// class _RegisterScreenState extends State<RegisterScreen> {
//   TextEditingController _emailController = TextEditingController();
//   TextEditingController _passwordController = TextEditingController();
//   bool _isPasswordVisible = false;

//   void _togglePasswordVisibility() {
//     setState(() {
//       _isPasswordVisible = !_isPasswordVisible;
//     });
//   }

//   @override
//   void dispose() {
//     _emailController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         color: Colors.grey.shade400,
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Icon(
//               Icons.lock,
//               size: 100,
//               color: Color.fromARGB(255, 108, 66, 156),
//             ),
//             Text(
//               'Register',
//               style: TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                   color: Color.fromARGB(255, 108, 66, 156)),
//             ),
//             SizedBox(height: 16),
//             TextFormField(
//               controller: _emailController,
//               decoration: InputDecoration(
//                 labelText: 'Email',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             SizedBox(height: 16),
//             TextFormField(
//               controller: _passwordController,
//               obscureText: !_isPasswordVisible,
//               decoration: InputDecoration(
//                 labelText: 'Password',
//                 border: OutlineInputBorder(),
//                 suffixIcon: IconButton(
//                   onPressed: _togglePasswordVisibility,
//                   icon: Icon(
//                     _isPasswordVisible
//                         ? Icons.visibility
//                         : Icons.visibility_off,
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(height: 16),
//             BlocListener<AuthBloc, AuthState>(
//               listener: (context, state) {
//                 if (state is AuthError) {
//                   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                     content: Text(state.errormessage),
//                     duration: Duration(seconds: 2),
//                     backgroundColor: Colors.red,
//                   ));
//                 } else if (state is Authenticated) {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => NoteHomePage()),
//                   );
//                 }
//               },
//               child: GestureDetector(
//                 onTap: () {
//                   String email = _emailController.text;
//                   String password = _passwordController.text;
//                   context.read<AuthBloc>().add(
//                         registerRequestEvent(email, password),
//                       );
//                 },
//                 child: Container(
//                   padding: const EdgeInsets.all(20),
//                   //    margin: const EdgeInsets.symmetric(horizontal: 5),
//                   decoration: BoxDecoration(
//                     color: Color.fromARGB(255, 108, 66, 156),
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: Center(
//                     child: Text(
//                       'Register',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 16,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             TextButton(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => SigninScreen()),
//                 );
//               },
//               child: Text('have an account? Signin here.'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noteeapp/Presentation/Pages/HomePage.dart';
import 'package:noteeapp/Presentation/Pages/SigninScreen.dart';
import 'package:noteeapp/bloc/Authbloc/auth_bloc.dart';

import '../../Data/repository/Model/Usermodel.dart';
import '../../bloc/ProfilePicBloc/UserProfileCubit.dart';
import 'Profileselectionscreen.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  bool _isPasswordVisible = false;
 

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.grey.shade400,
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.vpn_lock,
              size: 100,
              color: Colors.black,
            ),
            Text(
              'Register',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                   color: Colors.black,)
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _passwordController,
              obscureText: !_isPasswordVisible,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  onPressed: _togglePasswordVisibility,
                  icon: Icon(
                    _isPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Name', // Label for the name field
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            BlocListener<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is AuthError) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(state.errormessage),
                    duration: Duration(seconds: 2),
                    backgroundColor: Colors.black,
                  ));
                } else if (state is Authenticated) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProfileSelectionScreen(userProfileCubit: context.read<UserProfileCubit>())),
                  );
                }
              },
              child: GestureDetector(
                onTap: () {
                  String email = _emailController.text;
                  String password = _passwordController.text;
                  String name = _nameController.text;

                  // Create a User object with email, password, and name
                  User user =
                      User(email: email, password: password, name: name);

                  context.read<AuthBloc>().add(
                      RegisterUserEvent(user.email, user.password, user.name));
                },
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      'Register',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => SigninScreen()),
                );
              },
              child: Text('Have an account? Sign in here.'),
            ),
          ],
        ),
      ),
    );
  }
}
