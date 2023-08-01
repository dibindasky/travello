import 'package:flutter/material.dart';
import 'package:travelapp/constants/colors.dart';
import 'package:travelapp/constants/sized_boxes.dart';
import 'package:travelapp/model/trip_model.dart';
import 'package:travelapp/screens/trip_planner/planned_details/trip_detail_page.dart';

class TripbarTile extends StatelessWidget {
  const TripbarTile({super.key, required this.model});

  final TripModel model;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          InkWell(
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => TripDetails(tripModel: model),)),
            child: Container(
              margin: const EdgeInsets.all(3),
              height: SCREEN_WIDTH * 0.17,
              width: SCREEN_WIDTH * 0.17,
              decoration: BoxDecoration(
                border: Border.all(
                    color: const Color.fromARGB(255, 42, 211, 42), width: 3),
                image: const DecorationImage(
                    image: AssetImage(
                        'assets/images/background/backgrndgraphics.jpeg'),
                    fit: BoxFit.cover),
                color: blueSecondary,
                borderRadius: BorderRadius.circular(SCREEN_WIDTH * 0.17),
              ),
            ),
          ),
          Text(model.name.length<6 ? model.name : model.name.substring(0,6))
        ],
      ),
    );
  }
}
