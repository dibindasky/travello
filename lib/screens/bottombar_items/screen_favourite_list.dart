import 'package:flutter/material.dart';
import 'package:travelapp/constants/colors.dart';
import 'package:travelapp/constants/sized_boxes.dart';
import 'package:travelapp/data_manageer/fetch_firebase_data.dart';
import 'package:travelapp/local_db/local_db.dart';
import 'package:travelapp/screens/admin/cred_firebase_admin_operations.dart';
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
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
          child: Column(
            children: [
              Container(
                height: SCREEN_HEIGHT * 0.15,
                decoration: const BoxDecoration(
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(40)),
                  image: DecorationImage(
                      image: AssetImage('assets/images/background/trlwlp6.jpg'),
                      fit: BoxFit.cover),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        scaffoldkey.currentState!.openDrawer();
                      },
                      icon: const Icon(
                        Icons.menu_outlined,
                        color: Colors.white,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(0, 15, 20, 0),
                      child: const Text(
                        'Your Favourite Destinations',
                        style: TextStyle(
                            color: whitePrimary,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            shadows: [
                              Shadow(
                                  offset: Offset(0, 1),
                                  blurRadius: 5,
                                  color: Colors.black)
                            ]),
                      ),
                    )
                  ],
                ),
              ),
              // SizedBox(
              //   height: SCREEN_WIDTH * 0.20,
              //   child: ListView(
              //     physics: const BouncingScrollPhysics(
              //         decelerationRate: ScrollDecelerationRate.normal,
              //         parent: BouncingScrollPhysics()),
              //     shrinkWrap: true,
              //     scrollDirection: Axis.horizontal,
              //     children: List.generate(
              //       8,
              //       (index) => SizedBox(
              //         height: SCREEN_WIDTH * 0.19,
              //         child: Stack(
              //           children: [
              //             CatogeryContainer(
              //               index: index,
              //               width: 0.18,
              //               height: 0.18,
              //               headLine: catogaries.names[index],
              //               icon: catogaries.icons[index],
              //             ),
              //             Positioned(right: 8, top: 8, child: CheckBoxMarker()),
              //           ],
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              addVerticalSpace(10),
              Expanded(
                child: ValueListenableBuilder(
                  valueListenable: dataManager.favListFromFirebase,
                  builder: (context, favList, child) {
                    return GridView.builder(
                      physics: BouncingScrollPhysics(),
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
      ),
    );
  }
}
