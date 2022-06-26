// ignore_for_file: deprecated_member_use

import 'package:booking100/users/slotgrid.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';

class CourtSlot extends StatefulWidget {
  final String courtid;
  final String courtname;
  final String courtprice;
  final String imageurl;

  const CourtSlot(
      {Key? key,
      required this.courtid,
      required this.courtname,
      required this.courtprice,
      required this.imageurl})
      : super(key: key);

  @override
  State<CourtSlot> createState() => _CourtSlotState();
}

class _CourtSlotState extends State<CourtSlot> {
  // ignore: prefer_final_fields
  DatePickerController _controller = DatePickerController();

  DateTime selectedValue = DateTime.now();
  // Color unselectedColor = Colors.white;
  Color selectedColor = const Color.fromARGB(255, 90, 167, 230);
  static const TextStyle unsselectedColor =
      TextStyle(color: Colors.black, fontWeight: FontWeight.w400);

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
          actions: <Widget>[
            IconButton(
                icon: const Icon(Icons.question_mark_rounded),
                onPressed: () {
                  _showDialog(context);
                }),
          ],
        ),
        // ignore: avoid_unnecessary_containers
        body: Container(
            child: Column(children: [
          Container(
            color: Colors.black,
            height: 230,
            child: Stack(
              textDirection: TextDirection.ltr,
              children: [
                SizedBox(
                  height: 230,
                  child: Image.network(widget.imageurl,
                      fit: BoxFit.fill, width: double.infinity),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      const SizedBox(height: 50),
                      Center(
                        child: Column(
                          children: [
                            Text(widget.courtid,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 26.0,
                                  fontWeight: FontWeight.w600,
                                )),
                          ],
                        ),
                      ),
                      const SizedBox(height: 15),
                      DatePicker(
                        DateTime.now(),
                        width: 60,
                        height: 80,
                        daysCount: 14,
                        controller: _controller,
                        dateTextStyle: unsselectedColor,
                        dayTextStyle: unsselectedColor,
                        monthTextStyle: unsselectedColor,
                        initialSelectedDate: DateTime.now(),
                        selectionColor: selectedColor,
                        selectedTextColor: Colors.black,
                        onDateChange: (date) {
                          // New date selected
                          setState(() {
                            selectedValue = date;
                          });
                        },
                      ),
                      const SizedBox(height: 6),
                      Center(
                        child: Text('Court Name : ${widget.courtname}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 22.0,
                              fontWeight: FontWeight.w600,
                            )),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            child: BookingGrid(
              selectedDate: selectedValue,
              courtid: widget.courtid,
              courtprice: widget.courtprice,
              courtname: widget.courtname,
            ),
          )
        ])));
  }

  _showDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Stack(alignment: Alignment.center, children: <Widget>[
            Container(
              width: 330,
              height: 230,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: const Color.fromARGB(255, 247, 237, 194)),
              padding: const EdgeInsets.fromLTRB(10, 30, 10, 0),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const <Widget>[
                      Text("Color", style: TextStyle(
                                color: Colors.black, fontSize: 14
                              )),
                      Text("Court Status", style: TextStyle(
                                color: Colors.black, fontSize: 14
                              )),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: const [
                          Text("White ",
                              style: TextStyle(
                                color: Colors.black, fontSize: 14
                              )),
                          Icon(
                            Icons.rectangle,
                            color: Colors.white,
                            size: 18,
                          ),
                          Text(":",
                              style: TextStyle(
                                color: Colors.black, fontSize: 14
                              )),
                        ],
                      ),
                      const Text("AvailableCourt", style: TextStyle(
                                color: Colors.black, fontSize: 14
                              )),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: const [
                          Text("Grey ",
                              style: TextStyle(
                                color: Colors.black, fontSize: 14
                              )),
                          Icon(
                            Icons.rectangle,
                            color: Colors.grey,
                            size: 18,
                          ),
                          Text(":",
                              style: TextStyle(
                                color: Colors.black, fontSize: 14
                              )),
                        ],
                      ),
                      const Text("Booked Court", style: TextStyle(
                                color: Colors.black, fontSize: 14
                              )),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: const [
                          Text("Blue Grey ",
                              style: TextStyle(
                                color: Colors.black, fontSize: 14
                              )),
                          Icon(
                            Icons.rectangle,
                            color: Colors.blueGrey,
                            size: 18,
                          ),
                          Text(":",
                              style: TextStyle(
                                color: Colors.black, fontSize: 14
                              )),
                        ],
                      ),
                      const Text("Unavailable Court",style: TextStyle(
                                color: Colors.black, fontSize: 14
                              )),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: const [
                          Text("Blue ",
                             style: TextStyle(
                                color: Colors.black, fontSize: 14
                              )),
                          Icon(
                            Icons.rectangle,
                            color: Color.fromARGB(255, 90, 167, 230),
                            size: 18,
                          ),
                          Text(":",
                              style: TextStyle(
                                color: Colors.black, fontSize: 14
                              )),
                        ],
                      ),
                      const Text("Selected Court",style: TextStyle(
                                color: Colors.black, fontSize: 14
                              )),
                    ],
                  ),
                  // Column(
                  //   children: [
                  //     FlatButton(
                  //       child: const Text('Continue Booking',
                  //           style: TextStyle(color: Colors.black)),
                  //       onPressed: () {
                  //         Navigator.of(context).pop();
                  //       },
                  //     ),
                  //   ],
                  // )
                ],
              ),
            ),
            Positioned(
                top: 100,
                child: Image.network("https://i.imgur.com/2yaf2wb.png",
                    width: 150, height: 150))
          ]);
        });
  }
}
