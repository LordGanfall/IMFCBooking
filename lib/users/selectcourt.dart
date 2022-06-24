import 'dart:developer';

import 'package:booking100/users/courtslot.dart';
import 'package:booking100/users/sidebar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelectCourt extends StatefulWidget {
  const SelectCourt({Key? key}) : super(key: key);

  @override
  State<SelectCourt> createState() => _SelectCourtState();
}

class _SelectCourtState extends State<SelectCourt> {
  User? user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: const Text("INDERA MAHKOTA FUTSAL"),
      centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 7, 2, 85),
        elevation: 0,
      ),
      body: StreamBuilder<List<Futsal>>(
        stream: getCourtList(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("Something went wrong! ${snapshot.error} ");
          } else if (snapshot.hasData) {
            final futsallist = snapshot.data!;

            return ListView(
              children: futsallist.map(buildList).toList(),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      drawer: const NavigationDrawer(),
    );
  }
Widget buildList(Futsal futsal) => GestureDetector(
      //when clicked it will directed based on database
      onTap: () async {
        // Obtain shared preferences.
        final prefs = await SharedPreferences.getInstance();
        // Save an String value to 'action' key.
        await prefs.setString('courtid', futsal.courtid);
        await prefs.setString('courtname', futsal.courtname);
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['courtId'] = prefs.getString('courtId');
        log(futsal.courtid);

        // ignore: use_build_context_synchronously
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => CourtSlot
              (courtid: futsal.courtid, 
              courtname: futsal.courtname, 
              courtprice: futsal.courtprice, 
              imageurl: futsal.imageurl,
                  )),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Stack(
          children: [
            // ignore: sized_box_for_whitespace
            Container(
              height: 90,
              child: Card(
                semanticContainer: true,
                elevation: 8,
                margin: const EdgeInsets.all(5),
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    // side: const BorderSide(color: Colors.black, width: 1),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: ListTile(
                    selectedTileColor: Colors.white,
                    leading:  Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                              child: ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(4),
                                      bottomLeft: Radius.circular(4)),
                                  child: Image.network(
                                    futsal.imageurl,
                                    height: 100,
                                    width: 110,
                                    fit: BoxFit.cover
                                    ,
                                  ),
                                  ),
                            ),
                    title: Text(futsal.courtid,
                        style: const TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500)),
                    subtitle: Text('Court Name: ${futsal.courtname}',
                        style: const TextStyle(color: Colors.black, fontSize: 16)),
                  )),
            ),
           
          ],
        ),
      ));

  Stream<List<Futsal>> getCourtList() => FirebaseFirestore.instance
      .collection('court')
      .snapshots()
      .map((snapshot) => snapshot.docs.map((doc) {
            // inspect(doc.data());
            // log(doc.id);

            return Futsal.fromJson(doc.data());
          }).toList());
}

//class created for every collection in firebase database
class Futsal {
  // the variable to be set the value from the controller
  final String courtid;
  final String courtname;
  final String courtprice;
  final String imageurl;

// user requirement information in data table (Firebase Database)
  Futsal({
    required this.courtid, 
    required this.courtname, 
    required this.courtprice, 
    required this.imageurl, 
  });

  // assigning the data value based on table variable in Firabase Database
  // still don't know how to set and display specific time
  Map<String, dynamic> toJson() => {
        // property in database : variable
        'courtid': courtid,
        'courtname': courtname,
        'courtprice': courtprice,
        'imageurl': imageurl,
        // 'futsalcourt': futsalCourt,
        // 'date': date,
      };

  //READ data initalization
  static Futsal fromJson(Map<String, dynamic> json) => Futsal(
        courtid: json['courtid'],
        courtname: json['courtname'],
        courtprice: json['courtprice'],
        imageurl: json['imageurl'],
      );

  factory Futsal.fromSnapshot(DocumentSnapshot snapshot) {
    final model = Futsal.fromJson(snapshot.data() as Map<String, dynamic>);
    return model;
  }

  factory Futsal.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Futsal(
        courtid: data?['courtid'],
        courtname: data?['courtname'],
        courtprice: data?['courtprice'],
        imageurl: data?['imageurl'],
        );
  }
  Map<String, dynamic> toFirestore() {
    return {
      'courtid': courtid,
      'courtname': courtname,
      'courtprice': courtprice,
      'imageurl': imageurl,
    };
  }

  factory Futsal.fromJsonFireAuth(Map<String, dynamic> json) => Futsal(
        courtid: json['courtid'],
        courtname: json['courtname'],
        courtprice: json['courtprice'],
        imageurl: json['imageurl'],
      );

  Map<String, dynamic> toJsonFireAuth() => {
       'courtid': courtid,
      'courtname': courtname,
      'courtprice': courtprice,
      'imageurl': imageurl,
      };
}

