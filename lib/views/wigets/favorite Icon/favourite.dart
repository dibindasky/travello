import 'package:flutter/material.dart';

import '../../../constants/colors.dart';
import '../../../models/destination_model.dart';
import '../../../services/sqflite/local_db.dart';
import '../../screens/screen_splash.dart';

class FavButton extends StatelessWidget {
  FavButton(
      {super.key,
      required this.destination,
      this.size = 27,
      this.color = Colors.redAccent});

  final double size;
  final Color color;
  final DestinationModel destination;
  final SQLFlite sqf = SQLFlite();

  favchange() async {
    sqf.ifFav(destination.id)
        ? await sqf.deleteDest(destination.id)
        : await sqf.insertInTodb(destination.id);
   controllerInitial.getFavData();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: sqf.favsNotifier,
      builder: (context, value, _) => sqf.ifFav(destination.id)
          ? InkWell(
              splashColor: whitePrimary,
              onTap: favchange,
              child: Icon(
                Icons.favorite,
                color: color,
                size: size,
              ),
            )
          : InkWell(
              splashColor: whitePrimary,
              onTap: favchange,
              child: Icon(
                Icons.favorite_outline_sharp,
                size: size,
                color: Colors.grey[300],
              ),
            ),
    );
  }
}
