import 'package:booking100/users/sidebar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TopBar extends StatelessWidget {
  const TopBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       drawer: const NavigationDrawer(),
      body: Column(
        children: <Widget>[
          ClipPath(
            clipper: MyClipper(),
            child: Container(
              padding: const EdgeInsets.fromLTRB(40, 50, 20, 0),
              height: 330,
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomLeft,
                  colors: [
                    Color.fromARGB(255, 51, 78, 196),
                    Color.fromARGB(255, 7, 2, 85),
                  ]
                ),
                // image: DecorationImage(
                //   image: AssetImage("assets/ball2.png")
                // )
              ),
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: const <Widget>[
                    Image(
                      image: AssetImage("assets/gg.png",),
                      width: 230,
                      fit: BoxFit.fitWidth,
                      alignment: Alignment.centerLeft,
                      ),
                      Positioned(
                        child: Text('Life Is Like Futsal, You Need Goals!',
                        style: TextStyle(color: Colors.white, fontSize: 20),))
                ],
              ),
            ),
          ),
        ]),
       
    );
  }
}

class MyClipper extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 80);
    path.quadraticBezierTo(
      size.width/2, size.height, size.width, size.height - 80);
      path.lineTo(size.width, 0);
      path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}