import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travelapp/constants/colors.dart';
import 'package:travelapp/constants/sized_boxes.dart';
import 'package:travelapp/controllers/list_controller.dart';

import '../../../services/sqflite/local_db.dart';
import '../../wigets/appbar/appbar_maker.dart';
import '../../wigets/catogery_container/catogery_list.dart';
import '../../wigets/favorite Icon/tile_favourite.dart';
import '../wigets/drawer/side_drawer.dart';

class ScreenFavourite extends StatelessWidget {
  ScreenFavourite({super.key});

  final GlobalKey<ScaffoldState> scaffoldkey = GlobalKey<ScaffoldState>();
  final CatogeryList catogaries = CatogeryList();
  final SQLFlite sql = SQLFlite();
  final controller = Get.put(ListController());

  @override
  Widget build(BuildContext context) {
    controller.getFavData();
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
              child: Obx(
                () {
                  return controller.favListFromFirebase.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.blue[100],
                                    borderRadius: BorderRadius.circular(
                                        SCREEN_WIDTH * 0.50)),
                                height: SCREEN_WIDTH * 0.50,
                                width: SCREEN_WIDTH * 0.50,
                                child: Icon(
                                  Icons.favorite,
                                  color: whitePrimary,
                                  size: SCREEN_WIDTH * 0.30,
                                ),
                              ),
                              addVerticalSpace(20),
                              Text(
                                'no favourites added',
                                style: GoogleFonts.ubuntu(fontSize: 15),
                              )
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
                            final data = controller.favListFromFirebase[index];
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
