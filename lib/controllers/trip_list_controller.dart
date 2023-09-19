import 'package:get/get.dart';

import '../models/destination_model.dart';

class TripListController extends GetxController {
  RxList<DestinationModel> newTrip = <DestinationModel>[].obs;

  addPlace(DestinationModel destination) {
    if (!newTrip.contains(destination)) {
      newTrip.add(destination);
    }
  }

  removePlace(DestinationModel destination) {
    newTrip.remove(destination);
  }

  clearTrip() {
    newTrip.clear();
  }
}
