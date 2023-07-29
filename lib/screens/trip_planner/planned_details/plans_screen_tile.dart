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
                image: AssetImage(
                    'assets/images/catogorybackground/hillforcatogory.jpg'),
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
                      icon: const Icon(Icons.delete_sweep_outlined))),
              Text(
                widget.data.name.length > 15
                    ? '${widget.data.name.substring(0, 10)}..'
                    : widget.data.name,
                style: GoogleFonts.ubuntu(
                    shadows: [
                      const BoxShadow(
                          blurRadius: 1, spreadRadius: 2, color: blueSecondary)
                    ],
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: whitePrimary),
              ),
              addHorizontalSpace(0)
            ],
          )),
    );
  }
}
