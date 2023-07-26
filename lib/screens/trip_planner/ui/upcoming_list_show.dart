import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travelapp/constants/colors.dart';
import 'package:travelapp/constants/sized_boxes.dart';
import 'package:travelapp/functions/user_detail/user_detail_taker.dart';
import 'package:travelapp/model/trip_model.dart';
import 'package:travelapp/screens/trip_planner/trip_functions/fetch_trip.dart';
import 'package:travelapp/screens/trip_planner/ui/screen_planing.dart';
import 'package:travelapp/screens/trip_planner/ui/trip_tile_empty.dart';
import 'package:travelapp/screens/trip_planner/ui/upcoming_trip_bar.dart';

class UpcomingListHome extends StatelessWidget {
  UpcomingListHome({super.key});

  final ReposatoryTrip reposatoryTrip = ReposatoryTrip();

  @override
  Widget build(BuildContext context) {
    int length = 0;
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(parent: BouncingScrollPhysics()),
      scrollDirection: Axis.horizontal,
      child: SizedBox(
        height: SCREEN_WIDTH * 0.25,
        child: Row(
          children: [
            addHorizontalSpace(15),
            InkWell(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ScreenPlanningTrip(
                      index: 2,
                    ),
                  )),
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
            // length==0 ?
            // Center(
            //   child: SizedBox(
            //     height: SCREEN_HEIGHT * 0.038,
            //     width: SCREEN_WIDTH * 0.50,
            //     child: FittedBox(
            //       child: Text(
            //         'Add new plans with us and \nenjoy your trips',
            //         style: GoogleFonts.ubuntu(
            //           fontWeight: FontWeight.w500,
            //         ),
            //       ),
            //     ),
            //   ),
            // ):addVerticalSpace(0),
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
                length = document.length;
                return SizedBox(
                  height: SCREEN_WIDTH * 0.22,
                  width: SCREEN_WIDTH,
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
            //  SizedBox(
            //       height: SCREEN_WIDTH * 0.22,
            //       width: SCREEN_WIDTH,
            //       child: ListView.builder(
            //         scrollDirection: Axis.horizontal,
            //         physics: const NeverScrollableScrollPhysics(),
            //         itemBuilder: (context, index) {
            //           return const Column(
            //             children: [
            //               TripTileEmpty(),
            //               Text(' ')
            //             ],
            //           );
            //         },
            //         itemCount: 3,
            //       ),
            //     )
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
