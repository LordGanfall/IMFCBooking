import 'package:booking100/users/homepage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final fullnameController = TextEditingController();
  final usernameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? _fullname = null;
  String? _username = null;

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    final double heightSpace = 10;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Edit Profile",
              style: GoogleFonts.lato(),
            ),
          ],
        ),
        elevation: 0.0,
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: Center(
          child: SingleChildScrollView(
              padding: EdgeInsets.all(10),
              child: Column(children: <Widget>[
                Stack(
                  children: [
                    Card(
                      // elevation: 20.0,
                      // shadowColor: Color(0x55434343),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Container(
                        color: Colors.white,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 30),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(height: 190),
                              // ignore: prefer_const_constructors
                              Form(
                                key: _formKey,
                                child: Column(
                                  children: [
                                    TextFormField(
                                      onChanged: (value) {
                                        setState(() {
                                          _fullname = value;
                                        });
                                      },
                                      cursorColor: Colors.white,
                                      textAlign: TextAlign.start,
                                      textAlignVertical:
                                          TextAlignVertical.center,
                                      controller: fullnameController,
                                      textInputAction: TextInputAction.next,
                                      decoration: InputDecoration(
                                        labelText: "Change fullname",
                                        prefixIcon: Icon(
                                          Icons.title,
                                          color: Colors.black54,
                                        ),
                                        border: InputBorder.none,
                                        suffixIcon: _fullname == null ||
                                                _fullname!.trim() == ''
                                            ? null
                                            : IconButton(
                                                onPressed: () {
                                                  updatefullname();
                                                },
                                                icon: Icon(Icons.save)),
                                      ),
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                    ),
                                    SizedBox(height: 10),
                                    TextFormField(
                                      onChanged: (value) {
                                        setState(() {
                                          _username = value;
                                        });
                                      },
                                      cursorColor: Colors.white,
                                      textAlign: TextAlign.start,
                                      textAlignVertical:
                                          TextAlignVertical.center,
                                      controller: usernameController,
                                      textInputAction: TextInputAction.next,
                                      decoration: InputDecoration(
                                        labelText: "Change Phone Number",
                                        prefixIcon: Icon(
                                          Icons.call,
                                          color: Colors.black54,
                                        ),
                                        border: InputBorder.none,
                                        suffixIcon: _username == null ||
                                                _username!.trim() == ''
                                            ? null
                                            : IconButton(
                                                onPressed: () {
                                                  updateusername();
                                                },
                                                icon: Icon(Icons.save)),
                                      ),
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                    ),
                                  ],
                                ),
                              ),

                              SizedBox(height: heightSpace),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.8),
                      child: Stack(
                        children: [
                          ClipRRect(
                              child: Image.network(
                                "https://media.istockphoto.com/photos/abstract-background-color-gradient-light-blue-white-picture-id1269552168?k=20&m=1269552168&s=612x612&w=0&h=rFTFroan14_py5CI8ZWuZNFYXuvizmbLESMavGx2NnA=",
                                height: 200,
                                width: double.infinity,
                                fit: BoxFit.fill,
                              ),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  topRight: Radius.circular(8))),
                          Center(
                              child: Padding(
                            padding: const EdgeInsets.only(top: 50.0),
                            child: Column(
                              children: [
                                CircleAvatar(
                                    radius: 50,
                                    child: Icon(
                                      Icons.person,
                                      size: 50,
                                    )),
                                SizedBox(height: 11),
                                // Text(user.uid, style: GoogleFonts.lato()),
                                Text(user.email!,
                                    style: GoogleFonts.lato(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold))
                              ],
                            ),
                          )),
                        ],
                      ),
                    ),
                  ],
                )
              ]))),
    );
  }

  Future updateData() async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(child: CircularProgressIndicator()));
    final user = FirebaseAuth.instance.currentUser!;

    FirebaseFirestore.instance.collection("user").doc(user.email).update({
      'fullname': fullnameController.text.trim(),
      'username': usernameController.text.trim()
    });
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => UserHomePage()));
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.green,
      content: Text("updated"),
      duration: Duration(milliseconds: 200),
    ));
  }

  Future updatefullname() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(child: CircularProgressIndicator()));
    final user = FirebaseAuth.instance.currentUser!;

    FirebaseFirestore.instance.collection("user").doc(user.email).update({
      'fullname': fullnameController.text.trim(),
    });
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => UserHomePage()));
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.green,
      content: Text("fullname updated"),
      duration: Duration(milliseconds: 200),
    ));
  }

  Future updateusername() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(child: CircularProgressIndicator()));
    final user = FirebaseAuth.instance.currentUser!;

    FirebaseFirestore.instance
        .collection("UserData")
        .doc(user.email)
        .update({'username': usernameController.text.trim()});
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => UserHomePage()));
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.green,
      content: Text("Phone Number updated"),
      duration: Duration(milliseconds: 200),
    ));
  }
}