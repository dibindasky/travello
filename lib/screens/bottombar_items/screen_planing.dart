// ignore_for_file: use_build_context_synchronously
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travelapp/constants/colors.dart';
import 'package:travelapp/constants/sized_boxes.dart';
import 'package:travelapp/functions/validator_functions.dart';
import 'package:travelapp/model/model_maker.dart';
import 'package:travelapp/provider/bottom_bar.dart';
import 'package:travelapp/screens/search_place.dart';
import 'package:travelapp/screens/trip_planner/trip_functions/calender_pick.dart';
import 'package:travelapp/screens/trip_planner/trip_functions/fetch_trip.dart';
import 'package:travelapp/screens/trip_planner/ui/calender.dart';
import 'package:travelapp/screens/trip_planner/trip_functions/firebase_trip_planner.dart';
import 'package:travelapp/screens/trip_planner/trip_functions/trip_list_maker.dart';
import 'package:travelapp/wigets/appbar/appbar_maker.dart';
import 'package:travelapp/wigets/text_fields/text_form_field.dart';

class ScreenPlanningTrip extends StatefulWidget {
  const ScreenPlanningTrip({
    super.key,
  });

  @override
  State<ScreenPlanningTrip> createState() => _ScreenPlanningTripState();
}

class _ScreenPlanningTripState extends State<ScreenPlanningTrip> {
  final tripNameController = TextEditingController();
  final DateTimeRange dateObj =
      DateTimeRange(start: DateTime.now(), end: DateTime(2150));
  final formplan = GlobalKey<FormState>();
  final TripListMaker tripListMaker = TripListMaker();
  final TripPlannerFirebase tripPlannerFirebase = TripPlannerFirebase();
  final ReposatoryTrip reposatoryTrip = ReposatoryTrip();
  final CalenderPicker calenderPicker = CalenderPicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        elevation: 5,
        foregroundColor: whitePrimary,
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
        onPressed: () async {
          await addTrip(context);
        },
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            const AppbarMaker(
              image: 'assets/images/background/trlwlp2.jpg',
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Trip planner',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
                  ),
                  Container(
                    height: SCREEN_HEIGHT * 0.20,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image:
                                AssetImage('assets/images/map/traveller.jpg'))),
                  ),
                  addVerticalSpace(10),
                  Form(
                    key: formplan,
                    child: FormFields(
                      textLabel: 'trip name',
                      textContol: tripNameController,
                      function: isValidTripName,
                    ),
                  ),
                  addVerticalSpace(8),
                  const Divider(
                    thickness: 2,
                  ),
                  addVerticalSpace(8),
                  CalenderDatePicker(dateObj: dateObj),
                  addVerticalSpace(8),
                  const Divider(
                    thickness: 2,
                  ),
                  addVerticalSpace(8),
                  const Text(
                    'Choose your destinations',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
                  ),
                  addVerticalSpace(10),
                  ValueListenableBuilder(
                      valueListenable: tripListMaker.newTrip,
                      builder: (context, trip, child) {
                        return GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 4),
                          itemCount: trip.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            DestinationModel data = trip[index];
                            return Stack(
                              fit: StackFit.passthrough,
                              children: [
                                GridTile(
                                  footer: Container(
                                    decoration: const BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(color: Colors.black)
                                        ],
                                        color: whitePrimary,
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(15),
                                            bottomRight: Radius.circular(15))),
                                    height: 20,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 7),
                                    child: SingleChildScrollView(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      scrollDirection: Axis.horizontal,
                                      child: Text(
                                        data.name,
                                        //style: TextStyle(color: whitePrimary),
                                      ),
                                    ),
                                  ),
                                  child: Container(
                                    margin: const EdgeInsets.all(7),
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: CachedNetworkImageProvider(
                                              data.images[0]),
                                          fit: BoxFit.cover),
                                      color: blueSecondary,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.topRight,
                                  child: InkWell(
                                    onTap: () {
                                      tripListMaker.removePlace(data);
                                    },
                                    child: Container(
                                      height: SCREEN_WIDTH * 0.04,
                                      width: SCREEN_WIDTH * 0.04,
                                      decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            195, 255, 255, 255),
                                        border: Border.all(
                                            strokeAlign:
                                                BorderSide.strokeAlignInside),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: const Icon(Icons.clear_sharp,
                                          size: 13),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      }),
                  GestureDetector(
                    onTap: () async {
                      DestinationModel? modelFromSearch =
                          await navigateAndGetValue(context);
                      if (modelFromSearch != null) {
                        tripListMaker.addPlace(modelFromSearch);
                      }
                    },
                    child: Container(
                      margin: const EdgeInsets.all(7),
                      decoration: BoxDecoration(
                        boxShadow: const [BoxShadow(color: Colors.black)],
                        color: whiteSecondary,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      height: SCREEN_WIDTH * 0.20,
                      width: SCREEN_WIDTH * 0.20,
                      child: const Icon(Icons.add),
                    ),
                  ),
                  addVerticalSpace(10),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }

  Future<DestinationModel?> navigateAndGetValue(BuildContext context) async {
    return await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ScreenSearchPlace(fromPlanScreen: true),
      ),
    );
  }

  addTrip(BuildContext context) async {
    if (!formplan.currentState!.validate()) {
      return;
    }

    if (calenderPicker.startDate == '' || calenderPicker.endDate == '') {
      snackShow(context, 'choose dates');
      return;
    }
    if (tripListMaker.newTrip.value.isEmpty) {
      snackShow(context, 'choose a destination');
      return;
    }
    bool added = await tripPlannerFirebase.addTrip(
      models: tripListMaker.newTrip.value,
      name: tripNameController.text,
      startDate: calenderPicker.startDate,
      endDate: calenderPicker.endDate,
    );
    if (added) {
      reposatoryTrip.getTrips();
      calenderPicker.endDate = '';
      calenderPicker.startDate = '';
      Provider.of<BottomNavigationProvider>(context, listen: false)
          .setSelectedIndex(0);
    } else {
      snackShow(context, 'something went wrong');
    }
  }

  void snackShow(BuildContext context, String data) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Center(child: Text(data)),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.only(left: 80, right: 80, bottom: 20),
        duration: const Duration(seconds: 1),
        backgroundColor: bluePrimary,
      ),
    );
  }
}
