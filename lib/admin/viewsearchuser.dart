import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SearchViewUser extends StatefulWidget {
  const SearchViewUser({Key? key}) : super(key: key);

  @override
  State<SearchViewUser> createState() => _SearchViewUserState();
}

class _SearchViewUserState extends State<SearchViewUser> {
  String email = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Card(
            child: TextField(
          decoration: InputDecoration(
              prefixIcon: Icon(Icons.search), hintText: 'Search user'),
          onChanged: (val) {
            setState(() {
              email = val;
            });
          },
        )),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: (email != "" && email != null)
              ? FirebaseFirestore.instance
                  .collection('user')
                  .where('serchkey', arrayContains: email)
                  .snapshots()
              : FirebaseFirestore.instance.collection('user').snapshots(),
          builder: (context, snapshots) {
            return (snapshots.connectionState == ConnectionState.waiting)
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: snapshots.data!.docs.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot data = snapshots.data!.docs[index];
                      return Container(
                        padding: EdgeInsets.only(top: 10),
                        child: Column(
                          children: [
                            ListTile(
                                title: Text(
                                  data['email'],
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                leading: const Image(
                                    image: AssetImage('assets/mrlukaku.png')),
                                trailing: Icon(Icons.arrow_forward_ios_rounded,
                                size: 20),
                            ),
                            Divider(thickness: 2)
                          ],
                        ),
                      );
                    });
          }),
    );
  }
}
