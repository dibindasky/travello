import 'package:flutter/material.dart';
import 'package:travelapp/constants/sized_boxes.dart';
import 'package:travelapp/views/screens/screen_search_text.dart';

class AppbarMaker extends StatelessWidget {
  const AppbarMaker(
      {super.key, this.scaffoldkey, required this.image, this.height = 0.10, this.fromSearch=false,});
  final GlobalKey<ScaffoldState>? scaffoldkey;
  final String image;
  final double height;
  final bool fromSearch;
  @override
  Widget build(BuildContext context) {
    return Container(
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
      child:  
          Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                scaffoldkey != null?IconButton(
                  onPressed: () {
                    scaffoldkey?.currentState!.openDrawer();
                  },
                  icon: const Icon(
                    Icons.menu_outlined,
                    color: Colors.white,
                  ),
                ):addHorizontalSpace(0),
                fromSearch?
                IconButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const SearchTextScreen(),));
                  },
                  icon: const Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                ):addHorizontalSpace(0),                  
              ],
            )
    );
  }
}
