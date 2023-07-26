import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travelapp/constants/colors.dart';
import 'package:travelapp/screens/admin/admin_operations.dart';
import 'package:travelapp/screens/bottombar_items/screen_favourite_list.dart';
import 'package:travelapp/screens/bottombar_items/screen_home.dart';
import 'package:travelapp/screens/trip_planner/ui/screen_planing.dart';

class ScreenBottomBar extends StatefulWidget {
  const ScreenBottomBar({super.key, required this.admin});

  final bool admin;

  @override
  State<ScreenBottomBar> createState() => _ScreenBottomBarState();
}

class _ScreenBottomBarState extends State<ScreenBottomBar> {
  int currentSelectedIndex = 0;

  var bottomList = [ScreenHome(), ScreenFavourite()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          widget.admin
              ? Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ScreenAdminOperations()),
                  (route) => false,
                )
              : Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ScreenPlanningTrip(),
                  ),
                );
        },
        backgroundColor: bluePrimary,
        child: const Icon(Icons.add),
      ),
      body: bottomList[currentSelectedIndex],
      bottomNavigationBar: Container(
        // decoration: const BoxDecoration(
        //   boxShadow: [
        //     BoxShadow(
        //       blurRadius: 3,
        //       spreadRadius: 3,
        //       color: blueSecondary,
        //     ),
        //   ],
        // ),
        child: BottomNavigationBar(
          // backgroundColor: bluePrimary,
          elevation: 50,
          onTap: (value) {
            setState(() {
              currentSelectedIndex = value;
            });
          },
          selectedLabelStyle: GoogleFonts.ubuntu(),
          unselectedLabelStyle: GoogleFonts.ubuntu(),
          selectedItemColor: bluePrimary,
          unselectedItemColor: blueSecondary,
          
          currentIndex: currentSelectedIndex,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite), label: 'favorite'),
          ],
        ),
      ),
    );
  }
}
