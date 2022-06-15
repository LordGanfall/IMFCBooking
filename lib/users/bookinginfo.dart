import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../model/dataparser.dart';

class BookingInfo extends StatefulWidget {
  final String bookid;
  final String courtid;
  final String courtname;
  final Timestamp bookdate;
  final String email;

  
  const BookingInfo({Key? key,
  required this.bookid,
  required this.courtid,
  required this.courtname,
  required this.bookdate,
  required this.email,
  }) : super(key: key);

  @override
  State<BookingInfo> createState() => _BookingInfoState();
}

class _BookingInfoState extends State<BookingInfo> {

   User? user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    // date1 == date;
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
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
                height: 600,
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                   const SizedBox(height: 30),
                    Center(
                      child: Text("Booking Info",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.lato(
                              fontSize: 28, color: Colors.black)),
                    ),
                    const SizedBox(height: 16),
                    // ignore: sized_box_for_whitespace
                    Container(
                       width: 380,
                    height: 280,
                      child: Card(
                        elevation: 16,
                        child: Column(
                          children: [
                           const Text(
                              'Booking ID',
                              style: TextStyle(color: Colors.black, fontSize: 26),
                          
                    ),
                    Text(
                      widget.bookid,
                      style: const TextStyle(color: Colors.black, fontSize: 20),
                    ),
                   const SizedBox(height: 35),
                   const Divider(thickness: 1, color: Colors.black),
                   const SizedBox(height: 35),
                     Text(
                      "Email: " + widget.email,
                      style: const TextStyle(color: Colors.black, fontSize: 20),
                    ),
                   const SizedBox(height: 5),
                    Text(
                      "Court: " + widget.courtid,
                      style: const TextStyle(color: Colors.black, fontSize: 20),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "Court: " + widget.courtname,
                      style: const TextStyle(color: Colors.black, fontSize: 20),
                    ),

                    const SizedBox(height: 5),
                    Text(
                      "Book Date: " +
                          DateParser.parseDateTimeyMdAddJM(widget.bookdate),
                      style: const TextStyle(color: Colors.black, fontSize: 20),
                    ),
                   const SizedBox(height: 5),
                  ],
                ),
              ),
                ),
                          ],
                        ),
                      ),
          ],
        ),
      ),
    );
  }
}