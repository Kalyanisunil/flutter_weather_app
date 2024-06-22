import 'package:flutter/material.dart';
import 'package:weather_app/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
//https://in.pinterest.com/pin/885942557926263679/
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(scaffoldBackgroundColor: Color(0xFF778da9)),
        debugShowCheckedModeBanner: false,
        title: 'Weather',
        home: const MyBottomBar());
  }
}

class MyBottomBar extends StatefulWidget {
  const MyBottomBar({super.key});

  @override
  State<MyBottomBar> createState() => _MyBottomBarState();
}

class _MyBottomBarState extends State<MyBottomBar> {
  int selectedIndex = 0;
  static const List<Widget> widgetOptions = <Widget>[
    HomePage(),
    Text("Updates"),
    Text("Alerts"),
    Text("radar"),
    // Icon(Icons.today_outlined),
    // Icon(Icons.next_week),
    // Icon(Icons.hourglass_bottom),
  ];
  void onTap(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: widgetOptions.elementAt(selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
            //
            items: const [
              BottomNavigationBarItem(label: "", icon: Icon(Icons.today)),
              BottomNavigationBarItem(
                label: "",
                icon: Icon(Icons.notification_important),
              ),
              BottomNavigationBarItem(label: "", icon: Icon(Icons.search)),
              BottomNavigationBarItem(label: "", icon: Icon(Icons.radar))
            ],
            type: BottomNavigationBarType.fixed,
            backgroundColor: Color(0xFF778da9),
            currentIndex: selectedIndex,
            selectedItemColor: Colors.white,
            iconSize: 30,
            onTap: onTap,
            elevation: 2));
  }
}
