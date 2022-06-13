import 'package:booking100/admin/adminhomepage.dart';
import 'package:booking100/users/logout.dart';
import 'package:flutter/material.dart';

class AdminNavBar extends StatefulWidget {
  const AdminNavBar({Key? key}) : super(key: key);

  @override
  State<AdminNavBar> createState() => _AdminNavBarState();
}

class _AdminNavBarState extends State<AdminNavBar> {
 final padding = const EdgeInsets.symmetric(horizontal: 20);
  
  @override
  Widget build(BuildContext context) {
    const email = 'admin@gmail.com';
    const username = 'Admin IMFC';
    const urlImage = 'assets/textt.png';
    return Drawer(
      child: Material(
        color: const Color.fromARGB(255, 7, 2, 85),
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
            const SizedBox(height: 20),
            const Divider(color: Colors.white70, thickness: 1.0),
            const SizedBox(height: 20),
             buildMenuItem(
              text: 'Log Out',
              icon: Icons.exit_to_app,
              onClicked: () => selectedItem(context, 1),
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
            style: const TextStyle(fontSize: 20, color: Colors.white),),
            Text(email,
            style: const TextStyle(fontSize: 16, color: Colors.white),)
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
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => const AdminHomePage())); 
      break;
      case 1:
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => const LogoutAlert())); 
      break;
    }
    
  }
}