import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/list_controller.dart';
import '../../../services/firebase/fetch_firebase_data.dart';
import '../../wigets/appbar/appbar_maker.dart';
import '../../wigets/grid_maker/grid_sort.dart';
import '../../wigets/lists/catogary_list_maker.dart';
import '../../wigets/lists/lists_catogery.dart';

final controllers = Get.put(ListController());

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
                image: 'assets/images/catogorybackground/riverforcatogory.jpg',
                fromSearch: true),
            const Text(
              '     Select Catagory',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            CatogaryListMaker(
              count: catogoryObject.catagoryListForSearch.length,
              list: catogoryObject.catagoryListForSearch,
              marker: controllers.catogerySelector,
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
              marker: controllers.discrictSelector,
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
