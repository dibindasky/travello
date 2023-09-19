import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../services/firebase/cred_firebase_admin_operations.dart';
import '../../../services/firebase/fetch_firebase_data.dart';
import '../../screens/bottombar_items/search_place.dart';
import '../favorite Icon/tile_favourite.dart';
import '../lists/lists_catogery.dart';

class GridAdmin extends StatelessWidget {
  GridAdmin(
      {Key? key,
      this.admin = false,
      this.gridCount = 2,
      this.fromPlanScreen = false})
      : super(key: key);

  final ReposatoryDestination repo = ReposatoryDestination();
  final CatogoryClass catogoryObject = CatogoryClass();
  final bool admin;
  final int gridCount;
  final bool fromPlanScreen;
  final DataManager dataManager = DataManager();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final list = controllers.searchList;
      print('getx builder => () search list  ${list.length}');
      if (list.isEmpty) {
        return Text('no data');
      }
      return GridView.builder(
        itemCount: list.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: gridCount,
        ),
        itemBuilder: (context, index) {
          return TileFavourites(
            fromPlanScreen: fromPlanScreen,
            index: index,
            admin: admin,
            destination: list[index],
          );
        },
      );
    });
  }
}
