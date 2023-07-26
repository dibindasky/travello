import 'package:flutter/material.dart';
import 'package:travelapp/constants/colors.dart';
import 'package:travelapp/constants/sized_boxes.dart';
import 'package:travelapp/model/trip_model.dart';
import 'package:travelapp/screens/trip_planner/planned_details/planned_tile.dart';
import 'package:travelapp/screens/trip_planner/trip_functions/fetch_trip.dart';
import 'package:travelapp/wigets/text_fields/buttons/button_login.dart';

class TripDetails extends StatefulWidget {
  const TripDetails({super.key, required this.tripModel});
  final TripModel tripModel;

  @override
  State<TripDetails> createState() => _TripDetailsState();
}

class _TripDetailsState extends State<TripDetails> {
  final ReposatoryTrip reposatoryTrip = ReposatoryTrip();
  bool showDate = false;
  bool showDelete = false;
  bool showButtons = false;

  @override
  Widget build(BuildContext context) {
    reposatoryTrip.getNotifier(widget.tripModel.name);
    var appbar = AppBar(title: Text(widget.tripModel.name), actions: [
      IconButton(
          onPressed: () {
            setState(() {
              showButtons = showButtons ? false : true;
              if (!showButtons) {
                showDate = false;
                showDelete = false;
              }
            });
          },
          icon: Icon(showButtons ? Icons.arrow_drop_down : Icons.menu)),
      addHorizontalSpace(20)
    ]);
    return Scaffold(
      appBar: appbar,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Stack(
            children: [
              SizedBox(
                height: SCREEN_HEIGHT -
                    appbar.preferredSize.height -
                    MediaQuery.of(context).padding.vertical -
                    SCREEN_HEIGHT * 0.02,
                child: ValueListenableBuilder(
                  valueListenable: reposatoryTrip.tripListNotifier,
                  builder: (context, tripList, child) {
                    return GridView.builder(
                      physics: const BouncingScrollPhysics(
                          decelerationRate: ScrollDecelerationRate.normal),
                      itemCount: tripList.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2, childAspectRatio: 0.55),
                      itemBuilder: (context, index) {
                        return PlanTileTrip(
                          destination: tripList[index],
                          tripModel: widget.tripModel,
                        );
                      },
                    );
                  },
                ),
              ),
              showButtons
                  ? Positioned(
                      right: 10,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              showDate
                                  ? ButtonContainer(
                                      fontColor: whitePrimary,
                                      textIn:
                                          'Date : ${widget.tripModel.startDate} - ${widget.tripModel.endDate}',
                                      color: blueSecondary,
                                      visibleIcon: true,
                                      icon: const Icon(
                                        Icons.calendar_month_rounded,
                                        color: whitePrimary,
                                      ))
                                  : addHorizontalSpace(0),
                              addHorizontalSpace(10),
                              Container(
                                decoration: BoxDecoration(
                                    boxShadow: const [BoxShadow()],
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(
                                        SCREEN_HEIGHT * 0.05)),
                                child: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        showDate = showDate ? false : true;
                                      });
                                    },
                                    icon: const Icon(
                                        Icons.calendar_month_rounded)),
                              ),
                            ],
                          ),
                          addVerticalSpace(10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              showDelete
                                  ? InkWell(
                                      onTap: () {
                                        reposatoryTrip.delete(
                                            widget.tripModel, true);
                                        Navigator.pop(context);
                                      },
                                      child: ButtonContainer(
                                          fontColor: whitePrimary,
                                          textIn: 'Delete trip',
                                          color: blueSecondary,
                                          visibleIcon: true,
                                          icon: const Icon(
                                            Icons.delete_sweep_outlined,
                                            color: whitePrimary,
                                          )),
                                    )
                                  : addHorizontalSpace(0),
                              addHorizontalSpace(10),
                              Container(
                                decoration: BoxDecoration(
                                    boxShadow: const [BoxShadow()],
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(
                                        SCREEN_HEIGHT * 0.05)),
                                child: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        showDelete = showDelete ? false : true;
                                      });
                                    },
                                    icon: const Icon(Icons.delete)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  : addHorizontalSpace(0),
            ],
          ),
        ),
      ),
    );
  }
}
