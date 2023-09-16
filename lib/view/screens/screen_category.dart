import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:travelapp/constants/colors.dart';
import 'package:travelapp/controller/firebase/cred_firebase_admin_operations.dart';

import '../wigets/favorite Icon/tile_favourite.dart';
import '../wigets/lists/lists_catogery.dart';

// ignore: must_be_immutable
class ScreenCategory extends StatelessWidget {
  ScreenCategory({super.key, required this.catogeryIndex});

  int catogeryIndex;
  CatogoryClass catogoryObject = CatogoryClass();
  final ReposatoryDestination repo = ReposatoryDestination();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(catogoryObject.catagoryListForSearch[catogeryIndex]),
        backgroundColor: bluePrimary,foregroundColor: whitePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('destinations')
                    .where('catogory',
                        isEqualTo:
                            catogoryObject.catagoryListForSearch[catogeryIndex])
                    .snapshots(),
                builder: (context, streamSnapshot) {
                  if (!streamSnapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final document = streamSnapshot.data!.docs;
                  return GridView.builder(
                    itemCount: document.length,
                    physics: const BouncingScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                    itemBuilder: (context, index) {
                      return TileFavourites(
                        index: index,
                        destination: repo.modelMaker(document[index]),
                      );
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
