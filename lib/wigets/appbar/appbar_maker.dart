import 'package:flutter/material.dart';
import 'package:travelapp/constants/sized_boxes.dart';

class AppbarMaker extends StatelessWidget {
  const AppbarMaker(
      {super.key, this.scaffoldkey, required this.image, this.height = 0.10});
  final GlobalKey<ScaffoldState>? scaffoldkey;
  final String image;
  final double height;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(left: 10, right: 10),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(image),
              fit: BoxFit.cover,
            ),
            borderRadius: const BorderRadiusDirectional.only(
              bottomEnd: Radius.circular(40),
              bottomStart: Radius.circular(40),
            ),
          ),
          height: SCREEN_HEIGHT * height,
          child: scaffoldkey != null
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        scaffoldkey?.currentState!.openDrawer();
                      },
                      icon: const Icon(
                        Icons.menu_outlined,
                        color: Colors.white,
                      ),
                    ),
                  ],
                )
              : addHorizontalSpace(SCREEN_WIDTH),
        ),
      ],
    );
  }
}
