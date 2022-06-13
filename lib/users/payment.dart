import 'package:booking100/users/bookpayment.dart';
import 'package:flutter/material.dart';

class BookPayment extends StatefulWidget {
  final DateTime? selectedDate;
  final String courtid;
  final String courtname;
  final String courtprice;
  const BookPayment({Key? key, 
  required this.courtid, 
  required this.courtname, 
  required this.selectedDate, 
  required this.courtprice}) : super(key: key);

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
                  const Text("Futsal", style: TextStyle(color: Colors.black)),
               const SizedBox(
                  height: 10,
                ),
                Text(widget.courtid,
                    style: const TextStyle(fontSize: 30, color: Colors.black)),
               const SizedBox(
                  height: 20,
                ),
               const Text("Court", style: TextStyle(color: Colors.black)),
               const SizedBox(
                  height: 10,
                ),
                Text("Court ${widget.courtname}) ",
                    style:const TextStyle(fontSize: 20, color: Colors.black)),
                const SizedBox(
                  height: 20,
                ),
                const Text("Slot Date and Time",
                    style: TextStyle(color: Colors.black)),
               const SizedBox(
                  height: 10,
                ),
                Text(widget.selectedDate.toString(),
                    style: const TextStyle(fontSize: 20, color: Colors.black)),
                const SizedBox(
                  height: 20,
                ),
               const Text("Total Payment", style: TextStyle(color: Colors.black)),
                const SizedBox(
                  height: 10,
                ),
                Text("RM ${widget.courtprice}",
                    style:const TextStyle(fontSize: 30, color: Colors.black)),
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                   const SizedBox(width: 20),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BookingPayment(
                                        getData: widget.selectedDate,
                                        courtprice: widget.courtprice,
                                      )));
                        },
                        child: const Text("Confirm Booking"))
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