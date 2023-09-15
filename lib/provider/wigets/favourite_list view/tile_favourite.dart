// ignore_for_file: use_build_context_synchronously

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:travelapp/constants/colors.dart';
import 'package:travelapp/model/destination_model.dart';
import 'package:travelapp/view/screens/admin/screen_detail_for_admin.dart';
import 'package:travelapp/view/screens/screen_details.dart';

import '../../../controller/firebase/fetch_firebase_data.dart';
import '../../../view/wigets/favorite Icon/favourite.dart';

class TileFavourites extends StatelessWidget {
  TileFavourites({
    super.key,
    required this.index,
    this.admin = false,
    required this.destination,
    this.fromPlanScreen = false,
  });
  final int index;
  final bool admin;
  final DestinationModel destination;
  final DataManager dataManager = DataManager();
  final bool fromPlanScreen;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        await dataManager.updatePopularity(
            id: destination.id, popularity: destination.popularity);
        admin
            ? Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ScreenDetailsAdmin(
                      index: index, destination: destination),
                ),
              )
            : fromPlanScreen
                ? Navigator.pop(context,destination)
                : Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ScreenDetails(index: index, destination: destination),
                    ),
                  );
      },
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
          image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(destination.images[0])),
        ),
        child: admin
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    destination.name,
                    style: const TextStyle(
                      color: whitePrimary,
                      shadows: [
                        Shadow(
                          offset: Offset(0, 1),
                          blurRadius: 2,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                  Text(
                    destination.catogory,
                    style: const TextStyle(
                      color: whitePrimary,
                      shadows: [
                        Shadow(
                          offset: Offset(0, 1),
                          blurRadius: 2,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                      alignment: Alignment.topRight,
                      child: FavButton(
                        destination: destination,
                        color: Colors.redAccent,
                      )),
                  Text(
                    destination.name,
                    style: TextStyle(
                      color: whitePrimary,
                      fontSize: max(10, 20),
                      fontWeight: FontWeight.w600,
                      shadows: const [
                        Shadow(
                          offset: Offset(0, 1),
                          blurRadius: 2,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.location_on_outlined,
                      color: whitePrimary,
                    ),
                    label: Text(
                      destination.catogory,
                      style: TextStyle(
                        color: whitePrimary,
                        fontSize: max(8, 15),
                        fontWeight: FontWeight.w600,
                        shadows: const [
                          Shadow(
                            offset: Offset(0, 1),
                            blurRadius: 2,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
