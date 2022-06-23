import 'package:booking100/model/user_model.dart';
import 'package:booking100/users/homepage.dart';
import 'package:booking100/users/logout.dart';
import 'package:booking100/users/profile.dart';
import 'package:booking100/users/schedule.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NavigationDrawer extends StatefulWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  State<NavigationDrawer> createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {
  final padding = const EdgeInsets.symmetric(horizontal: 20);
    User? user =FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
    .collection("user")
    .doc(user!.uid)
    .get()
    .then((value){
      this.loggedInUser = UserModel.fromMap(value.data());
      setState(() {
        
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    final email = '${loggedInUser.email}';
    final username = '${loggedInUser.username}';
    const urlImage = 'assets/textt.png';
    return Drawer(
      child: Material(
        color: const Color.fromARGB(255, 11, 106, 184),
        child: ListView(
          padding: padding,
          children: <Widget>[
            buildHeader(
              urlImage: urlImage,
              username: username,
              email: email,
              onClicked: () {}
              // => Navigator.of(context).push(MaterialPageRoute(
              //   builder: (context) => const UserProfile()))
            ),
            const Divider(color: Colors.white70, thickness: 1.0),
            Container(
              padding: padding,
              child: Column(
                children: [
                  const SizedBox(height: 10),
               
            buildMenuItem(
              text: 'Home Page',
              icon: Icons.home,
              onClicked: () => selectedItem(context, 0),
            ),
            const SizedBox(height: 10),
            buildMenuItem(
              text: 'Court Schedule',
              icon: Icons.calendar_month,
              onClicked: () => selectedItem(context, 1),
            ),
            const SizedBox(height: 10),
            buildMenuItem(
              text: 'Profile',
              icon: Icons.person,
              onClicked: () => selectedItem(context, 2),
            ),
            const SizedBox(height: 20),
            const Divider(color: Colors.white70, thickness: 1.0),
            const SizedBox(height: 20),
             
          
             buildMenuItem(
              text: 'Log Out',
              icon: Icons.exit_to_app,
              onClicked: () => selectedItem(context, 3),
            ),
             ],
              ),
            ),
          ]
        ),
      ),
    );
  }

Widget buildHeader({
  required String urlImage,
  required String username,
   required String email,
   required VoidCallback onClicked
   }) =>
   InkWell(
     onTap: onClicked,
     child: Container(
        padding: padding.add(const EdgeInsets.symmetric(vertical: 10)),
        child: Column(
          children: [
            Image.asset(urlImage),
        const SizedBox(height: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(username,
            style: const TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),),
            Text(email,
            style: const TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),)
          ],
          )
          ],
        ),
     ),
   );


Widget buildMenuItem({
  required String text,
  required IconData icon,
  VoidCallback? onClicked
}){
  const color = Colors.white;
  const hovercolor = Colors.white70;

  return ListTile(
    leading: Icon(icon, color: color),
    title: Text(text, style: const TextStyle(color: color)),
    hoverColor: hovercolor,
    onTap: onClicked,
  );
}

  void selectedItem(BuildContext context, int index) {
    Navigator.of(context).pop();
    
    switch (index){
      case 0:
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => const UserHomePage())); 
      break;
      case 1:
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Schedule())); 
      break;
      case 2:
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => const UserProfile())); 
      break;
      case 3: //logout function
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => const LogoutAlert())); 
      break;
    }
    
  }
}