import 'package:booking100/model/user_model.dart';
import 'package:booking100/users/about.dart';
import 'package:booking100/users/courtdetails.dart';
import 'package:booking100/users/mybooking.dart';
import 'package:booking100/users/selectcourt.dart';
import 'package:booking100/users/sidebar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserHomePage extends StatefulWidget {
  
  const UserHomePage({Key? key}) : super(key: key);
  
  @override
  State<UserHomePage> createState() => _UserHomePageState();
  
}
class _UserHomePageState extends State<UserHomePage> {

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
            BookingCard(),
            QuickAction(),
            ImageQuote()
          ],
        ),
      )),

      drawer: const NavigationDrawer()
    );
  }
 } 



class BookingCard extends StatefulWidget {
  const BookingCard({ Key? key }) : super(key: key);

  @override
  State<BookingCard> createState() => _BookingCardState();
}

class _BookingCardState extends State<BookingCard> {

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
      final searchButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(50),
      color: Colors.black,
      child: ElevatedButton.icon(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => const SelectCourt()));
        },
        icon: const Icon(Icons.sports_soccer,
        size: 24,
        color: Colors.black),
        label: const Text("Booking Now",
        style: TextStyle(
          fontSize: 18,
          color: Colors.black),
        ),
        style: ElevatedButton.styleFrom(
          primary: Colors.white,
          // side: BorderSide(color: Colors.black),
          fixedSize: const Size(350, 50),
          
        )
      ),
    );

      return Container(
      margin: const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
      height: 180,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          gradient: const RadialGradient(
            colors: [Color.fromARGB(255, 11, 106, 184), Color.fromARGB(255, 7, 2, 85),],
            focal: Alignment.topCenter,
            radius: .85,
          )),
      padding: const EdgeInsets.all(25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Welcome ${loggedInUser.username},",
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          height: 1.25,
                          fontFamily: "BigBottom",
                          fontWeight: FontWeight.bold)),  
                          const Text("Let's Booking Now!",
                          style: TextStyle(
                          color: Colors.grey,
                          fontSize: 18,
                          height: 1.25,
                          fontFamily: "BigBottom",)),              
                ],
              ),
              Image.asset(
                "assets/ball.png",
                width: 60,
              )
            ],
          ),
          // const SizedBox(height: 15.0),
          // searchField,
          const SizedBox(height: 15.0),
          searchButton,
        ],
      ),
    );
  }
}

class QuickAction extends StatelessWidget {
  const QuickAction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      width: 355,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          Action(
            title: "My Booking",
            image:
                "https://thumbs.dreamstime.com/b/clipboard-checklist-icon-symbol-web-site-app-design-clipboard-checklist-icon-symbol-web-site-app-design-179944327.jpg",
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const MyBooking()));
            },
          ),
          Action(
              title: "Court Details",
              image:
                  "https://previews.123rf.com/images/ylivdesign/ylivdesign1609/ylivdesign160902001/62550450-futsal-or-indoor-soccer-field-icon-in-outline-style-on-a-white-background-vector-illustration.jpg",
              onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const CourtDetail()));
              }
              ),
          Action(
              title: "About Us",
              image:
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR0BteiZh_qkGFpbJPhPBq4hEXbVYh7X8XfoQZpMQTcjg3yJYnQCOcbgP-rok532z2RoxA&usqp=CAU",
              onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const AboutUs()));
              }
              ),
          
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
      {required this.title, required this.image, required this.onTap,this.selected = false,Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  border: Border.all(
                      width: 1, color: const Color.fromARGB(255, 17, 3, 83)),
                  borderRadius: BorderRadius.circular(3)),
              child: ClipRRect(
                child: Image.network(
                  image,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              height: 12.5,
            ),
            Text(
              title,
              style: TextStyle(
                  fontSize: 16,
                  color: selected ? const Color(0xffFF8527) : Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}

class ImageQuote extends StatefulWidget {
  const ImageQuote({Key? key}) : super(key: key);

  @override
  State<ImageQuote> createState() => _ImageQuoteState();
}

class _ImageQuoteState extends State<ImageQuote> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
    child: Column(children: [
      SizedBox(
                      height: 200,
                      child: Image.network(
                          'https://i.pinimg.com/736x/5b/7d/3f/5b7d3f77238e7354a7a4672d2edffa83--soccer-sayings-football-quotes.jpg')),
    ],)
    );
  }
}

// https://i.pinimg.com/736x/5b/7d/3f/5b7d3f77238e7354a7a4672d2edffa83--soccer-sayings-football-quotes.jpg