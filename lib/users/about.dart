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
            SizedBox(height: 150, child: Image.asset("assets/IMFC.png")),
            const Text("About IMFC",
                style: TextStyle(color: Colors.black, fontSize: 26)),
            const SizedBox(
              height: 10,
            ),
            Container(
              width: 400,
              height: 250,
              decoration: const BoxDecoration(),
              child: Card(
                elevation: 40,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const <Widget>[
                          Text('Futsal Name: ',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.black)),
                          Text('Indera Mahkota Futsal',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.black)),
                        ],
                      ),
                      const SizedBox(height: 25),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const <Widget>[
                          Text('Email: ',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.black)),
                          Text('futsalpoloim8@gmail.com',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.black)),
                        ],
                      ),
                      const SizedBox(height: 25),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const <Widget>[
                          Text('Phone Number: ',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.black)),
                          Text('019-967 5377',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.black)),
                        ],
                      ),
                      const SizedBox(height: 25),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const <Widget>[
                          Text('Facebook: ',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.black)),
                          Text('Stadium Futsal POLO',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.black)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      drawer: const NavigationDrawer(),
    );
  }
}
