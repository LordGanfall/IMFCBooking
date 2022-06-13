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
          Container(
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
            height: 220,
            child: Stack(
              children: [
                Positioned(
                  child: Material(
                    child: Card(
                    elevation: 10,
                    shadowColor: Colors.grey.withOpacity(0.5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)
                    ),
                      child: Container(
                        height: 200,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    )
                  )
                ),
                Positioned(
                  child: Card(
                    elevation: 0,
                    child: Container(
                      height: 200,
                      width: 130,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: const DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage('assets/icon.png'))),
                    ),
                  )),
                  Positioned(
                    top: 30,
                    left: 130,
                    child: Container(
                      height: 150,
                      width: 250,
                      child: Column(
                        children: [
                           Text(DateParser.parseDateTimeyMdAddJM(documentSnapshot['bookdate']), 
                          style: const TextStyle(color: Colors.black, 
                          fontSize: 18, 
                          fontWeight: FontWeight.w500)),
                          const Divider(color: Colors.black, thickness: 1.0),

                          Row(
                            children: [
                              Text(documentSnapshot['email'], 
                              style: const TextStyle(color: Colors.black, 
                              fontSize: 16, 
                              fontWeight: FontWeight.w400)),
                            ],
                          ),
                          const SizedBox(height: 5),
                           Row(
                             children: [
                              const Text('Court : ', 
                              style: TextStyle(color: Colors.black, 
                              fontSize: 16, 
                              fontWeight: FontWeight.w400)),
                               Text(documentSnapshot['courtid'], 
                          style: const TextStyle(color: Colors.black, 
                          fontSize: 16, 
                          fontWeight: FontWeight.w400)),
                             ],
                           ),
                          const SizedBox(height: 5),
                           Row(
                             children: [
                              const Text('Court Name : ', 
                              style: TextStyle(color: Colors.black, 
                              fontSize: 16, 
                              fontWeight: FontWeight.w400)),
                               Text(documentSnapshot['courtname'], 
                          style: const TextStyle(color: Colors.black, 
                          fontSize: 16, 
                          fontWeight: FontWeight.w400)),
                             ],
                           ),
                           const SizedBox(height: 5),
                           Row(
                             children: [
                              const Text('Price : ', 
                              style: TextStyle(color: Colors.black, 
                              fontSize: 16, 
                              fontWeight: FontWeight.w400)),
                               Text(documentSnapshot['courtprice'], 
                          style: const TextStyle(color: Colors.black, 
                          fontSize: 16, 
                          fontWeight: FontWeight.w400)),
                             ],
                           ),
                        ],
                      ),
                    )),
              ],
            ),
          ),
        ],
      ),
      
    );
  }
}

