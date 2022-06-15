import 'package:booking100/users/bookpayment.dart';
import 'package:flutter/material.dart';

class BookPayment extends StatefulWidget {
  final DateTime? selectedDate;
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
                      height: 180,
                      child: Image.network(
                          'https://www.nicepng.com/png/detail/408-4083998_background-pic-4-kids-futsal-cartoon.png')),
                  const Text("Confirm Your Booking",
                      style: TextStyle(color: Colors.black, fontSize: 26)),
                  const SizedBox(
                    height: 10,
                  ),
                  // ignore: sized_box_for_whitespace
                  Container(
                    width: 380,
                    height: 280,
                    child: Card(
                      elevation: 15,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Text(widget.courtid,
                              style: const TextStyle(
                                  fontSize: 30, color: Colors.black)),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(widget.courtname,
                              style: const TextStyle(
                                  fontSize: 28, color: Colors.black)),
                          const SizedBox(
                            height: 20,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(widget.selectedDate.toString(),
                              style: const TextStyle(
                                fontSize: 24,
                                color: Colors.black,
                              )),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text("Total Payment",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 26)),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(widget.courtprice,
                              style: const TextStyle(
                                  fontSize: 22, color: Colors.black)),
                        ],
                      ),
                    ),
                  ),
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
