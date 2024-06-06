import 'package:bottombar/screens/form/item_list_screen.dart';
import 'package:bottombar/screens/fwb/fwb_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';

import 'screens/mytrips/my_trips_screen.dart';
import 'screens/addtrips/add_trips_screen.dart';
import 'screens/maps/maps_screen.dart';

class UIBottomNavigation extends StatefulWidget {
  const UIBottomNavigation({super.key});

  @override
  State<UIBottomNavigation> createState() => _UIBottomNavigationState();
}

class _UIBottomNavigationState extends State<UIBottomNavigation> {
  int _selectedWidget = 0;

  static List<Widget> _widgetScreen = [];

  @override
  void initState() {
    super.initState();
    _widgetScreen = [
      MyTripsScreen(),
      const AddTripsScreen(),
      const MapsScreen(),
      const FwbScreen(),
      ItemListScreen(),
    ];
  }

  void _onTap(int index) {
    setState(() {
      _selectedWidget = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hi Tunahn',
              style: GoogleFonts.lora(textStyle: const TextStyle(fontSize: 16)),
            ),
            Text(
              'Travelling Today?',
              style: GoogleFonts.lora(textStyle: const TextStyle(fontSize: 18)),
            ),
          ],
        ),
        actions: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.pink, width: 2),
            ),
            child: const CircleAvatar(
              backgroundImage: AssetImage('assets/images/avatar.jpg'),
            ),
          )
        ],
      ),
      body: _widgetScreen.elementAt(_selectedWidget),
      bottomNavigationBar: BottomNavigationBar(
        selectedLabelStyle: const TextStyle(fontSize: 13),
        unselectedLabelStyle: const TextStyle(fontSize: 10),
        items: [
          BottomNavigationBarItem(
            backgroundColor: Colors.blueGrey,
            icon: _selectedWidget == 0
                ? const Icon(IconlyBold.filter)
                : const Icon(IconlyLight.filter),
            label: 'My trips',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.red,
            icon: _selectedWidget == 1
                ? const Icon(IconlyBold.plus)
                : const Icon(IconlyLight.plus),
            label: 'Add trips',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.green,
            icon: _selectedWidget == 2
                ? const Icon(IconlyBold.location)
                : const Icon(IconlyLight.location),
            label: 'Maps',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.brown,
            icon: _selectedWidget == 3
                ? const Icon(IconlyBold.chart)
                : const Icon(IconlyLight.chart),
            label: 'Fwb',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.yellow,
            icon: _selectedWidget == 3
                ? const Icon(IconlyBold.call)
                : const Icon(IconlyLight.call),
            label: 'Form',
          ),
        ],
        currentIndex: _selectedWidget,
        onTap: _onTap,
      ),
    );
  }
}
