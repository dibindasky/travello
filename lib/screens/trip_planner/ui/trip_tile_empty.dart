import 'package:flutter/material.dart';
import 'package:travelapp/constants/colors.dart';
import 'package:travelapp/constants/sized_boxes.dart';

class TripTileEmpty extends StatelessWidget {
  const TripTileEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(3),
      height: SCREEN_WIDTH * 0.17,
      width: SCREEN_WIDTH * 0.17,
      decoration: BoxDecoration(
        border: Border.all(color: whiteSecondary, width: 3),
        image: const DecorationImage(
            image:
                AssetImage('assets/images/background/backgrndgraphics.jpeg')),
        color: blueSecondary,
        borderRadius: BorderRadius.circular(SCREEN_WIDTH * 0.15),
      ),
    );
  }
}
