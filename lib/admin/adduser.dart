// ignore_for_file: unnecessary_new

import 'package:booking100/admin/userlist.dart';
import 'package:booking100/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddUser extends StatefulWidget {
  const AddUser({Key? key}) : super(key: key);

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  final _auth = FirebaseAuth.instance;

  //form key
  final _formKey = GlobalKey<FormState>();
  //editing controller
  final fullnameController = new TextEditingController();
  final usernameController = new TextEditingController();
  final emailController = new TextEditingController();
  final passwordController = new TextEditingController();
  final confirmpasswordController = new TextEditingController();
  

  @override
  Widget build(BuildContext context) {

    //fullname field
    final fullnameField = TextFormField(
      autofocus: false,
      controller: fullnameController,
      keyboardType: TextInputType.emailAddress,
      validator: (value){
        RegExp regex = new RegExp(r'^.{5,}$');
        if(value!.isEmpty){
          return("Full Name");
        }
        if(!regex.hasMatch(value)){
          return("Invalid Name(Min. 5 Character)");
        }
        return null;
      },
      onSaved: (value){
        fullnameController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.person_outline_sharp),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Full Name",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10)
          ),
        ),
      );

    //username field
    final usernameField = TextFormField(
      autofocus: false,
      controller: usernameController,
      keyboardType: TextInputType.emailAddress,
      validator: (value){
        RegExp regex = new RegExp(r'^.{3,}$');
        if(value!.isEmpty){
          return("username");
        }
        if(!regex.hasMatch(value)){
          return("Invalid username(Min. 3 Character)");
        }
        return null;
      },

      onSaved: (value){
        usernameController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.person_outline_sharp),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "username",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10)
          ),
        ),
      );

    //email field
    final emailField = TextFormField(
      autofocus: false,
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      validator: (value){
        if(value!.isEmpty){
          return ("Email");
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

    //password field
    final passwordField = TextFormField(
      autofocus: false,
      controller: passwordController,
      obscureText: true,
      validator: (value){
        RegExp regex = new RegExp(r'^.{6,}$');
        if(value!.isEmpty){
          return("Password");
        }
        if(!regex.hasMatch(value)){
          return("Invalid Password(Min. 6 Character)");
        }
        return null;
      },

      onSaved: (value){
        passwordController.text = value!;
      },
      textInputAction: TextInputAction.next,
       decoration: InputDecoration(
        prefixIcon: const Icon(Icons.key),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Password",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10)
          ),
        ),
      );


    final registerButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: const Color.fromARGB(255, 7, 2, 85),
      child: MaterialButton(
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: (){
          signUp(emailController.text, passwordController.text);
        },
        child: const Text("Add", textAlign: TextAlign.center,
        style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold,),
        ),
      ),
    );

     return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
      title: const Text("INDERA MAHKOTA FUTSAL"),
      centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 7, 2, 85),
        elevation: 0,
      ),
      body: Column(
        children: [
          SizedBox(height: 150, child: Image.asset("assets/alonso.png")),
          const Text("Add New User",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.bold)),
          Center(
            child: SingleChildScrollView(
              child: Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        const SizedBox(height: 30),

                        fullnameField,
                        const SizedBox(height: 20,),

                        usernameField,
                        const SizedBox(height: 20,),
                        
                        emailField,
                        const SizedBox(height: 20,),

                        passwordField,
                        const SizedBox(height: 20,),
                         
                        registerButton,
                        const SizedBox(height: 15,),
                      ],
                    ),
                  ),
                ), 
              ),
            ),
          ),
        ],
      ),
    );
  }

  void signUp(String email, String password) async
  {
    if(_formKey.currentState!.validate())
    {
      await _auth.createUserWithEmailAndPassword(email: email, password: password)
      .then((value) => {
        postDetailsToFirestore()
      }).catchError((e)
      {
        Fluttertoast.showToast(msg: e.message);
      });
    }
  }
  postDetailsToFirestore() async
  {
    //calling firestore //calling usermodel //sending value
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;
    UserModel userModel = UserModel();

    //writing all the value
    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.fullname = fullnameController.text;
    userModel.username = usernameController.text;
    userModel.password = passwordController.text;

    await firebaseFirestore
    .collection("user")
    .doc(user.uid)
    .set(userModel.toMap());
    Fluttertoast.showToast(msg: "New User Added");

    Navigator.pushAndRemoveUntil((context), MaterialPageRoute(builder: (context) => const UserList()), 
    (route) => false);
  }
}