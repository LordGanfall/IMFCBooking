import 'package:booking100/admin/userreport.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserData extends StatefulWidget {
  final DocumentSnapshot documentSnapshot;
  const UserData({Key? key, required this.documentSnapshot}) : super(key: key);

  @override
  State<UserData> createState() => _UserDataState(documentSnapshot);
}

class _UserDataState extends State<UserData> {
  final DocumentSnapshot documentSnapshot;
  _UserDataState(this.documentSnapshot);


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
          SizedBox(height: 150, child: Image.asset("assets/alonso.png")),
          const Text("User Details",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 26,
                  fontWeight: FontWeight.bold)),
          Container(
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
            height: 280,
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
                        const SizedBox(height: 10),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(documentSnapshot['email'],
                                  style: const TextStyle(
                                      fontSize: 22, color: Colors.black)),
                            ]),
                        const SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            const Text('Full Name: ',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black)),
                            Text(documentSnapshot['fullname'],
                                style: const TextStyle(
                                    fontSize: 20, color: Colors.black)),
                          ],
                        ),
                        const SizedBox(height: 25),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            const Text('Username: ',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black)),
                            Text(documentSnapshot['username'],
                                style: const TextStyle(
                                    fontSize: 20, color: Colors.black)),
                          ],
                        ),
                        const SizedBox(height: 25),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            const Text('Password: ',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black)),
                            Text(documentSnapshot['password'],
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
                                      builder: (context) => UserReportPdf(documentSnapshot: documentSnapshot)));
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
