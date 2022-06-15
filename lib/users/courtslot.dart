import 'package:booking100/users/slotgrid.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';

class CourtSlot extends StatefulWidget {
  final String courtid;
  final String courtname;
  final String courtprice;
  final String imageurl;
  
  const CourtSlot({Key? key,
   required this.courtid, 
   required this.courtname, 
   required this.courtprice, 
   required this.imageurl}) : super(key: key);

  @override
  State<CourtSlot> createState() => _CourtSlotState();
}

class _CourtSlotState extends State<CourtSlot> {
  // ignore: prefer_final_fields
  DatePickerController _controller = DatePickerController();

  DateTime selectedValue = DateTime.now();
  // Color unselectedColor = Colors.white;
  Color selectedColor = const Color.fromARGB(255, 7, 2, 85);
  static const TextStyle unsselectedColor = TextStyle(color: Colors.white);

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
            // ignore: avoid_unnecessary_containers
            body: Container(
            child: Column(children: [
          Container(
            color: Colors.black,
            height: 230,
            child: Stack(
              textDirection: TextDirection.ltr,
              children: [
                ShaderMask(
                  shaderCallback: (rect) {
                    return const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.black, Colors.transparent],
                    ).createShader(Rect.fromLTRB(0, 0, rect.width, 190));
                  },
                  blendMode: BlendMode.dstIn,
                  child: Image.network(widget.imageurl,
                      fit: BoxFit.fill, height: 200, width: double.infinity),
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
                        selectedTextColor: Colors.white,
                        onDateChange: (date) {
                          // New date selected
                          setState(() {
                            selectedValue = date;
                          });
                        },
                      ),
                     const SizedBox(height: 6),
                      Center(
                        child: Text('Court Name : ' +widget.courtname,
                            style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
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
}