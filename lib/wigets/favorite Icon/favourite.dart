import 'package:flutter/material.dart';
import 'package:travelapp/constants/colors.dart';
import 'package:travelapp/data_manageer/fetch_firebase_data.dart';
import 'package:travelapp/local_db/local_db.dart';
import 'package:travelapp/model/model_maker.dart';

class FavButton extends StatelessWidget {
  FavButton(
      {super.key,
      required this.destination,
      this.size = 27,
      this.color = Colors.redAccent});

  final double size;
  final Color color;
  final DestinationModel destination;
  final DataManager datamanager = DataManager();
  final SQLFlite sqf = SQLFlite();

  favchange() async {
    sqf.ifFav(destination.id)
        ? await sqf.deleteDest(destination.id)
        : await sqf.insertInTodb(destination.id);
    datamanager.getFavData();
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

// Future<List<Map<String, dynamic>>> getAllCollectionDocs(String collectionName) async {
//     List<Map<String, dynamic>> list = [];
//     try {
//       await _firestoreInstance.collection(collectionName).get().then((value) {
//         list = value.docs.map((e) => e.data()).toList();
//       });
//     } on FirebaseException catch (e) {
//       throw e.message ?? msgSomethingWentWrong;
//     }
//     return list;
//   }

