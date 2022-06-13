import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_flutter/qr_flutter.dart';

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
                    SizedBox(height: 30),
                    Center(
                      child: Text("Booking Info",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.lato(
                              fontSize: 18, color: Colors.black)),
                    ),
                    SizedBox(height: 16),
                    QrImage(
                      backgroundColor: Colors.white,
                      data: widget.bookid,
                      version: QrVersions.auto,
                      size: 200,
                      gapless: false,
                    ),
                    
                    SizedBox(height: 35),
                    Text(
                      widget.bookid,
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                    SizedBox(height: 35),
                    Divider(thickness: 1, color: Colors.black),
                    SizedBox(height: 35),
                     Text(
                      "Email: " + widget.email,
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "Court: " + widget.courtid,
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "Court: " + widget.courtname,
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),

                    SizedBox(height: 5),
                    Text(
                      "Book Date: " +
                          DateParser.parseDateTimeyMdAddJM(widget.bookdate),
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                    SizedBox(height: 5),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}