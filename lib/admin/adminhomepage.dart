import 'package:booking100/admin/adminavbar.dart';
import 'package:booking100/admin/managebooking.dart';
import 'package:booking100/admin/userlist.dart';
import 'package:booking100/admin/viewcourt.dart';
import 'package:flutter/material.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({Key? key}) : super(key: key);

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("INDERA MAHKOTA FUTSAL"),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 7, 2, 85),
        elevation: 0,
      ),
      body: SafeArea(
        child: Expanded(
            child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: GridView.count(
            mainAxisSpacing: 10,
            crossAxisCount: 2,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => const UserList())));
                },
                child: Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // if you need this
                    side: BorderSide(
                      color: Colors.grey.withOpacity(0.2),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.network(
                          'https://www.chinadaily.com.cn/sports/images/attachement/jpg/site1/20140513/0013729e42d214dc01b527.jpg'),
                      Text("Manage Users")
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => const CourtList())));
                },
                child: Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // if you need this
                    side: BorderSide(
                      color: Colors.grey.withOpacity(0.2),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.network(
                          'https://img.freepik.com/free-vector/futsal-field-with-players_52683-47537.jpg?w=2000'),
                      SizedBox(height: 16),
                      Text("Manage Courts")
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: ((context) => const ManageBooking())));
                },
                child: Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // if you need this
                    side: BorderSide(
                      color: Colors.grey.withOpacity(0.2),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.network(
                          'https://i.pinimg.com/736x/da/0a/dd/da0add39a6ead87cb754f032d0d86a58.jpg'),
                      Text("Manage Bookings")
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  // Navigator.push(context, MaterialPageRoute(builder: ((context) => const ManageAbout())));
                },
                child: Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // if you need this
                    side: BorderSide(
                      color: Colors.grey.withOpacity(0.2),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.network(
                          'https://media.istockphoto.com/vectors/football-coach-vector-id165599564?k=20&m=165599564&s=612x612&w=0&h=FWxm75kXU-Q2ZOZTF6qIJSZhTuDr5z-hW7hUzeVM4kU='),
                      Text("Report")
                    ],
                  ),
                ),
              )
            ],
          ),
        )),
      ),
      drawer: const AdminNavBar(),
    );
  }
}
