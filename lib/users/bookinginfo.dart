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
  final String courtprice;

  const BookingInfo({
    Key? key,
    required this.bookid,
    required this.courtid,
    required this.courtname,
    required this.bookdate,
    required this.courtprice,
    required this.email,
  }) : super(key: key);

  @override
  State<BookingInfo> createState() => _BookingInfoState();
}

class _BookingInfoState extends State<BookingInfo> {
  User? user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
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
                  SizedBox(
                      height: 150, child: Image.asset("assets/mrlukaku.png")),
                  Center(
                    child: Text("Booking Info",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.lato(
                            fontSize: 28, color: Colors.black)),
                  ),
                  const SizedBox(height: 10),
                  // ignore: sized_box_for_whitespace
                  Container(
                    width: 400,
                    height: 350,
                    child: Card(
                      elevation: 40,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: Column(
                        children: [
                          const SizedBox(height: 10),
                          const Text('Booking ID',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 22)),
                          Text(
                            widget.bookid,
                            style: const TextStyle(
                                color: Colors.black, fontSize: 20),
                          ),
                          const SizedBox(height: 20),
                          const Divider(
                            color: Colors.grey,
                            thickness: 2.0,
                            indent: 30,
                            endIndent: 30,
                          ),
                          const SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('Email : ',
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.black)),
                                    Text(widget.email,
                                        style: const TextStyle(
                                            fontSize: 20, color: Colors.black)),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('Booking Date : ',
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.black)),
                                    Text(
                                        DateParser.parseDateTimeyMdAddJM(
                                            widget.bookdate),
                                        style: const TextStyle(
                                            fontSize: 20, color: Colors.black)),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('Court ID : ',
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.black)),
                                    Text(widget.courtid,
                                        style: const TextStyle(
                                            fontSize: 20, color: Colors.black)),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('Court Name : ',
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.black)),
                                    Text(widget.courtname,
                                        style: const TextStyle(
                                            fontSize: 20, color: Colors.black)),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('Total Payment : ',
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.black)),
                                    Text(widget.courtprice,
                                        style: const TextStyle(
                                            fontSize: 20, color: Colors.black)),
                                  ],
                                ),
                              ],
                            ),
                          ),
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
