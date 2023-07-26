// ignore_for_file: use_build_context_synchronously

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:travelapp/constants/colors.dart';
import 'package:travelapp/constants/sized_boxes.dart';
import 'package:travelapp/functions/map_function/map_lounch.dart';
import 'package:travelapp/model/model_maker.dart';
import 'package:travelapp/model/trip_model.dart';
import 'package:travelapp/screens/screen_details.dart';
import 'package:travelapp/screens/trip_planner/trip_functions/fetch_trip.dart';
import 'package:travelapp/wigets/text_fields/buttons/button_login.dart';
import 'package:google_fonts/google_fonts.dart';

class PlanTileTrip extends StatefulWidget {
  const PlanTileTrip(
      {super.key, required this.destination, required this.tripModel});

  final DestinationModel destination;
  final TripModel tripModel;

  @override
  State<PlanTileTrip> createState() => _PlanTileTripState();
}

class _PlanTileTripState extends State<PlanTileTrip> {
  final TextEditingController noteController = TextEditingController();

  final MapLaunch mapLaunch = MapLaunch();
  bool stackShow = false;
  bool isDeleting = false;
  final ReposatoryTrip reposatoryTrip = ReposatoryTrip();

  @override
  Widget build(BuildContext context) {
    noteController.text =
        widget.tripModel.notes[widget.destination.id] as String;
    return Stack(
      children: [
        Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          shadowColor: bluePrimary,
          elevation: 10,
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.destination.name.length > 18
                          ? '${widget.destination.name.substring(0, 16)}..' 
                          : widget.destination.name ,
                      style: const TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 15),
                    ),
                    Align(
                        alignment: Alignment.topRight,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              stackShow = stackShow ? false : true;
                            });
                          },
                          child: const Icon(
                            Icons.more_vert_outlined,
                            color: blueSecondary,
                          ),
                        ))
                  ],
                ),
                addVerticalSpace(10),
                InkWell(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ScreenDetails(destination: widget.destination),
                      )),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                          image: CachedNetworkImageProvider(
                              widget.destination.images[0]),
                          fit: BoxFit.cover),
                    ),
                    height: SCREEN_HEIGHT * 0.15,
                    width: SCREEN_WIDTH * 0.40,
                  ),
                ),
                addVerticalSpace(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ButtonContainer(
                      textIn: widget.destination.catogory,
                      radius: SCREEN_HEIGHT * 0.05,
                      color: blueSecondary,
                      fontColor: whitePrimary,
                      height: SCREEN_HEIGHT * 0.04,
                      // width: 90,
                    ),
                    InkWell(
                      // onLongPress: () => ,
                      onTap: () {
                        mapLaunch.launchInApp(widget.destination.location);
                      },
                      child: ButtonContainer(
                        textIn: 'map',
                        color: Colors.green,
                        radius: SCREEN_HEIGHT * 0.05,
                        fontColor: whitePrimary,
                        height: SCREEN_HEIGHT * 0.05,
                        // width: 100,
                        visibleIcon: true,
                        icon: const Icon(
                          Icons.location_on_outlined,
                          color: whiteSecondary,
                        ),
                      ),
                    ),
                  ],
                ),
                const Align(
                    alignment: Alignment.topLeft,
                    child: Row(
                      children: [
                        Icon(Icons.edit_note_sharp, color: blueSecondary),
                        Text(' short notes..')
                      ],
                    )),
                SizedBox(
                  width: double.infinity * 0.80,
                  child: TextField(
                    style: GoogleFonts.actor(fontWeight: FontWeight.w500),
                    onTapOutside: (event) async {
                      widget.tripModel.notes[widget.destination.id] =
                          noteController.text;
                      await reposatoryTrip.updateNote(widget.tripModel);
                    },
                    controller: noteController,
                    keyboardType: TextInputType.multiline,
                    maxLines: 3,
                    decoration: const InputDecoration(
                      hintText: 'add notes here..',
                      border: InputBorder.none,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        stackShow
            ? Positioned(
                right: SCREEN_WIDTH * 0.04,
                top: SCREEN_HEIGHT * 0.048,
                child: Container(
                  decoration: const BoxDecoration(
                      color: whitePrimary,
                      boxShadow: [BoxShadow()],
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Column(
                    children: [
                      TextButton.icon(
                          onPressed: () async {
                            reposatoryTrip.tripListNotifier.value.remove(widget.destination);
                            widget.tripModel.places
                                .remove(widget.destination.id);
                            widget.tripModel.notes
                                .remove(widget.destination.id);
                            if (widget.tripModel.places.isEmpty) {
                              Navigator.pop(context);
                            }
                            await reposatoryTrip.delete(
                                widget.tripModel, false);
                          },
                          icon: const Text(
                            'Delete',
                            style: TextStyle(
                              color: blueSecondary,
                            ),
                          ),
                          label: isDeleting
                              ? const CircularProgressIndicator()
                              : const Icon(
                                  Icons.delete,
                                  color: blueSecondary,
                                )),
                      TextButton.icon(
                          onPressed: () {
                            _onShare(context, widget.destination.location);
                          },
                          icon: const Text('Share',
                              style: TextStyle(color: blueSecondary)),
                          label: const Icon(Icons.share_outlined)),
                    ],
                  ),
                ),
              )
            : addHorizontalSpace(0),
      ],
    );
  }

  _onShare(context, String link) async {
    final box = context.findRenderObject() as RenderBox?;
    await Share.share(link,
        subject: '',
        sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
  }
}
