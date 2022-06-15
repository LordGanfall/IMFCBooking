import 'dart:developer';

import 'package:booking100/users/bookinglist.dart';
import 'package:booking100/users/sidebar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Schedule extends StatefulWidget {
  const Schedule({Key? key}) : super(key: key);

  @override
  State<Schedule> createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  @override
  Widget build(BuildContext context) {
   return Scaffold(
       appBar: AppBar(
      title: const Text("INDERA MAHKOTA FUTSAL"),
      centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 7, 2, 85),
        elevation: 0,
      ),
      body: Column(
        children: const [
          Text('Court Schedule', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),),
          
            Flexible(child: MyBookingList()),
        ],
      ),
      drawer: const NavigationDrawer(),
    );
  }
  Widget buildLists(Book mybook) => GestureDetector(
    onTap: (){},
    child: Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      child: Material(
        elevation: 20.0,
        shadowColor: Colors.black,
        child: ListTile(
      
          title: Text(mybook.courtid, style: const TextStyle(color: Colors.black),),
          subtitle: Text(mybook.bookdate),
          ),
      ),
    ),
  );
  
  Stream<List<Book>> getBookedList() => FirebaseFirestore.instance
      .collection('booked')
      .snapshots()
      .map((snapshot) => snapshot.docs.map((doc) {
            log(doc.id);
            // log('called getBookedList ');
            return Book.fromJson(doc.data());
          }).toList());
}
class Book {
  final String bookdate;
  final String courtid;
  final String bookid;
  final String courtname;
  final String email;

  Book({
    required this.bookdate,
    required this.courtid,
    required this.bookid,
    required this.courtname,
    required this.email,
  });

  static Book fromJson(Map<String, dynamic> json) => Book(
        bookdate: json['bookdate'],
        courtid: json['courtid'],
        bookid: json['bookid'],
        courtname: json['courtname'],
        email: json['email'],
      );

  Map<String, dynamic> toJson() => {
        'courtid': courtid,
        'bookdate': bookdate,
        'bookid': bookid,
        'courtname': courtname,
        'email': email,
      };
}