// ignore_for_file: deprecated_member_use, unnecessary_new

import 'package:booking100/admin/adminhomepage.dart';
import 'package:booking100/screen/registerpage.dart';
import 'package:booking100/screen/resetpassword.dart';
import 'package:booking100/users/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


class LoginScreen extends StatefulWidget{
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _LoginScreen();
  }

}

class _LoginScreen extends State<LoginScreen>{
  //form key
final _formKey = GlobalKey<FormState>();

//editing controller
final TextEditingController emailController = new TextEditingController();
final TextEditingController passwordController = new TextEditingController();
bool isObscure = true;
//firebase
final _auth = FirebaseAuth.instance;
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
        // filled: true,
        // fillColor: Color.fromARGB(255, 216, 213, 213),
        prefixIcon: const Icon(Icons.mail),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Email",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(13)
          ),
        ),
      );

    //password field
    final passwordField = TextFormField(
      autofocus: false,
      controller: passwordController,
      obscureText: true,

      validator: (value){
        RegExp regex = new RegExp(r'^.{6,}$');
        if(value!.isEmpty){
          return("Please Enter Your Password");
        }
        if(!regex.hasMatch(value)){
          return("Invalid Password");
        }
        return null;
      },

      onSaved: (value){
        passwordController.text = value!;
      },
      textInputAction: TextInputAction.done,
       decoration: InputDecoration(
        prefixIcon: const Icon(Icons.key),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Password",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10)
          ),
        ),
      );
      
    final loginButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: const Color.fromARGB(255, 7, 2, 85),
      child: MaterialButton(
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: (){
          signIn(emailController.text, passwordController.text);
        },
        child: const Text("Login", textAlign: TextAlign.center,
        style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold,),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(34.0),
            child: Form(
              key: _formKey,
              child: 
                     Column(mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        const Text(
                        "INDERA MAHKOTA FUTSAL CENTRE", 
                        style: TextStyle(fontSize: 28, color: Color.fromARGB(255, 4, 52, 92), fontWeight: FontWeight.w600,),
                        textAlign: TextAlign.center,
                      ),
                SizedBox(
                            height: 200,
                            child: Image.asset("assets/IMFC.png", fit: BoxFit.contain,),
                          ),
                          const SizedBox(height: 35),
                          
                          emailField,
                          const SizedBox(height: 25,),
        
                          passwordField,
        
                           Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              GestureDetector(onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => const ResetPassword()));
                              },
                              child: Text("Forgot Password?",
                              style: TextStyle(fontSize: 15, color: Colors.blue[900]),
                                ),
                              ),
                            ],
                          ),
                         const SizedBox(height: 25,),
        
                          loginButton,
                          const SizedBox(height: 15,),
                          
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              const Text("Don't Have an Account?"),
                              GestureDetector(onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUpScreen()));
                              },
                              child: Text("Register Here",
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.blue[900]),
                                ),
                              ),
                            ],
                          )
                          ]
                    ),
              ),
            ),
        ),
        ),
      )
    );
  }

  //login func
void signIn(String email, String password) async{

  if(_formKey.currentState!.validate())
  {
      if(email == 'admin123@gmail.com' && password == '12345678')
    {
       Fluttertoast.showToast(msg: "Login Successful");
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const AdminHomePage()));
    }
    else{
       await _auth.signInWithEmailAndPassword(email: email, password: password)
    .then((uid) => {
     Fluttertoast.showToast(msg: "Login Successful"),
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const UserHomePage())),
    }).catchError((e)
    {
      Fluttertoast.showToast(msg: e!.message);
       });
    }
   
  }

}
}