
import 'package:booking100/admin/adminavbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CourtList extends StatefulWidget {
  const CourtList({Key? key}) : super(key: key);

  @override
  State<CourtList> createState() => _CourtListState();
}

class _CourtListState extends State<CourtList> {

  final CollectionReference _courts = FirebaseFirestore.instance.collection('court');

  final TextEditingController _courtidController = TextEditingController();
  final TextEditingController _courtnameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  Future<void> _update([DocumentSnapshot? documentSnapshot]) async{
    if (documentSnapshot != null) {
      _courtidController.text = documentSnapshot['courtid'];
      _courtnameController.text = documentSnapshot['courtname'];
      _priceController.text = documentSnapshot['courtprice'];
    }

  await showModalBottomSheet(
    isScrollControlled: true,
    context: context, 
    builder: (BuildContext ctx){
      return Padding(
        padding: EdgeInsets.only(
          top: 20,
          left: 20,
          right: 20,
          bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: _courtidController,
          decoration: const InputDecoration(labelText: 'Court ID')
        ),
        TextField(
          controller: _courtnameController,
          decoration: const InputDecoration(labelText: 'Court Name')
        ),
        TextField(
          controller: _priceController,
          decoration: const InputDecoration(labelText: 'Price')
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          child: const Text("Update"),
          onPressed: () async{
            final String courtid = _courtidController.text;
            final String courtname = _courtnameController.text;
            final String price = _priceController.text;
            if(price != null){
              await _courts
              .doc(documentSnapshot!.id)
              .update({"courtid": courtid, "courtname": courtname, "price": price});
              _courtidController.text = '';
              _courtnameController.text = '';
              _priceController.text = '';
            }
          }
          )
      ]),
      );
    });
  }

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
                        Text(documentSnapshot['courtid']),
                        const Text(' : '),
                        Text(documentSnapshot['courtname']),
                      ],
                    ),
                    subtitle: Text(documentSnapshot['courtprice']),
                    trailing: IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () => _update(documentSnapshot)
                            )
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