
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:booking100/screen/loginscreen.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
class SplashScreen extends StatelessWidget {
  const SplashScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Column(
        children: <Widget>[
         Shimmer.fromColors(
              period: const Duration(milliseconds: 1800),
              baseColor: const Color.fromARGB(255, 3, 1, 37),
              highlightColor: const Color.fromARGB(255, 9, 88, 190),
              child: Container(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "IMFC",
                  style: TextStyle(
                    fontSize: 90.0,
                    fontFamily: 'Pacifico',
                    shadows: <Shadow>[
                      Shadow(
                        blurRadius: 18.0,
                        color: Colors.black87,
                        offset: Offset.fromDirection(120, 12)
                      )
                    ]
                  ),
                ),
              ),
         ),
        ],
      ),
      nextScreen: const LoginScreen(),
      splashIconSize: 230,
      duration: 2500,
      );
  }
}