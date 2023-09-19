import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travelapp/constants/colors.dart';
import 'package:travelapp/constants/sized_boxes.dart';
import 'package:travelapp/views/screens/admin/screen_detail_for_admin.dart';
import 'package:travelapp/views/screens/screen_login.dart';

import '../../../controllers/list_controller.dart';
import '../../wigets/grid_maker/grid_sort.dart';
import '../../wigets/lists/catogary_list_maker.dart';
import '../../wigets/lists/lists_catogery.dart';

final listController = Get.put(ListController());

class ScreenAdminOperations extends StatelessWidget {
  ScreenAdminOperations({super.key});

  final CatogoryClass catogoryObject = CatogoryClass();

  final List<bool> catogerySelectorController =
      List.generate(8, (index) => false);

  final List<bool> discrictSelectorController =
      List.generate(14, (index) => false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: blueSecondary,
        title: const Text('Admin'),
        actions: [
          TextButton.icon(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ScreenLogin(),
                  ),
                  (route) => false);
            },
            icon: const Icon(Icons.login),
            label: const Text('signout'),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: blueSecondary,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ScreenDetailsAdmin(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            addVerticalSpace(10),
            const Text(
              'Select Catagory',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            CatogaryListMaker(
                count: catogoryObject.catagoryListForSearch.length,
                list: catogoryObject.catagoryListForSearch,
                marker: listController.catogerySelector),
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
              marker: listController.discrictSelector,
            ),
            const Divider(
              thickness: 2,
            ),
            GridSorter(
              admin: true,
              gridCount: 3,
            ),
          ],
        ),
      ),
    );
  }
}
