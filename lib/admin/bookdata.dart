import 'package:booking100/admin/bookingreport.dart';
import 'package:booking100/model/dataparser.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BookingData extends StatefulWidget {
  final DocumentSnapshot documentSnapshot;
  const BookingData({Key? key, required this.documentSnapshot}) : super(key: key);

  @override
  State<BookingData> createState() => _BookingDataState(documentSnapshot);
}

class _BookingDataState extends State<BookingData> {
  final DocumentSnapshot documentSnapshot;
  _BookingDataState(this.documentSnapshot);

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
   return Scaffold(
      appBar: AppBar(
        title: const Text("INDERA MAHKOTA FUTSAL"),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 7, 2, 85),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 140, child: Image.asset("assets/lukaku.png")),
          const Text("Booking Details",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 26,
                  fontWeight: FontWeight.bold)),
          Container(
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
            height: 340,
            child: Stack(
              children: [
                Card(
                  elevation: 40,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(30),
                    child: Column(
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(DateParser.parseDateTimeyMdAddJM(documentSnapshot['bookdate'],),
                                  style: const TextStyle(
                                      fontSize: 22, color: Colors.black)),
                            ]),
                        const SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            const Text('Email: ',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black)),
                            Text(documentSnapshot['email'],
                                style: const TextStyle(
                                    fontSize: 20, color: Colors.black)),
                          ],
                        ),
                        const SizedBox(height: 25),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            const Text('Court ID: ',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black)),
                            Text(documentSnapshot['courtid'],
                                style: const TextStyle(
                                    fontSize: 20, color: Colors.black)),
                          ],
                        ),
                        const SizedBox(height: 25),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            const Text('Court Name: ',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black)),
                            Text(documentSnapshot['courtname'],
                                style: const TextStyle(
                                    fontSize: 20, color: Colors.black)),
                          ],
                        ),
                        const SizedBox(height: 25),
                         Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            const Text('Total Payment: ',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black)),
                            Text(documentSnapshot['courtprice'],
                                style: const TextStyle(
                                    fontSize: 20, color: Colors.black)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
           SizedBox(
                        width: 360,
                        height: 50,
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => BookingReportPdf(documentSnapshot: documentSnapshot)));
                            },
                            style: ElevatedButton.styleFrom(
                              primary: const Color.fromARGB(255, 7, 2, 85),
                            ),
                            child: const Text("Generate Pdf",
                            style: TextStyle(fontSize: 20))),
                      )
        ],
      ),
      
    );
  }
}

