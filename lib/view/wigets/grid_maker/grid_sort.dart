import 'package:flutter/material.dart';

import '../../../controller/firebase/fetch_firebase_data.dart';
import '../favorite Icon/tile_favourite.dart';
import '../lists/lists_catogery.dart';

class GridSorter extends StatelessWidget {
  GridSorter(
      {super.key,
      this.admin = false,
      this.fromPlanScreen = false,
      this.gridCount = 2});

  final CatogoryClass catogoryObject = CatogoryClass();
  final DataManager dataManager = DataManager();
  final int gridCount;
  final bool admin;
  final bool fromPlanScreen;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ValueListenableBuilder(
      valueListenable: dataManager.searchDestination,
      builder: (context, value, child) {
        if (value.isEmpty) {
          return const Center(child: Text('nothing to show'),);
        }
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
    ));
  }
}
