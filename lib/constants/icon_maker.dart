import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:travelapp/constants/colors.dart';

// ignore: must_be_immutable
class MakeIcon extends StatelessWidget {
  MakeIcon({super.key, required this.image, this.height = 30, this.width = 30});

  String image;
  double height;
  double width;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      
      borderRadius: const BorderRadius.all(
        Radius.circular(10),
      ),
      child: Container(
        padding: const EdgeInsets.all(3),
        height: height,
        width: width,
        child: SvgPicture.asset(image,color: whitePrimary,),
      ),
    );
  }
}
