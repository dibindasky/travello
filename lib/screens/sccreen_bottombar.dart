import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:travelapp/constants/colors.dart';
import 'package:travelapp/constants/sized_boxes.dart';
import 'package:travelapp/provider/bottom_bar.dart';
import 'package:travelapp/screens/admin/admin_operations.dart';
import 'package:travelapp/screens/bottombar_items/screen_favourite_list.dart';
import 'package:travelapp/screens/bottombar_items/screen_home.dart';
import 'package:travelapp/screens/bottombar_items/screen_planing.dart';
import 'package:travelapp/screens/bottombar_items/screen_plans.dart';

class ScreenBottomBar extends StatefulWidget {
  const ScreenBottomBar({super.key, required this.admin});

  final bool admin;

  @override
  State<ScreenBottomBar> createState() => _ScreenBottomBarState();
}

class _ScreenBottomBarState extends State<ScreenBottomBar> {
  var bottomList = [
    ScreenHome(),
    const ScreenPlanningTrip(),
    const ScreenPlans(),
    ScreenFavourite()
  ];
  final pageViewController = PageController();

  @override
  Widget build(BuildContext context) {
    dynamic selectedIndex =
        Provider.of<BottomNavigationProvider>(context).selectedIndex;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      floatingActionButton: widget.admin
          ? FloatingActionButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ScreenAdminOperations()),
                  (route) => false,
                );
              },
              backgroundColor: bluePrimary,
              child: const Icon(Icons.add),
            )
          : addHorizontalSpace(0),
      // body: bottomList[selectedIndex],
      body: PageView(
        onPageChanged: (value) {
          Provider.of<BottomNavigationProvider>(context, listen: false)
              .setSelectedIndex(value);
        },
        controller: pageViewController,
        children: bottomList,
      ),
    
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [BoxShadow(blurRadius: 1, spreadRadius: 0)],
            color: whitePrimary),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SalomonBottomBar(
          onTap: (value) {
            pageViewController.animateToPage(value,
                duration: const Duration(milliseconds: 200), curve: Curves.bounceOut);
            Provider.of<BottomNavigationProvider>(context, listen: false)
                .setSelectedIndex(value);
          },
          duration: const Duration(milliseconds: 700),
          selectedItemColor: bluePrimary,
          unselectedItemColor: blueSecondary,
          currentIndex: selectedIndex,
          items: [
            SalomonBottomBarItem(
              icon: const Icon(Icons.home),
              title: Text(
                "Home",
                style: GoogleFonts.ubuntu(color: blueSecondary),
              ),
            ),
            SalomonBottomBarItem(
                icon: const Icon(Icons.flight),
                title: Text(
                  "Planner",
                  style: GoogleFonts.ubuntu(color: blueSecondary),
                ),
                selectedColor: Colors.green),
            SalomonBottomBarItem(
                icon: const Icon(Icons.list),
                title: Text(
                  "Plans",
                  style: GoogleFonts.ubuntu(color: blueSecondary),
                ),
                selectedColor: Colors.greenAccent),
            SalomonBottomBarItem(
                icon: const Icon(Icons.favorite),
                title: Text(
                  "Favourite",
                  style: GoogleFonts.ubuntu(color: blueSecondary),
                ),
                selectedColor: Colors.amber),
          ],
        ),
      ),
    );
  }
}
