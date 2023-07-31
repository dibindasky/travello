import 'package:flutter/material.dart';
import 'package:travelapp/data_manageer/fetch_firebase_data.dart';
import 'package:travelapp/wigets/appbar/appbar_maker.dart';
import 'package:travelapp/wigets/grid_maker/grid_sort.dart';
import 'package:travelapp/wigets/lists/catogary_list_maker.dart';
import 'package:travelapp/wigets/lists/lists_catogery.dart';

class ScreenSearchPlace extends StatelessWidget {
  ScreenSearchPlace({super.key, this.fromPlanScreen = false});

  final bool fromPlanScreen;
  final CatogoryClass catogoryObject = CatogoryClass();
  final DataManager dataManager = DataManager();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AppbarMaker(
              image: 'assets/images/catogorybackground/riverforcatogory.jpg',fromSearch: true),
            const Text(
              '     Select Catagory',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            CatogaryListMaker(
              count: catogoryObject.catagoryListForSearch.length,
              list: catogoryObject.catagoryListForSearch,
              marker: dataManager.catogerySelector,
            ),
            const Divider(
              thickness: 2,
            ),
            const Text(
              '     Select District',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            CatogaryListMaker(
              count: catogoryObject.districtsListForSearch.length,
              list: catogoryObject.districtsListForSearch,
              marker: dataManager.discrictSelector,
            ),
            const Divider(
              thickness: 2,
            ),
            GridSorter(fromPlanScreen: fromPlanScreen)
          ],
        ),
      ),
    );
  }
}
