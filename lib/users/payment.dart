import 'package:booking100/users/bookpayment.dart';
import 'package:flutter/material.dart';

class BookPayment extends StatefulWidget {
  final DateTime selectedDate;
  final String courtid;
  final String courtname;
  final String courtprice;
  const BookPayment(
      {Key? key,
      required this.courtid,
      required this.courtname,
      required this.selectedDate,
      required this.courtprice})
      : super(key: key);

  @override
  State<BookPayment> createState() => _BookPaymentState();
}

class _BookPaymentState extends State<BookPayment> {
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
            Center(
              child: Column(
                children: [
                  SizedBox(
                      height: 150,
                      child: Image.asset(
                          "assets/chelsea1.png")),
                  const Text("Booking Details",
                      style: TextStyle(color: Colors.black, fontSize: 26, fontWeight: FontWeight.bold)),
                  const SizedBox(
                    height: 10,
                  ),
                  // ignore: sized_box_for_whitespace
                  Container(
                    width: 380,
                    height: 270,
                    child: Card(
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
                               Text(widget.selectedDate.toString(),
                                    style: const TextStyle(
                                        fontSize: 22, color: Colors.black)),
                              ]
                            ),
                            const SizedBox(height: 30),
                           
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                const Text('Court ID: ',
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.black)),
                                Text(widget.courtid,
                                    style: const TextStyle(
                                        fontSize: 20, color: Colors.black)),
                              ],
                            ),
                            const SizedBox(height: 25),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                const Text('Court Name: ',
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.black)),
                                Text(widget.courtname,
                                    style: const TextStyle(
                                        fontSize: 20, color: Colors.black)),
                              ],
                            ),
                            const SizedBox(height: 25),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                const Text('Total Payment: ',
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.black)),
                                Text(widget.courtprice,
                                    style: const TextStyle(
                                        fontSize: 20, color: Colors.black)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Divider(color: Colors.grey, thickness: 2.0,indent: 30, endIndent: 30,),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 360,
                        height: 50,
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => BookingPayment(
                                            getData: widget.selectedDate,
                                            courtprice: widget.courtprice,
                                          )));
                            },
                            style: ElevatedButton.styleFrom(
                              primary: const Color.fromARGB(255, 7, 2, 85),
                            ),
                            child: const Text("Confirm Booking",
                            style: TextStyle(fontSize: 20),),),
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
