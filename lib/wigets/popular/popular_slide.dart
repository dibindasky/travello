import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:travelapp/constants/colors.dart';
import 'package:travelapp/constants/sized_boxes.dart';
import 'package:travelapp/data_manageer/fetch_firebase_data.dart';
import 'package:travelapp/screens/screen_details.dart';
import 'package:travelapp/wigets/favorite%20Icon/favourite.dart';

class SlideShowListCard extends StatelessWidget {
  SlideShowListCard({super.key, this.height = 0.25});

  final double height;
  final DataManager dataManager = DataManager();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: SCREEN_HEIGHT * height,
      child: ValueListenableBuilder(
        valueListenable: dataManager.popularDestination,
        builder: (context, value, child) {
          return value.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: InkWell(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ScreenDetails(
                            index: index,
                            destination: value[index],
                          ),
                        ),
                      ),
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        shadowColor: bluePrimary,
                        elevation: 10,
                        // color: bluePrimary,
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          width: SCREEN_WIDTH * 0.44,
                          child: Column(
                            children: [
                              addVerticalSpace(SCREEN_HEIGHT * 0.015),
                              Row(
                                children: [
                                  const Icon(Icons.location_on_outlined),
                                  Text(
                                    value[index].name.length > 18
                                        ? '${value[index].name.substring(0, 16)}..'
                                        : value[index].name,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15),
                                  ),
                                ],
                              ),
                              addVerticalSpace(SCREEN_HEIGHT * 0.02),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  image: DecorationImage(
                                      image: CachedNetworkImageProvider(
                                          value[index].images[0]),
                                      fit: BoxFit.cover),
                                ),
                                height: SCREEN_HEIGHT * 0.15,
                                width: SCREEN_WIDTH * 0.40,
                                child: Align(
                                  alignment: const Alignment(0.9, -0.9),
                                  child: FavButton(destination: value[index]),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  itemCount: value.length,
                );
        },
      ),
    );
  }
}
