import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:travelapp/constants/colors.dart';
import 'package:travelapp/constants/sized_boxes.dart';
import 'package:travelapp/models/trip_model.dart';
import 'package:travelapp/provider/bottom_bar.dart';
import 'package:travelapp/views/screens/sccreen_bottombar.dart';
import 'package:travelapp/views/screens/trip_planner/planned_details/plans_screen_tile.dart';

import '../../../services/functions/user_detail/user_detail_taker.dart';
import '../../wigets/appbar/appbar_maker.dart';

class ScreenPlans extends StatelessWidget {
  const ScreenPlans({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          pageViewController.animateToPage(1,
              duration: const Duration(milliseconds: 200),
              curve: Curves.bounceOut);
          Provider.of<BottomNavigationProvider>(context, listen: false)
              .setSelectedIndex(1);
        },
        backgroundColor: const Color.fromARGB(255, 22, 117, 129),
        child: const Icon(Icons.add,color: whitePrimary,),
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: SCREEN_HEIGHT * 0.11,
              child: const AppbarMaker(
                image: 'assets/images/catogorybackground/forestforcatogory.jpg',
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .doc(currentUserDetail()!.uid)
                      .collection('tripplanner')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    var document = snapshot.data!.docs;
                    if (document.isEmpty) {
                      return Container(
                        padding: const EdgeInsets.only(left: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.green[100],
                                  borderRadius: BorderRadius.circular(
                                      SCREEN_WIDTH * 0.50)),
                              height: SCREEN_WIDTH * 0.50,
                              width: SCREEN_WIDTH * 0.50,
                              child: Icon(
                                Icons.play_disabled_outlined,
                                color: whitePrimary,
                                size: SCREEN_WIDTH * 0.30,
                              ),
                            ),
                            addVerticalSpace(20),
                            Text(
                              'no trips are added',
                              style: GoogleFonts.ubuntu(fontSize: 15),
                            ),
                          ],
                        ),
                      );
                    }
                    return GridView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: document.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10),
                      itemBuilder: (context, index) {
                        TripModel data = TripModel(
                            name: document[index]['name'],
                            places: idConverter(document[index]['places']),
                            notes: document[index]['notes'],
                            endDate: document[index]['endDate'],
                            startDate: document[index]['startDate'],
                            id: document[index]['id']);
                        return PlanScreenTile(
                          data: data,
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<String> idConverter(List<dynamic> array) {
    List<String> ids = [];
    for (var id in array) {
      ids.add(id as String);
    }
    return ids;
  }
}
