import 'package:booking100/users/courtschedule.dart';
import 'package:booking100/users/sidebar.dart';
import 'package:flutter/material.dart';

class Schedule extends StatefulWidget {
  const Schedule({Key? key}) : super(key: key);

  @override
  State<Schedule> createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("INDERA MAHKOTA FUTSAL"),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 7, 2, 85),
        elevation: 0,
      ),
      body: Column(
        children: <Widget>[
          const SizedBox(height: 10),
          SizedBox(height: 180, child: Image.asset("assets/alonso.png")),
          const Text(
            'Booking Schedule',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const Flexible(child: CourtSchedule()),
        ],
      ),
      drawer: const NavigationDrawer(),
    );
  }
}