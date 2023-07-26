import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:travelapp/data_manageer/fetch_firebase_data.dart';
import 'package:travelapp/wigets/favourite_list%20view/tile_favourite.dart';
import 'package:travelapp/wigets/lists/lists_catogery.dart';

class GridSorter extends StatelessWidget {
  GridSorter(
      {super.key,
      this.admin = false,
      this.fromPlanScreen = false,
      this.gridCount = 2});

  final CatogoryClass catogoryObject = CatogoryClass();
  final DataManager dataManager = DataManager();
  final int gridCount;
  final bool admin;
  final bool fromPlanScreen;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ValueListenableBuilder(
      valueListenable: dataManager.searchDestination,
      builder: (context, value, child) {
        if (value.isEmpty) {
          return StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('appinfos')
                .doc('CsvHNqlJ2PZFx0rrhbfK')
                .snapshots(),
            builder: (context, snapshot) {
              return snapshot.hasData
                  ? CachedNetworkImage(
                      imageUrl: snapshot.data!.get('emptyimage'))
                  : const Center(child: CircularProgressIndicator());
            },
          );
        }
        return GridView.builder(
          itemCount: value.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: gridCount,
          ),
          itemBuilder: (context, index) {
            return TileFavourites(
              fromPlanScreen: fromPlanScreen,
              index: index,
              admin: admin,
              destination: value[index],
            );
          },
        );
      },
    ));
  }
}
