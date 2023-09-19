import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travelapp/constants/colors.dart';
import 'package:travelapp/views/screens/bottombar_items/search_place.dart';

import '../../../services/firebase/fetch_firebase_data.dart';

// ignore: must_be_immutable
class CatogaryListMaker extends StatefulWidget {
  CatogaryListMaker(
      {super.key,
      required this.list,
      required this.count,
      required this.marker});

  List list;
  int count;
  RxList<bool> marker;
  final DataManager dataManager = DataManager();

  @override
  State<CatogaryListMaker> createState() => _CatogaryListMakerState();
}

class _CatogaryListMakerState extends State<CatogaryListMaker> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        children: List.generate(
          widget.count,
          (index) => InkWell(
            onTap: () => setState(() {
              widget.marker[index] = widget.marker[index] ? false : true;
              controllers.sortData();
            }),
            child: Container(
              decoration: widget.marker[index]
                  ? const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                      color: bluePrimary,
                    )
                  : const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                      color: whiteSecondary,
                    ),
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(6),
              child: widget.marker[index]
                  ? Text(
                      widget.list[index],
                      style: const TextStyle(color: whitePrimary),
                    )
                  : Text(widget.list[index]),
            ),
          ),
        ),
      ),
    );
  }
}
