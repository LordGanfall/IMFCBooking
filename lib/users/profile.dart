import 'package:booking100/model/user_model.dart';
import 'package:booking100/users/sidebar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
    User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

    @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("user")
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: const Text("INDERA MAHKOTA FUTSAL"),
      centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 7, 2, 85),
        elevation: 0,
      ),
      body: SingleChildScrollView(
       child: Column(
          children: <Widget>[
            const SizedBox(height: 20),
            const Center(
              child: Text(
                "Your Profile",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(130, 10, 130, 0),
              child: Center(
                child: Image.asset("assets/pp.png"),
              ),
            ),
            const SizedBox(height: 30),
            Card(
          elevation: 8,
          shadowColor: const Color.fromARGB(255, 7, 2, 85),
          margin: const EdgeInsets.fromLTRB(30, 0, 30, 0),
          shape:  OutlineInputBorder(
              borderRadius: BorderRadius.circular(10), 
              borderSide: const BorderSide(color: Colors.white)
          ),
          child: ListTile(
            title: Text("Full Name:  ${loggedInUser.fullname}",
            style: const TextStyle(
              fontSize: 18
            ),
            ),
          ),
        ),
        Card(
          elevation: 8,
          shadowColor: const Color.fromARGB(255, 7, 2, 85),
          margin: const EdgeInsets.fromLTRB(30, 25, 30, 0),
          shape:  OutlineInputBorder(
              borderRadius: BorderRadius.circular(10), 
              borderSide: const BorderSide(color: Colors.white)
          ),
          child: ListTile(
            title: Text("Username:  ${loggedInUser.username}",
             style: const TextStyle(
              fontSize: 18
            ),),
          ),
        ),
        Card(
          elevation: 8,
          shadowColor: const Color.fromARGB(255, 7, 2, 85),
          margin: const EdgeInsets.fromLTRB(30, 25, 30, 20),
          shape:  OutlineInputBorder(
              borderRadius: BorderRadius.circular(10), 
              borderSide: const BorderSide(color: Colors.white)
          ),
          child: ListTile(
            title: Text("Email:  ${loggedInUser.email}",
             style: const TextStyle(
              fontSize: 18
            ),),
            
          ),
        ),       
        ],
        ),
       ),
      drawer: const NavigationDrawer(),
    );
  }
}