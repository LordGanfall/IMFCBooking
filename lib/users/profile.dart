import 'package:booking100/model/user_model.dart';
import 'package:booking100/users/sidebar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("user")
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
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
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const SizedBox(height: 20),
            const Center(
              child: Text(
                "Your Profile",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(100, 10, 100, 0),
              child: Center(
                child: Image.asset("assets/werner.png"),
              ),
            ),
            const SizedBox(height: 30),
            Container(
              height: 170,
              width: 400,
              child: Card(
                  elevation: 30,
                  shadowColor: const Color.fromARGB(255, 7, 2, 85),
                  margin: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                  shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.white)),
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Column(
                      children: <Widget>[
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Email: ",
                              style: TextStyle(fontSize: 18),
                            ),
                            Text(
                              "${loggedInUser.email}",
                              style: const TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Full Name: ",
                              style: TextStyle(fontSize: 18),
                            ),
                            Text(
                              "${loggedInUser.fullname}",
                              style: const TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Username: ",
                              style: TextStyle(fontSize: 18),
                            ),
                            Text(
                              "${loggedInUser.username}",
                              style: const TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )),
            ),
             const SizedBox(height: 20),
           SizedBox(
                        width: 360,
                        height: 50,
                        child: ElevatedButton(
                            onPressed: () {
                              showDialog(
                              context: context, 
                              builder: (context) => const FeedbackDialog());
                            },
                            //   Navigator.push(
                            //       context,
                            //       MaterialPageRoute(
                            //           builder: (context) => BookingReportPdf(documentSnapshot: documentSnapshot)));
                            // },
                            style: ElevatedButton.styleFrom(
                              primary: const Color.fromARGB(255, 7, 2, 85),
                            ),
                            child: const Text("Feedback",
                            style: TextStyle(fontSize: 20))),
                      ),
          ],
        ),
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
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  void dispose(){
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    return AlertDialog(
      content: Form(
        key: _formKey,
        child: TextFormField(
          controller: _controller,
          keyboardType: TextInputType.multiline,
          decoration: const InputDecoration(
            hintText: "Enter Your Feedback",
            filled: true,
          ),
          maxLines: 5,
          maxLength: 500,
          textInputAction: TextInputAction.done,
          validator: (String? text){
            if (text == null || text.isEmpty) {
              return 'Please Enter Your Feeback';
            }
            return null;
          },
        )
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
                    'feedbackk' : _controller.text
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
    );
  }
}