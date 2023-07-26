import 'package:flutter/material.dart';
import 'package:travelapp/constants/colors.dart';
import 'package:travelapp/constants/sized_boxes.dart';

// ignore: must_be_immutable
class CheckBoxMarker extends StatefulWidget {
  CheckBoxMarker({super.key, this.mark = false});

  bool mark;

  @override
  State<CheckBoxMarker> createState() => _CheckBoxMarkerState();
}

class _CheckBoxMarkerState extends State<CheckBoxMarker> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          widget.mark = widget.mark ? false : true;
        });
      },
      child: Container(
          height: SCREEN_WIDTH * 0.18,
          width: SCREEN_WIDTH * 0.18,
          alignment: Alignment.topRight,
          child: widget.mark
              ? const Icon(
                  Icons.check_circle,
                  color: whiteSecondary,
                )
              : null),
    );
  }
}
