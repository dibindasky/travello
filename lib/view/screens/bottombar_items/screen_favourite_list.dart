import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travelapp/constants/colors.dart';
import 'package:travelapp/constants/sized_boxes.dart';
import 'package:travelapp/controller/firebase/cred_firebase_admin_operations.dart';
import 'package:travelapp/view/screens/wigets/drawer/side_drawer.dart';
import 'package:travelapp/provider/wigets/favourite_list%20view/tile_favourite.dart';

import '../../../controller/firebase/fetch_firebase_data.dart';
import '../../../controller/sqflite/local_db.dart';
import '../../wigets/appbar/appbar_maker.dart';
import '../../wigets/catogery_container/catogery_list.dart';

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
            AppbarMaker(
                image: 'assets/images/background/trlwlp6.jpg',
                scaffoldkey: scaffoldkey,
                height: 0.15),
            addVerticalSpace(10),
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: dataManager.favListFromFirebase,
                builder: (context, favList, child) {
                  return favList.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                decoration: BoxDecoration(color: Colors.blue[100],borderRadius: BorderRadius.circular(SCREEN_WIDTH * 0.50)),
                                height: SCREEN_WIDTH * 0.50,
                                width: SCREEN_WIDTH * 0.50,
                                child: Icon(Icons.favorite,color: whitePrimary,size: SCREEN_WIDTH * 0.30,),
                              ),
                              addVerticalSpace(20),
                              Text('no favourites added',style: GoogleFonts.ubuntu(fontSize: 15),)
                            ],
                          ),
                        )
                      : GridView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: sql.favsNotifier.value.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2),
                          itemBuilder: (context, index) {
                            final data = favList[index];
                            return TileFavourites(
                                index: index, destination: data);
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
