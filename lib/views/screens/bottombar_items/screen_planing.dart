// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:travelapp/constants/colors.dart';
import 'package:travelapp/constants/sized_boxes.dart';
import 'package:travelapp/controllers/trip_list_controller.dart';
import 'package:travelapp/models/destination_model.dart';
import 'package:travelapp/provider/bottom_bar.dart';
import 'package:travelapp/views/screens/sccreen_bottombar.dart';
import 'package:travelapp/views/screens/bottombar_items/search_place.dart';
import 'package:travelapp/services/trip_functions/calender_pick.dart';
import 'package:travelapp/services/trip_functions/fetch_trip.dart';
import 'package:travelapp/views/screens/trip_planner/ui/calender.dart';
import 'package:travelapp/services/trip_functions/firebase_trip_planner.dart';

import '../../../services/functions/validator_functions.dart';
import '../../wigets/appbar/appbar_maker.dart';
import '../../wigets/text_fields/text_form_field.dart';

final controller = Get.put(TripListController());

class ScreenPlanningTrip extends GetView<TripListController> {
  ScreenPlanningTrip({
    super.key,
  });

  final tripNameController = TextEditingController();

  final DateTimeRange dateObj =
      DateTimeRange(start: DateTime.now(), end: DateTime(2150));

  final formplan = GlobalKey<FormState>();

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
                  Obx(() {
                    final trip = controller.newTrip;
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
                                    boxShadow: [BoxShadow(color: Colors.black)],
                                    color: whitePrimary,
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(15),
                                        bottomRight: Radius.circular(15))),
                                height: 20,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 7),
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
                                      image: NetworkImage(data.images[0]),
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
                                  controller.removePlace(data);
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
                                  child:
                                      const Icon(Icons.clear_sharp, size: 13),
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
                        controller.addPlace(modelFromSearch);
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
      snackShow('choose dates', false);
      return;
    }
    if (controller.newTrip.isEmpty) {
      snackShow('choose a destination', false);
      return;
    }
    bool added = await tripPlannerFirebase.addTrip(
      models: controller.newTrip,
      name: tripNameController.text,
      startDate: calenderPicker.startDate,
      endDate: calenderPicker.endDate,
    );
    if (added) {
      snackShow('Trip added sucessfuly', true);
      controller.clearTrip;
      reposatoryTrip.getTrips();
      calenderPicker.endDate = '';
      calenderPicker.startDate = '';
      tripNameController.text = '';
      pageViewController.animateToPage(0,
          duration: const Duration(milliseconds: 200), curve: Curves.bounceOut);
      Provider.of<BottomNavigationProvider>(context, listen: false)
          .setSelectedIndex(0);
    } else {
      snackShow('something went wrong', false);
    }
  }

  void snackShow(String data, bool green) {
    Get.snackbar(data, '',
        backgroundColor: green ? Colors.greenAccent : Colors.redAccent,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 1));
  }
}
