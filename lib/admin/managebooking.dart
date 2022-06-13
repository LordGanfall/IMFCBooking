import 'package:booking100/admin/adminavbar.dart';
import 'package:booking100/admin/bookdata.dart';
import 'package:booking100/model/dataparser.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ManageBooking extends StatefulWidget {
  const ManageBooking({Key? key}) : super(key: key);

  @override
  State<ManageBooking> createState() => _ManageBookingState();
}

class _ManageBookingState extends State<ManageBooking> {
  final CollectionReference _users = FirebaseFirestore.instance.collection('booklist');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: const Text("INDERA MAHKOTA FUTSAL"),
      centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 7, 2, 85),
        elevation: 0,
      ),
      body: StreamBuilder(
        stream: _users.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot){
          if (streamSnapshot.hasError) {
            return const Text('Something is wrong');
          }
          if (streamSnapshot.hasData) {
            return ListView.builder(
              itemCount: streamSnapshot.data!.docs.length,
              itemBuilder: (context, index){
                final DocumentSnapshot documentSnapshot = streamSnapshot.data!.docs[index];
                return Card(
                  margin: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                  child: ListTile(
                    leading: const Icon(Icons.person),
                    title: Text(DateParser.parseDateTimeyMdAddJM(documentSnapshot['bookdate'])),
                    subtitle: Text(documentSnapshot['email']),
                    trailing: 
                        IconButton(
                          icon: const Icon(Icons.arrow_right),
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => BookingData(documentSnapshot: documentSnapshot)));
                          }, 
                          ),
                  ),
                );
              }
            );
          }
          else{
            return const Center(child: CircularProgressIndicator(),);
          }
        },
      ),
      drawer: const AdminNavBar(),
    );
  }
}
