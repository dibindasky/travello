import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travelapp/constants/colors.dart';
import 'package:travelapp/constants/sized_boxes.dart';
import 'package:travelapp/model/trip_model.dart';
import 'package:travelapp/screens/trip_planner/planned_details/trip_detail_page.dart';

class PlanScreenTile extends StatefulWidget {
  const PlanScreenTile({super.key, required this.data});

  final TripModel data;

  @override
  State<PlanScreenTile> createState() => _PlanScreenTileState();
}

class _PlanScreenTileState extends State<PlanScreenTile> {
  @override
  Widget build(BuildContext context) {
    bool show = false;
    return InkWell(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TripDetails(tripModel: widget.data),
          )),
      child: Stack(
        children: [
          Card(
            elevation: 2,
            borderOnForeground: false,
            shape:
                BeveledRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Stack(
              children: [
                GridTile(
                  footer: Container(
                      height: SCREEN_HEIGHT * 0.04,
                      color: whitePrimary,
                      child: Center(
                          child: Text(
                        widget.data.name,
                        style: GoogleFonts.ubuntu(
                            fontSize: 17, fontWeight: FontWeight.w500),
                      ))),
                  child: Container(
                    // width: SCREEN_WIDTH * 0.4,
                    // height: SCREEN_HEIGHT *0.15,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        image: DecorationImage(
                            image: AssetImage(
                                'assets/images/catogorybackground/travelplan.jpeg'),
                            fit: BoxFit.cover)),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    icon: const Icon(Icons.more_vert_sharp),
                    onPressed: () {
                      setState(() {
                        show = show ? false : true;
                      });
                    },
                  )),
              ],
            ),
          ),
          show
              ? Positioned(
                  right: 2,
                  top: SCREEN_HEIGHT * 0.04,
                  child: Container(
                    height: SCREEN_HEIGHT * 0.05,
                    decoration: const BoxDecoration(
                        color: whitePrimary,
                        boxShadow: [BoxShadow()],
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: TextButton.icon(
                        onPressed: () async {},
                        icon: const Text(
                          'Delete',
                          style: TextStyle(
                            color: blueSecondary,
                          ),
                        ),
                        label: const Icon(
                          Icons.delete,
                          color: blueSecondary,
                        )),
                  ),
                )
              : addHorizontalSpace(0),
        ],
      ),
    );
  }
}