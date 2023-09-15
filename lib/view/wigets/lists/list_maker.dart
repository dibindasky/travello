import 'package:flutter/material.dart';
import 'package:travelapp/constants/colors.dart';

// ignore: must_be_immutable
class ListMakerSearch extends StatefulWidget {
  ListMakerSearch({
    super.key,
    required this.index,
    required this.list,
    this.selected = false,
    required this.marker,
  });

  List list;
  int index;
  bool selected;
  List<bool> marker;

  @override
  State<ListMakerSearch> createState() => _ListMakerSearchState();
}

class _ListMakerSearchState extends State<ListMakerSearch> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => setState(() {
        widget.selected = widget.selected ? false : true;
        if(widget.selected){
          widget.marker.every((element) => element==false);
        }
        widget.marker[widget.index] = widget.selected;
      }),
      child: Container(
        decoration: widget.selected
            ? const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(4),
                ),
                color: bluePrimary,
              )
            : const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(4),
                ),
                color: whiteSecondary,
              ),
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(6),
        child: Text(widget.list[widget.index]),
      ),
    );
  }
}









