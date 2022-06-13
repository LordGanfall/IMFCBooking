import 'package:booking100/admin/adduser.dart';
import 'package:booking100/admin/adminavbar.dart';
import 'package:booking100/admin/userdata.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserList extends StatefulWidget {
  const UserList({Key? key}) : super(key: key);

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  final CollectionReference _users = FirebaseFirestore.instance.collection('user');


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
            return const Text('Something is wrong, try add a new user');
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
                    title: Text(documentSnapshot['fullname']),
                    subtitle: Text(documentSnapshot['username']),
                    trailing: 
                        IconButton(
                          icon: const Icon(Icons.arrow_right),
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => UserData(documentSnapshot: documentSnapshot)));
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const AddUser()));
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      drawer: const AdminNavBar(),
    );
  }
}

