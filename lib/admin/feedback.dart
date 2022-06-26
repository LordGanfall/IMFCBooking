import 'package:booking100/model/dataparser.dart';
import 'package:flutter/material.dart';
import 'package:booking100/admin/adminavbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserFeedback extends StatefulWidget {
  const UserFeedback({Key? key}) : super(key: key);

  @override
  State<UserFeedback> createState() => _CourtListState();
}

class _CourtListState extends State<UserFeedback> {

  final CollectionReference _courts = FirebaseFirestore.instance.collection('feedback');

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
        stream: _courts.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot){
          if (streamSnapshot.hasData) {
            return ListView.builder(
              itemCount: streamSnapshot.data!.docs.length,
              itemBuilder: (context, index){
                final DocumentSnapshot documentSnapshot = streamSnapshot.data!.docs[index];
                return Card(
                  margin: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                  child: ListTile(
                    title: Row(
                      children: [
                        Text(documentSnapshot['feedbackk']),
                      ],
                    ),
                    ),
                );
              }
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        ),
      drawer: const AdminNavBar(),
    );
  }
}