import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:travelapp/constants/sized_boxes.dart';
import 'package:travelapp/data_manageer/fetch_firebase_data.dart';
import 'package:travelapp/screens/admin/cred_firebase_admin_operations.dart';
import 'package:travelapp/wigets/favourite_list%20view/tile_favourite.dart';
import 'package:travelapp/wigets/lists/lists_catogery.dart';

// class GridAdmin extends StatelessWidget {
//   GridAdmin(
//       {Key? key,
//       this.catogory,
//       this.district,
//       this.admin = false,
//       this.gridCount = 2,
//       this.fromPlanScreen = false})
//       : super(key: key);

//   final ReposatoryDestination repo = ReposatoryDestination();
//   final CatogoryClass catogoryObject = CatogoryClass();
//   final String? district;
//   final String? catogory;
//   final bool admin;
//   final int gridCount;
//   final bool fromPlanScreen;

//   @override
//   Widget build(BuildContext context) {
// // take data from firebse according to the distict or catagory if necessary
//     Stream<QuerySnapshot<Map<String, dynamic>>> getStream() {
//       Query<Map<String, dynamic>> query =
//           FirebaseFirestore.instance.collection('destinations');
//       if (district != null) {
//         query = query.where('district', isEqualTo: district);
//       }
//       if (catogory != null) {
//         query = query.where('catogory', isEqualTo: catogory);
//       }
//       return query.snapshots();
//     }

//     return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
//       stream: getStream(),
//       builder: (context, streamSnapshot) {
//         if (!streamSnapshot.hasData) {
//           return const Center(child: CircularProgressIndicator());
//         }
//         final document = streamSnapshot.data!.docs;
//         if (document.isEmpty) {
//           return ListView(
//             children: [
//               addVerticalSpace(50),
//               const Center(child: Text('Nothing to Show')),
//             ],
//           );
//         }
//         return GridView.builder(
//           itemCount: document.length,
//           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: gridCount,
//           ),
//           itemBuilder: (context, index) {
//             return TileFavourites(
//               fromPlanScreen: fromPlanScreen,
//               index: index,
//               admin: admin,
//               destination: repo.modelMaker(document[index]),
//             );
//           },
//         );
//       },
//     );
//   }
// }

class GridAdmin extends StatelessWidget {
  GridAdmin(
      {Key? key,
      this.admin = false,
      this.gridCount = 2,
      this.fromPlanScreen = false})
      : super(key: key);

  final ReposatoryDestination repo = ReposatoryDestination();
  final CatogoryClass catogoryObject = CatogoryClass();
  final bool admin;
  final int gridCount;
  final bool fromPlanScreen;
  final DataManager dataManager = DataManager();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: dataManager.searchDestination,
      builder: (context, value, child) {
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
    );
  }
}
