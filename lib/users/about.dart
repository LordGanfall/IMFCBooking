import 'package:booking100/users/sidebar.dart';
import 'package:flutter/material.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("INDERA MAHKOTA FUTSAL"),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 7, 2, 85),
        elevation: 0,
      ),
      body: Center(
              child: Column(
                children: [
                  SizedBox(
                      height: 180,
                      child: Image.network(
                          'https://www.nicepng.com/png/detail/408-4083998_background-pic-4-kids-futsal-cartoon.png')),
                  const Text("About Us",
                      style: TextStyle(color: Colors.black, fontSize: 26)),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: 380,
                    height: 240,
                    decoration: const BoxDecoration(),
                    child: Card(
                      elevation: 15,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Column(
                        children: const <Widget>[
                          SizedBox(
                            height: 30,
                          ),
                          Text('Futsal Name : IMFC',
                              style: TextStyle(
                                  fontSize: 22, color: Colors.black)),
                          SizedBox(
                            height: 20,
                          ),
                          Text('Email : futsalpoloim8@gmail.com',
                              style: TextStyle(
                                  fontSize: 22, color: Colors.black)),
                          SizedBox(
                            height: 20,
                          ),
                          Text("Phone Number : 019-967 5377",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 22)),
                         SizedBox(
                            height: 20,
                          ),
                          Text("Facebook: Stadium Futsal POLO",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 22)),
                          
                        ],
                      ),
                    ),
                  ),
                 const SizedBox(height: 20),
                 
                ],
              ),
            ),
      drawer: const NavigationDrawer(),
    );
  }
}