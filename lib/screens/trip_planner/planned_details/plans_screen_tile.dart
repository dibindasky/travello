import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travelapp/constants/colors.dart';
import 'package:travelapp/constants/sized_boxes.dart';
import 'package:travelapp/model/trip_model.dart';
import 'package:travelapp/screens/trip_planner/planned_details/trip_detail_page.dart';
import 'package:travelapp/screens/trip_planner/trip_functions/fetch_trip.dart';

class PlanScreenTile extends StatefulWidget {
  PlanScreenTile({super.key, required this.data});

  final TripModel data;
  final ReposatoryTrip reposatoryTrip = ReposatoryTrip();

  @override
  State<PlanScreenTile> createState() => _PlanScreenTileState();
}

class _PlanScreenTileState extends State<PlanScreenTile> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TripDetails(tripModel: widget.data),
          )),
      child: Container(
          margin: const EdgeInsets.all(3),
          height: SCREEN_WIDTH * 0.17,
          width: SCREEN_WIDTH * 0.17,
          decoration: BoxDecoration(
            image: const DecorationImage(
                image: AssetImage('assets/images/catogorybackground/hillforcatogory.jpg'),
                fit: BoxFit.cover),
            color: blueSecondary,
            borderRadius: BorderRadius.circular(SCREEN_WIDTH * 0.05),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                      onPressed: () {
                        widget.reposatoryTrip.delete(widget.data, true);
                      },
                      icon: Icon(Icons.delete_sweep_outlined))),
              Text(
                widget.data.name,
                style: GoogleFonts.ubuntu(
                    shadows: [
                      BoxShadow(
                          blurRadius: 1, spreadRadius: 2, color: blueSecondary)
                    ],
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: whitePrimary),
              ),
              addHorizontalSpace(0)
            ],
          )),
      // child: Stack(
      //   children: [
      //     Container(
      //       child: Column(
      //         children: [
      //           Align(
      //               alignment: Alignment.topRight,
      //               child: IconButton(
      //                 icon: const Icon(Icons.more_vert_sharp),
      //                 onPressed: () {
      //                   setState(() {
      //                     show = show ? false : true;
      //                   });
      //                 },
      //               )),
      //           Container(
      //               height: SCREEN_HEIGHT * 0.04,
      //               color: whitePrimary,
      //               child: Center(
      //                   child: Text(
      //                 widget.data.name,
      //                 style: GoogleFonts.ubuntu(
      //                     fontSize: 17, fontWeight: FontWeight.w500),
      //               ))),
      //           Container(
      //             // width: SCREEN_WIDTH * 0.4,
      //             // height: SCREEN_HEIGHT *0.15,
      //             decoration: const BoxDecoration(
      //                 borderRadius: BorderRadius.all(Radius.circular(15)),
      //                 image: DecorationImage(
      //                     image: AssetImage(
      //                         'assets/images/catogorybackground/travelplan.jpeg'),
      //                     fit: BoxFit.cover)),
      //           ),

      //         ],
      //       ),
      //     ),
      // show
      //     ? Positioned(
      //         right: 2,
      //         top: SCREEN_HEIGHT * 0.04,
      //         child: Container(
      //           height: SCREEN_HEIGHT * 0.05,
      //           decoration: const BoxDecoration(
      //               color: whitePrimary,
      //               boxShadow: [BoxShadow()],
      //               borderRadius: BorderRadius.all(Radius.circular(10))),
      //           child: TextButton.icon(
      //               onPressed: () async {},
      //               icon: const Text(
      //                 'Delete',
      //                 style: TextStyle(
      //                   color: blueSecondary,
      //                 ),
      //               ),
      //               label: const Icon(
      //                 Icons.delete,
      //                 color: blueSecondary,
      //               )),
      //         ),
      //       )
      //     : addHorizontalSpace(0),
      //   ],
      // ),
    );
  }
}
