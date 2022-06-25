import 'package:booking100/model/user_model.dart';
import 'package:booking100/users/about.dart';
import 'package:booking100/users/courtdetails.dart';
import 'package:booking100/users/courtschedule.dart';
import 'package:booking100/users/mybooking.dart';
import 'package:booking100/users/profile.dart';
import 'package:booking100/users/selectcourt.dart';
import 'package:booking100/users/sidebar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserHomePage extends StatefulWidget {
  const UserHomePage({Key? key}) : super(key: key);

  @override
  State<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
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
        body: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            children: const [
              TopBar(),
              CardBooking(),
              SizedBox(height: 20),
              QuickAction(),
              QuoteCard(),
              SizedBox(height: 10),
            ],
          ),
        )),
        drawer: const NavigationDrawer());
  }
}

class QuickAction extends StatelessWidget {
  const QuickAction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      width: 370,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          Action(
            title: "My Booking",
            image: "assets/tuchel1.png",
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const MyBooking()));
            },
          ),
          Action(
              title: "Schedule",
              image: "assets/tuchel2.png",
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CourtSchedule()));
              }),
          Action(
              title: "Profile",
              image: "assets/tuchel3.png",
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const UserProfile()));
              }),
        ],
      ),
    );
  }
}

class Action extends StatelessWidget {
  final String title;
  final String image;
  final Function() onTap;
  final bool selected;
  const Action(
      {required this.title,
      required this.image,
      required this.onTap,
      this.selected = false,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 90, 167, 230),
                border: Border.all(width: 2, color: Colors.white38),
                borderRadius: BorderRadius.circular(12),
              ),
              child: ClipRRect(
                child: Image.asset(
                  image,
                  width: 110,
                  height: 110,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              title,
              style: TextStyle(
                  fontSize: 20,
                  color: selected ? const Color(0xffFF8527) : Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}


class TopBar extends StatelessWidget {
  const TopBar({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      ClipPath(
        clipper: MyClipper(),
        child: Container(
          padding: const EdgeInsets.fromLTRB(40, 0, 20, 0),
          height: 280,
          width: double.infinity,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromARGB(255, 7, 2, 85),
                    Color.fromARGB(255, 90, 167, 230),
                  ]),
              image: DecorationImage(
                  image: AssetImage("assets/snow.png"), fit: BoxFit.cover)),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: const <Widget>[
              Text(
                'Life Is Like Futsal, You Need Goals!',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              Image(
                image: AssetImage(
                  "assets/lotus.png",
                ),
                width: 230,
                fit: BoxFit.fitWidth,
                alignment: Alignment.centerLeft,
              ),
            ],
          ),
        ),
      )
    ]);
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 80);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 80);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}


class CardBooking extends StatefulWidget {
  const CardBooking({Key? key}) : super(key: key);
  @override
  State<CardBooking> createState() => _CardBookingState();
}

class _CardBookingState extends State<CardBooking> {
  @override
  Widget build(BuildContext context) {
    final searchButton = Material(
      elevation: 10,
      borderRadius: BorderRadius.circular(30),
      color: Colors.transparent,
      child: ElevatedButton.icon(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const SelectCourt()));
          },
          icon: const Icon(Icons.sports_soccer, size: 20, color: Colors.white),
          label: const Text(
            "Booking Now",
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
          style: ElevatedButton.styleFrom(
            primary: const Color.fromARGB(255, 90, 167, 230),
            side: const BorderSide(width: 1, color: Colors.white38),
            // side: BorderSide(color: Colors.black),
            fixedSize: const Size(200, 40),
          )),
    );
    return Stack(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Container(
              height: 140,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                        offset: Offset(0, 4),
                        blurRadius: 8,
                        color: Colors.black)
                  ]),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(
                    "assets/chelsea1.png",
                    width: 150.0,
                    height: 150.0,
                  ),
                  Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.fromLTRB(5, 20, 5, 5),
                        child: Text(
                          "Book Court & Play\nWith Your Friends Now",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              fontFamily: "BigBottom"),
                        ),
                      ),
                      const SizedBox(height: 10),
                      searchButton
                    ],
                  ),
                ],
              )),
        ),
      ],
    );
  }
}


class QuoteCard extends StatefulWidget {
  const QuoteCard({Key? key}) : super(key: key);

  @override
  State<QuoteCard> createState() => _QuoteCardState();
}

class _QuoteCardState extends State<QuoteCard> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      width: double.infinity,
      child: ListView(
        children: <Widget>[
          CarouselSlider(
            options: CarouselOptions(
              aspectRatio: 2,
              height: 150,
              enlargeCenterPage: true,
              autoPlay: true,
              autoPlayCurve: Curves.fastOutSlowIn,
              enableInfiniteScroll: true,
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              viewportFraction: 0.8
              ),
            items: [
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Container(
                margin: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                          offset: Offset(0, 4),
                          blurRadius: 8,
                          color: Colors.black)
                    ]),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(
                      "assets/mrlukaku.png",
                      width: 130.0,
                      height: 150.0,
                    ),
                        const Padding(
                          padding: EdgeInsets.fromLTRB(0, 20, 0, 5),
                          child: Text(
                            '"Jump off your kicking foot.\nAnd you have just one\nchance to make it good!"\n\n- Romelu Lukaku',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                fontFamily: "BigBottom"),
                          ),
                        ),
                      ],
                )),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Container(
                margin: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                          offset: Offset(0, 4),
                          blurRadius: 8,
                          color: Colors.black)
                    ]),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(
                      "assets/alonso.png",
                      width: 120.0,
                      height: 120.0,
                    ),
                        const Padding(
                          padding: EdgeInsets.fromLTRB(0, 20, 0, 5),
                          child: Text(
                            '"Passion is everything,\non the field and in life!"\n\n- Marcus Alonso',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                fontFamily: "BigBottom"),
                          ),
                        ),
                      ],
                )),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Container(
                margin: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                          offset: Offset(0, 4),
                          blurRadius: 8,
                          color: Colors.black)
                    ]),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(
                      "assets/rudiger2.png",
                      width: 120.0,
                      height: 120.0,
                    ),
                        const Padding(
                          padding: EdgeInsets.fromLTRB(0, 20, 0, 5),
                          child: Text(
                            '"Reach for the ball,\nfor the stars!"\n\n- Toni Rudiger',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                fontFamily: "BigBottom"),
                          ),
                        ),
                      ],
                )),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Container(
                margin: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                          offset: Offset(0, 4),
                          blurRadius: 8,
                          color: Colors.black)
                    ]),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(
                      "assets/werner.png",
                      width: 120.0,
                      height: 120.0,
                    ),
                        const Padding(
                          padding: EdgeInsets.fromLTRB(0, 20, 0, 5),
                          child: Text(
                            '"Be a winner. Stand for\nsomething. Always have\nclass, be humble!"\n\n- Timo Werner',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                fontFamily: "BigBottom"),
                          ),
                        ),
                      ],
                )),
              ),
            ] 
          )
        ],
      ),
    );
  }
}