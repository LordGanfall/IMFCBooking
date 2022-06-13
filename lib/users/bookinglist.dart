import 'dart:convert';

import 'package:booking100/users/bookinginfo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../model/dataparser.dart';

class MyBookingList extends StatefulWidget {
  const MyBookingList({Key? key}) : super(key: key);

  @override
  State<MyBookingList> createState() => _MyBookingListState();
}

class _MyBookingListState extends State<MyBookingList> {
  final user = FirebaseAuth.instance.currentUser!;
  final db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
     return Scaffold(
        backgroundColor: Colors.transparent,
        body: StreamBuilder<QuerySnapshot>(
          stream: db
                  .collection('user')
                  .doc(user.email)
                  .collection('booked')
                  .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
            return ListView.builder(
              itemCount: snapshot.hasData ? snapshot.data!.docs.length : 0,
              itemBuilder: (context, index) {
                final data = Book.fromSnapshot(snapshot.data!.docs[index]);

                var uid = snapshot.data!.docs[index];
                return buildLists(data, uid.id, context);
              },
            );
          }
        ),
     );
  }
  
  Widget buildLists(data, id, context) => GestureDetector(
    onTap: () async{
      Navigator.push(
        context, 
        MaterialPageRoute(builder: (context) => BookingInfo(
          bookdate: data.bookdate, 
          bookid: data.bookid, 
          courtid: data.courtid, 
          courtname: data.courtname,
           email: data.email,

        )));
    },
    child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
        child: Card(
            color: Colors.blueGrey[900],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: ListTile(
              leading: const Icon(
                Icons.assignment_outlined,
                color: Colors.white,
                size: 30,
              ),
              title: Text(
                data.bookid,
                style: const TextStyle(
                    color: Colors.blue,
                    // fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              subtitle: Text(DateParser.parseDateTimeyMMMMd(data.bookdate),
                  style: const TextStyle(color: Colors.blue, fontSize: 10)),
              trailing: Text(
                data.courtid,
                style: const TextStyle(
                    color: Colors.blue, 
                    // fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            )),
      ),
  );
  
}



class Book {
  String? bookid;
  Timestamp? bookdate;
  String? email;
  String? courtid;
  String? courtname;
  String? totalpayment;

  Book(
      {this.bookid,
      this.bookdate,
      this.email,
      this.courtid,
      this.courtname,
      this.totalpayment,});

  String toRawJson() => json.encode(toJson());

  factory Book.fromSnapshot(DocumentSnapshot snapshot) {
    final model = Book.fromJson(snapshot.data() as Map<String, dynamic>);
    return model;
  }

  factory Book.fromJson(Map<String, dynamic> json) => Book(
        totalpayment: json["totalpayment"],
        bookid: json["bookid"],
        bookdate: json["bookdate"],
        courtid: json["courtid"],
        courtname: json["courtname"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "bookdate": bookdate,
        "bookid": bookid,
      };
}