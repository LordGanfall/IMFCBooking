import 'package:booking100/model/dataparser.dart';
import 'package:booking100/users/sidebar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Feedbackk extends StatefulWidget {
  const Feedbackk({Key? key}) : super(key: key);

  @override
  State<Feedbackk> createState() => _FeedbackkState();
}

class _FeedbackkState extends State<Feedbackk> {
  final CollectionReference _courts = FirebaseFirestore.instance.collection('feedback');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const FeedbackDialog()));
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      appBar: AppBar(
      title: const Text("INDERA MAHKOTA FUTSAL"),
      centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 7, 2, 85),
        elevation: 0,
      ),
      body: StreamBuilder(
        stream: _courts.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot){
          if (streamSnapshot.hasData){
            return ListView.builder(
              itemCount: streamSnapshot.data!.docs.length,
              itemBuilder: (context, index){
                final DocumentSnapshot documentSnapshot = streamSnapshot.data!.docs[index];
                return Padding(
                  padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                  child: SizedBox(
                    height: 60,
                    width: double.infinity,
                    child: Card(
                      elevation: 10,
                      margin: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                      child: ListTile(
                        title: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 0),
                              child: Text(documentSnapshot['name'], style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(documentSnapshot['feedbackk']),
                            ),
                          ],
                        ),
                        ),
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
      drawer: const NavigationDrawer(),
    );
  }
}


class FeedbackDialog extends StatefulWidget{
  const FeedbackDialog({Key? key}) : super(key: key);

  @override
  State<FeedbackDialog> createState() => _FeedbackDiaglogState();
}

class _FeedbackDiaglogState extends State<FeedbackDialog>{
  final TextEditingController _controller = TextEditingController();
   final TextEditingController _name = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  void dispose(){
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    return Stack(
      children: [
        AlertDialog(
          backgroundColor: Colors.white,
          content: Form(
            key: _formKey,
            child: Container(
              width: 330,
                  height: 230,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white),
                  padding: const EdgeInsets.fromLTRB(10, 30, 10, 0),
              child: Column(
                children: [
                  TextFormField(
                    controller: _controller,
                    keyboardType: TextInputType.multiline,
                    decoration: const InputDecoration(
                      hintText: "Enter Your Feedback",
                      filled: true,
                    ),
                    maxLines: 2,
                    maxLength: 100,
                    textInputAction: TextInputAction.done,
                    validator: (String? text){
                      if (text == null || text.isEmpty) {
                        return 'Please Enter Your Feeback';
                      }
                      return null;
                    },
                  ),
                   TextFormField(
                    controller: _name,
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(
                      hintText: "Enter Your Name",
                      filled: true,
                    ),
                    maxLines: 1,
                    maxLength: 10,
                    textInputAction: TextInputAction.done,
                    validator: (String? text){
                      if (text == null || text.isEmpty) {
                        return 'Please Enter Your Name';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
            ),
            actions: [
              TextButton(
                child: const Text("Cancel"),
                onPressed: () => Navigator.pop(context), 
              ),
              TextButton(
                child: const Text("Send"),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    String message;
    
                    try{
                      final collection = FirebaseFirestore.instance.collection('feedback');
                      await collection.doc().set({
                        'timestamp' : FieldValue.serverTimestamp(),
                        'feedbackk' : _controller.text,
                        'name' : _name.text,
    
                      });
                      message = 'Feedback Sent Successfully';
                    }
                    catch (_){
                      message = 'Error When Sending Feedback';
                    }
                  }
                }, 
              )
            ],
        ),
      ],
    );
  }}