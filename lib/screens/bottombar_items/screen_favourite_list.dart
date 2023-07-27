import 'package:flutter/material.dart';
import 'package:travelapp/constants/sized_boxes.dart';
import 'package:travelapp/data_manageer/fetch_firebase_data.dart';
import 'package:travelapp/local_db/local_db.dart';
import 'package:travelapp/screens/admin/cred_firebase_admin_operations.dart';
import 'package:travelapp/wigets/appbar/appbar_maker.dart';
import 'package:travelapp/wigets/catogery_container/catogery_list.dart';
import 'package:travelapp/wigets/drawer/side_drawer.dart';
import 'package:travelapp/wigets/favourite_list%20view/tile_favourite.dart';

class ScreenFavourite extends StatelessWidget {
  ScreenFavourite({super.key});

  final GlobalKey<ScaffoldState> scaffoldkey = GlobalKey<ScaffoldState>();
  final CatogeryList catogaries = CatogeryList();
  final SQLFlite sql = SQLFlite();
  final DataManager dataManager = DataManager();
  final ReposatoryDestination repo = ReposatoryDestination();

  @override
  Widget build(BuildContext context) {
    dataManager.getFavData();
    return Scaffold(
      key: scaffoldkey,
      drawer: SideDrawer(
        scaffoldkey: scaffoldkey,
      ),
      body: SafeArea(
        child: Column(
          children: [
            AppbarMaker(image: 'assets/images/background/trlwlp6.jpg',scaffoldkey: scaffoldkey,height: 0.15),
            addVerticalSpace(10),
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: dataManager.favListFromFirebase,
                builder: (context, favList, child) {
                  return GridView.builder(
                    physics: const BouncingScrollPhysics(),
                  itemCount: sql.favsNotifier.value.length,
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    final data = favList[index];
                    return TileFavourites(
                      index: index,
                      destination: data
                    );
                  },
                );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
