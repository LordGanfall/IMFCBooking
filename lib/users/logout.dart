// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'package:booking100/screen/loginscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LogoutAlert extends StatefulWidget {
  const LogoutAlert({Key? key}) : super(key: key);

  @override
  State<LogoutAlert> createState() => _LogoutAlertState();
}

class _LogoutAlertState extends State<LogoutAlert> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Log Out'),
      content: const Text('You will be return to login screen.'),
      actions: <Widget>[
        FlatButton(
          child: const Text('Cancel',
          style: TextStyle(color: Colors.blue)),
          onPressed: (){Navigator.of(context).pop();
          }, 
          ),
        FlatButton(
          child: const Text('Log Out',
          style: TextStyle(color: Colors.red)),
          onPressed: () => logout(context)
          ),
      ],
      elevation: 20.0,
    );
  }
  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginScreen()));
  }
}