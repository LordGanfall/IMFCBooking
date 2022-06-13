import 'package:booking100/try/editprofile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    const double heightSpace = 10;

    return Scaffold(
      backgroundColor: Colors.white54,
      body: Center(
          child: SingleChildScrollView(
              padding: const EdgeInsets.all(10),
              child: Column(children: <Widget>[
                Stack(
                  children: [
                    Card(
                      elevation: 50.0,
                      shadowColor: Color(0x55434343),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            // ignore: prefer_const_literals_to_create_immutables
                            colors: [
                              Colors.white,
                              Colors.white,
                            ],
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 40),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                             const  SizedBox(height: 300),
                              const SizedBox(height: heightSpace),
                              Card(
                                color: const Color.fromARGB(255, 7, 2, 85),
                                child: GestureDetector(
                                  onTap: () =>
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => EditProfile())),
                                  child: const ListTile(
                                    leading: Icon(Icons.edit, color: Colors.white,),
                                    title: Text('Edit Profile', style: TextStyle(color: Colors.white,)),
                                    trailing: Icon(Icons.arrow_forward, color: Colors.white,),
                                  ),
                                ),
                              ),
                              Card(
                                color: const Color.fromARGB(255, 7, 2, 85),
                                child: GestureDetector(
                                  onTap: () {},
                                  // => Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (context) => help_page())),
                                  child: const ListTile(
                                    leading: Icon(Icons.edit, color: Colors.white,),
                                    title: Text('Help Assistant', style: TextStyle(color: Colors.white,)),
                                    trailing: Icon(Icons.arrow_forward, color: Colors.white,),
                                  ),
                                ),
                              ),
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
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  topRight: Radius.circular(8)),
                              child: Image.network(
                                "https://www.kindpng.com/picc/m/8-83849_football-player-png-soccer-touch-transparent-png.png",
                                height: 300,
                                width: double.infinity,
                                fit: BoxFit.fill,
                              )),
                          Center(
                              child: Padding(
                            padding: const EdgeInsets.only(top: 50.0),
                            child: Column(
                              children: [
                               const SizedBox(height: 250),
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
}
