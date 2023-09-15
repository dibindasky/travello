import 'package:flutter/material.dart';

import '../../../controller/firebase/cred_firebase_admin_operations.dart';
import '../../../controller/firebase/fetch_firebase_data.dart';
import '../../../provider/wigets/favourite_list view/tile_favourite.dart';
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
    return ValueListenableBuilder(
      valueListenable: dataManager.searchDestination,
      builder: (context, value, child) {
        return GridView.builder(
          itemCount: value.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: gridCount,
          ),
          itemBuilder: (context, index) {
            return TileFavourites(
              fromPlanScreen: fromPlanScreen,
              index: index,
              admin: admin,
              destination: value[index],
            );
          },
        );
      },
    );
  }
}
