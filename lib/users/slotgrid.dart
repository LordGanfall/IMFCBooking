import 'package:booking100/model/utils.dart';
import 'package:booking100/users/payment.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookingGrid extends StatefulWidget {
  final DateTime? selectedDate;
  final String courtid;
  final String courtname;
  final String courtprice;

  const BookingGrid(
      {Key? key,
      required this.selectedDate,
      required this.courtid,
      required this.courtprice,
      required this.courtname})
      : super(key: key);

  @override
  State<BookingGrid> createState() => _BookingGridState();
}

class _BookingGridState extends State<BookingGrid> {
  Color unselectedColor = Colors.white;
  Color selectedColor = const Color.fromARGB(255, 7, 2, 85);
  int selectedCard = -1;

  late String time;
  late DateTime startDateTime;

  static DateTime now = DateTime.now();

  // ignore: non_constant_identifier_names
  List<DateTime?> SlotTime = [
    DateTime(now.year, now.month, now.day, 9),
    DateTime(now.year, now.month, now.day, 10),
    DateTime(now.year, now.month, now.day, 11),
    DateTime(now.year, now.month, now.day, 12),
    DateTime(now.year, now.month, now.day, 13),
    DateTime(now.year, now.month, now.day, 14),
    DateTime(now.year, now.month, now.day, 15),
    DateTime(now.year, now.month, now.day, 16),
    DateTime(now.year, now.month, now.day, 17),
    DateTime(now.year, now.month, now.day, 18),
    DateTime(now.year, now.month, now.day, 19),
    DateTime(now.year, now.month, now.day, 20),
    DateTime(now.year, now.month, now.day, 21),
    DateTime(now.year, now.month, now.day, 22),
    DateTime(now.year, now.month, now.day, 23),
    DateTime(now.year, now.month, now.day, 00),
    DateTime(now.year, now.month, now.day, 01),
    DateTime(now.year, now.month, now.day, 02),
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.white,
          height: 300,
          width: double.infinity,
          child: SingleChildScrollView(
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 4.0,
                mainAxisSpacing: 5.0,
              ),
              itemCount: SlotTime.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(3),
                    ),
                    color: selectedCard == index
                        ? const Color.fromARGB(255, 7, 2, 85)
                        : Colors.white70,
                    child:
                        Center(child: Text(dateTimeToHours(SlotTime[index]))),
                  ),
                  onTap: () {
                    setState(() {
                      // ontap of each card, set the defined int to the grid view index
                      selectedCard = index;
                    });
                    startDateTime = DateTime(
                        widget.selectedDate!.year,
                        widget.selectedDate!.month,
                        widget.selectedDate!.day,
                        SlotTime[index]!.hour,
                        SlotTime[index]!.minute);
                  },
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 10),
        // ignore: avoid_unnecessary_containers
        Container(
          child: Center(
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(const Color.fromARGB(255, 7, 2, 85)),
              padding: MaterialStateProperty.all(const EdgeInsets.fromLTRB(80, 5, 80, 5)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ))),
            onPressed: () {
              
              sendDateTime(startDateTime);
            },
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Book Now", style: GoogleFonts.lato(fontSize: 20))),
          ),
        )),
      ],
    );
  }

  String dateTimeToHours(DateTime? date) {
    return DateFormat.jm().format(date!);
  }

  sendDateTime(startDateTime) async {
    final prefs = await SharedPreferences.getInstance();
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bookdate'] = this.startDateTime;
    data['bookcreated'] = DateTime.now().toString();
    data['email'] = prefs.getString('email');
    data['courtid'] = prefs.getString('courtid');
    data['courtprice'] = prefs.getString('courtprice');
    try {
      // ignore: use_build_context_synchronously
      Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BookPayment(
                            selectedDate: startDateTime,
                            courtid: widget.courtid,
                            courtname: widget.courtname,
                            courtprice: widget.courtprice,
                          )));
    } on FirebaseAuthException catch (e) {
      print(e);
      Utils.showSnackBar(e.message);
    }
  }
}

// courtid: widget.courtid,
//                             courtname: widget.courtname,
//                             selectedDate: startDateTime,
//                             courtprice: widget.courtprice,
