// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:travelapp/constants/colors.dart';
import 'package:travelapp/data_manageer/fetch_firebase_data.dart';
import 'package:travelapp/wigets/grid_maker/grid_sort.dart';
import 'package:travelapp/wigets/lists/catogary_list_maker.dart';
import 'package:travelapp/wigets/lists/lists_catogery.dart';

class ScreenSearchPlace extends StatelessWidget {
  ScreenSearchPlace({super.key, this.fromPlanScreen = false});

  bool fromPlanScreen;
  CatogoryClass catogoryObject = CatogoryClass();
  DataManager dataManager = DataManager();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
        backgroundColor: bluePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select Catagory',
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
              'Select District',
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
