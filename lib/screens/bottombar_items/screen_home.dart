import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:travelapp/constants/colors.dart';
import 'package:travelapp/constants/sized_boxes.dart';
import 'package:travelapp/provider/bottom_bar.dart';
import 'package:travelapp/screens/sccreen_bottombar.dart';
import 'package:travelapp/screens/trip_planner/ui/upcoming_list_show.dart';
import 'package:travelapp/wigets/appbar/appbar_maker.dart';
import 'package:travelapp/wigets/catogery_container/catogery_container.dart';
import 'package:travelapp/wigets/catogery_container/catogery_list.dart';
import 'package:travelapp/wigets/drawer/side_drawer.dart';
import 'package:travelapp/wigets/popular/popular_slide.dart';

class ScreenHome extends StatelessWidget {
  ScreenHome({super.key});

  final CatogeryList catogaries = CatogeryList();
  final GlobalKey<ScaffoldState> scaffoldkey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: scaffoldkey,
        drawer: SideDrawer(
          scaffoldkey: scaffoldkey,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                children: [
                  AppbarMaker(
                      image: 'assets/images/background/carbeach.jpg',
                      scaffoldkey: scaffoldkey),
                  addVerticalSpace(SCREEN_HEIGHT * 0.010),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Text(
                          'UpComing Trips',
                          style: GoogleFonts.ubuntu(
                              fontWeight: FontWeight.w700, fontSize: 18),
                        ),
                      ),
                      addVerticalSpace(4),
                      UpcomingListHome(),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Divider(),
                            const Text(
                              ' Find',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 17,
                              ),
                            ),
                            addVerticalSpace(SCREEN_HEIGHT * 0.025),
                            InkWell(
                              onTap: () {
                                pageViewController.animateToPage(2,
                                    duration: const Duration(milliseconds: 200),
                                    curve: Curves.bounceOut);
                                Provider.of<BottomNavigationProvider>(context,
                                        listen: false)
                                    .setSelectedIndex(2);
                              },
                              child: Container(
                                height: SCREEN_HEIGHT * 0.10,
                                decoration: const BoxDecoration(
                                  color: blueSecondary,
                                  image: DecorationImage(
                                      image: AssetImage(
                                        'assets/images/background/trlwlp3.jpg',
                                      ),
                                      fit: BoxFit.cover),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(20),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    SizedBox(
                                      height: SCREEN_HEIGHT * 0.02,
                                      width: SCREEN_WIDTH * 0.70,
                                      child: FittedBox(
                                        child: Text(
                                          'Find The Best Location For You',
                                          style: GoogleFonts.ubuntu(
                                            color: whitePrimary,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 17,
                                            shadows: const [
                                              Shadow(
                                                  offset: Offset(1, 1),
                                                  blurRadius: 3,
                                                  color: Colors.black),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: SCREEN_HEIGHT * 0.04,
                                      width: SCREEN_WIDTH * 0.10,
                                      child: const FittedBox(
                                        child: Icon(
                                          Icons.search,
                                          size: 30,
                                          color: whiteSecondary,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            addVerticalSpace(SCREEN_HEIGHT * 0.020),
                            const Divider(
                              thickness: 2,
                            ),
                            const Text(
                              ' Category',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 17,
                              ),
                            ),
                            GridView.count(
                              padding: EdgeInsets.symmetric(
                                  horizontal: SCREEN_WIDTH * 0.01),
                              physics: const NeverScrollableScrollPhysics(),
                              crossAxisCount: 4,
                              shrinkWrap: true,
                              children: List.generate(
                                8,
                                (index) => CatogeryContainer(
                                  img: catogaries.catogoryImage[index],
                                  index: index,
                                  headLine: catogaries.names[index],
                                ),
                              ),
                            ),
                            addVerticalSpace(SCREEN_HEIGHT * 0.010),
                            const Divider(
                              thickness: 2,
                            ),
                            const Text(
                              ' Popular',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 17,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              addVerticalSpace(10),
              SlideShowListCard(),
            ],
          ),
        ),
      ),
    );
  }
}
