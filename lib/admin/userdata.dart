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
          Container(
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
            height: 200,
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
                        height: 180,
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
                    // ignore: sized_box_for_whitespace
                    child: Container(
                      height: 150,
                      width: 250,
                      child: Column(
                        children: [
                           Text(documentSnapshot['email'], 
                          style: const TextStyle(color: Colors.black, 
                          fontSize: 18, 
                          fontWeight: FontWeight.w500)),
                          const Divider(color: Colors.black, thickness: 1.0),

                          Row(
                            children: [
                              const Text('Username : ', 
                              style: TextStyle(color: Colors.black, 
                              fontSize: 16, 
                              fontWeight: FontWeight.w400)),
                              Text(documentSnapshot['username'], 
                              style: const TextStyle(color: Colors.black, 
                              fontSize: 16, 
                              fontWeight: FontWeight.w400)),
                            ],
                          ),
                          const SizedBox(height: 10),
                           Row(
                             children: [
                              const Text('Full Name : ', 
                              style: TextStyle(color: Colors.black, 
                              fontSize: 16, 
                              fontWeight: FontWeight.w400)),
                               Text(documentSnapshot['fullname'], 
                          style: const TextStyle(color: Colors.black, 
                          fontSize: 16, 
                          fontWeight: FontWeight.w400)),
                             ],
                           ),
                          const SizedBox(height: 10),
                           Row(
                             children: [
                              const Text('Password : ', 
                              style: TextStyle(color: Colors.black, 
                              fontSize: 16, 
                              fontWeight: FontWeight.w400)),
                               Text(documentSnapshot['password'], 
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

