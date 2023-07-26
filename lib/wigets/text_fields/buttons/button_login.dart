import 'package:flutter/material.dart';
import 'package:travelapp/constants/colors.dart';

// ignore: must_be_immutable
class ButtonContainer extends StatelessWidget {
  ButtonContainer(
      {super.key,
      required this.textIn,
      this.icon,
      this.height = 50,
      this.size = 16,
      this.radius = 40,
      this.visibleIcon = false,
      this.weight,
      this.fontColor=Colors.black,
      this.color = bluePrimary});

  String textIn;
  double height;
  double size;
  double radius;
  Color color;
  bool visibleIcon;
  Widget? icon;
  FontWeight? weight;
  Color fontColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 15,right: 15),
      height: height,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(
          Radius.circular(radius),
        ),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween ,
          children: [
            Text(
              textIn,
              style: TextStyle(fontSize: size,fontWeight: weight,color: fontColor),
            ),
            Container(
              padding: const EdgeInsets.only(bottom: 5),
              child: visibleIcon ? icon : null,
            ),
          ],
        ),
      ),
    );
  }
}
