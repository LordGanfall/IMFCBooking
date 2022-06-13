// ignore_for_file: unnecessary_new

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({ Key? key }) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {


//form key
final _formKey = GlobalKey<FormState>();

//editing controller
final TextEditingController emailController = new TextEditingController();
//firebase

  @override
  Widget build(BuildContext context) {

    //email field
    final emailField = TextFormField(
      autofocus: false,
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      validator: (value){
        if(value!.isEmpty){
          return ("Please Enter Your Email");
        }
        //re expression email validation
        if(!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]+").hasMatch(value)){
          return ("Invalid Email");
        }
        return null;
      },

      onSaved: (value){
        emailController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.mail),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Email",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10)
          ),
        ),
      );

    final resetButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: const Color.fromARGB(255, 7, 2, 85),
      child: MaterialButton(
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: resetPassword,
        child: const Text("Send", textAlign: TextAlign.center,
        style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold,),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
       appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black,),
          onPressed: (){Navigator.of(context).pop();
          },
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(30, 0, 30, 200),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      "Reset Password", 
                      style: TextStyle(fontSize: 36, color: Colors.black, fontWeight: FontWeight.w600,),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      "Enter the email associated with your account to change your password.", 
                      style: TextStyle(fontSize: 22, color: Colors.grey, fontWeight: FontWeight.w600,),
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(height: 80),
                    
                    emailField,
                    const SizedBox(height: 20,),
                    resetButton,
                  ],
                ),
              ),
            ), 
          ),
        ),
      ),
    );
}
 Future resetPassword() async{
   showDialog(
    context: context,
    barrierDismissible: false, 
    builder: (context) => const Center(child: CircularProgressIndicator()),
    );

   try{
   await FirebaseAuth.instance
   .sendPasswordResetEmail(email: emailController.text.trim());
   Fluttertoast.showToast(msg: 'Password Reset Email Sent');
   Navigator.of(context).popUntil((route) => route.isFirst);
   }on FirebaseAuthException catch(e){
     print(e);
     
     Navigator.of(context).pop();
   }
  }
}