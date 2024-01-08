import 'package:flutter/material.dart';
import 'package:project_um/screens/notifications_screen.dart';
import 'package:project_um/screens/secondary%20screens/add_annoucements.dart';
import './screens/primary screens/home_data_screen.dart';
import './screens/primary screens/sos_screen.dart';
import './screens/primary screens/buy_sell_screen.dart';
import 'package:project_um/screens/drawer_stuff_screen.dart';

class Home extends StatefulWidget {
  Home({super.key});

  static final List<Widget> _pages = <Widget>[
    HomeDataScreen(),
    SosScreen(),
    BuySellScreen(),
  ];

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int selectedItemIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: DrawerStuffScreen(),
      ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        title: const Text("Student Hub"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => NotificationScreen()));
              },
              icon: Icon(Icons.add_alert_rounded))
        ],
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => AddAnnouncements()));
          },
          child: Icon(Icons.add)),
      body: Home._pages.elementAt(selectedItemIndex),
      bottomNavigationBar: SizedBox(
        height: 65,
        child: Container(
          decoration: BoxDecoration(
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.grey.shade700.withOpacity(0.5),
                  blurRadius: 5.0,
                  offset: Offset(0.0, 0.75))
            ],
          ),
          child: BottomNavigationBar(
            elevation: 5,
            backgroundColor: Colors.white,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home, size: 30.0, color: Colors.black),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.sos,
                  size: 30,
                  color: Colors.black,
                ),
                label: 'SOS message',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.swap_horiz, size: 30, color: Colors.black),
                label: 'Buy & Sell',
              ),
            ],
            currentIndex: selectedItemIndex,
            onTap: (int index) {
              setState(() {
                selectedItemIndex = index;
              });
            },
            // animationDuration: const Duration(milliseconds: 500),
            // labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
          ),
        ),
      ),
    );
  }
}
