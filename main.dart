import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// Project imports
import 'home_screen.dart';
import 'sign-up.dart';
import 'sign-in.dart';
import 'add_action.dart';

void main() async {
  // Connect to Firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const DailiesApp());
}

class DailiesApp extends StatefulWidget {
  const DailiesApp({Key? key}) : super(key: key);

  @override
  State<DailiesApp> createState() => _DailiesAppState();
}

class _DailiesAppState extends State<DailiesApp> {
  // This state manages whether the user is signed in for logic in app open page
  bool _userSignedIn = false;

  @override
  Widget build(BuildContext context) {
    // Manage the state for the condition on login screen or home screen
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        setState(() {
          _userSignedIn = false;
        });
      } else {
        setState(() {
          _userSignedIn = true;
        });
      }
    });
    // Return a Scaffold from the screen needed
    return MaterialApp(
      // This ternary expression is a simplified if statement
      home: _userSignedIn ? const Homescreen() : const SignIn(),
      routes: {
        'homescreen': (context) => const Homescreen(),
        'sign-in': (context) => const SignIn(),
        'sign-up': (context) => const SignUp(),
        'add-action': (context) => const AddAction(),
      },
    );
  }
}
