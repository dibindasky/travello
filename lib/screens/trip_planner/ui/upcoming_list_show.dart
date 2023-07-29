import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:travelapp/constants/sized_boxes.dart';
import 'package:travelapp/functions/user_detail/user_detail_taker.dart';
import 'package:travelapp/model/trip_model.dart';
import 'package:travelapp/provider/bottom_bar.dart';
import 'package:travelapp/screens/sccreen_bottombar.dart';
import 'package:travelapp/screens/trip_planner/trip_functions/fetch_trip.dart';
import 'package:travelapp/screens/trip_planner/ui/trip_tile_empty.dart';
import 'package:travelapp/screens/trip_planner/ui/upcoming_trip_bar.dart';

class UpcomingListHome extends StatelessWidget {
  UpcomingListHome({super.key});

  final ReposatoryTrip reposatoryTrip = ReposatoryTrip();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: SizedBox(
        height: SCREEN_WIDTH * 0.25,
        child: Row(
          children: [
            addHorizontalSpace(15),
            InkWell(
              onTap: () {
                pageViewController.animateToPage(1,
                duration: const Duration(milliseconds: 200), curve: Curves.bounceOut);
                Provider.of<BottomNavigationProvider>(context, listen: false)
                .setSelectedIndex(1);
              },
              child: Column(
                children: [
                  addVerticalSpace(SCREEN_HEIGHT * 0.008),
                  const Center(
                    child: TripTileEmpty(),
                  ),
                  const Text('+ add'),
                ],
              ),
            ),
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(currentUserDetail()!.uid)
                  .collection('tripplanner')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }
                var document = snapshot.data!.docs;
                if (document.isEmpty) {
                  return Container(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        'Introducing Trip Planner \nYour Ultimate Travel Companion',
                        style: GoogleFonts.ubuntu(
                            fontWeight: FontWeight.w600, fontSize: 17),
                      ));
                }
                return SizedBox(
                  height: SCREEN_WIDTH * 0.22,
                  width: double.maxFinite,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      TripModel model = TripModel(
                          endDate: document[index]['endDate'],
                          startDate: document[index]['startDate'],
                          name: document[index]['name'] as String,
                          id: document[index]['id'] as String,
                          places: idConverter(document[index]['places']),
                          notes: document[index]['notes']);
                      return TripbarTile(model: model);
                    },
                    itemCount: document.length,
                  ),
                );
              },
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
