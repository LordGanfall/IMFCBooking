import 'package:booking100/users/homepage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_form.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookingPayment extends StatefulWidget {
   late DateTime? getData;
  final String courtprice;
  BookingPayment({Key? key,
  required this.getData, 
  required this.courtprice, }) : super(key: key);

  @override
  State<BookingPayment> createState() => _BookPaymentState();
}

class _BookPaymentState extends State<BookingPayment> {
  String cardNumber = '';
  String expiryDate= '';
  String cardHolderName = '';
  String cvvCode= '';
  bool isCvvFocused = false;
   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final user = FirebaseAuth.instance.currentUser!;
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
      ),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(width: 40),
            CreditCardWidget(
              cardBgColor: Colors.black,
              cardNumber: cardNumber,
              expiryDate: expiryDate,
              cardHolderName: cardHolderName,
              cvvCode: cvvCode,
              showBackView: isCvvFocused,

              obscureCardNumber: true,
              obscureCardCvv: true, onCreditCardWidgetChange: (CreditCardBrand ) {  },),
            Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      CreditCardForm(cardNumber: cardNumber,
                        expiryDate: expiryDate,
                        cardHolderName: cardHolderName,
                        cvvCode: cvvCode,
                        onCreditCardModelChange: onCreditCardModelChange,
                        themeColor: Colors.black,
                        formKey: _formKey,
                        cardNumberDecoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Number',
                            hintText: 'xxxx xxxx xxxx xxxx'
                        ),
                        expiryDateDecoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Expired Date',
                            hintText: 'xx/xx'
                        ),
                        cvvCodeDecoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'CVV',
                            hintText: 'xxx'
                        ),
                        cardHolderDecoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Card Holder',
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40.0),
                            ),
                            //primary: Color(0xff1b447b),
                            primary: const Color.fromARGB(255, 7, 2, 85),

                        ),
                        child: Container(
                          //width: double.infinity,
                          width: 330,

                          margin: EdgeInsets.all(10.0),

                          child:

                          Center(
                            child: Text(
                              'Proceed Payment',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'halter',
                                fontSize: 14,
                                package: 'flutter_credit_card',

                              ),
                            ),
                          ),
                        ),


                        onPressed: (){

                        
                          if (_formKey.currentState!.validate()) {
                              print('valid!');
                              sendData();

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => UserHomePage()));
                            } else {
                              print('invalid!');
                            }
                          
                        },)
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
    void onCreditCardModelChange(CreditCardModel creditCardModel){
    setState(() {
      cardNumber = creditCardModel.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }



  sendData() async {
    print("Sending Data.....");
    final Map<String, dynamic> data = new Map<String, dynamic>();
    final prefs = await SharedPreferences.getInstance();

    String id = FirebaseFirestore.instance.collection('post').doc().id;
    try {
      print("post created");
      // ignore: avoid_single_cascade_in_expression_statements
      FirebaseFirestore.instance
        ..collection("user")
            .doc(user.email)
            .collection('booked')
            .doc(id)
            .set({
          "courtprice": widget.courtprice,
          "bookdate": widget.getData,
          'createddate': DateTime.now().toString(),
          'email': user.email,
          'uid': prefs.getString('uid'),
          'courtid': prefs.getString('courtid'),
          'courtname': prefs.getString('courtname'),
          'bookid': id,
        });
      // ignore: avoid_single_cascade_in_expression_statements
      FirebaseFirestore.instance.collection("booklist").doc(id).set({
        "courtprice": widget.courtprice,
        "bookdate": widget.getData,
        'createddate': DateTime.now().toString(),
        'email': user.email,
        'uid': prefs.getString('uid'),
        'courtid': prefs.getString('courtid'),
        'courtname': prefs.getString('courtname'),
        'bookid': id,
      });
    } catch (e) {
      print(e);
    }
  }
}



  // showDialog
  //                         (context: context, 
  //                         builder: (context){
  //                           return Dialog(
  //               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
  //               elevation: 16,
  //               child: Container(
  //                 height: 400.0,
  //                 width: 360.0,
  //                 child: ListView(
  //                   children: <Widget>[
  //                     SizedBox(height: 20),
  //                     Center(
  //                       child: Text(
  //                         "Payment Successfull",
  //                         style: TextStyle(fontSize: 24, color: Colors.black, fontWeight: FontWeight.bold),
  //                       ),
  //                     ),
  //                     SizedBox(
  //                           height: 180,
  //                           child: Image.asset("assets/payment.png",),),
  //                           SizedBox(
  //                             child: Center(
  //                               child: Column(
  //                                 crossAxisAlignment: CrossAxisAlignment.start,
  //                                 children: [
  //                                   Text('Name : Naim Shafiq',style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
  //                                   SizedBox(height: 10),
  //                                   Text('Booking Date : Jun 28, 2022',style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
  //                                   SizedBox(height: 10),
  //                                   Text('Booking Time : 8:00 PM - 9:00 PM',style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
  //                                   SizedBox(height: 10),
  //                                   Text('Court ID : Court A',style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
  //                                   SizedBox(height: 10),
  //                                   Text('Total Price : RM 100.00',style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
                                    
                                    
  //                                 ],
  //                               ),
  //                             ),
  //                           )
  //                   ],
  //                 ),
  //               ),
  //             );
  //                         });