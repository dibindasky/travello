import 'package:flutter/foundation.dart';
import 'package:travelapp/model/destination_model.dart';

class TripListMaker with ChangeNotifier {
  ValueNotifier<List<DestinationModel>> newTrip = ValueNotifier([]);
  addPlace(DestinationModel destination) {
    if (!newTrip.value.contains(destination)) {
      newTrip.value.add(destination);
      newTrip.notifyListeners();
    }
  }
  
  removePlace(DestinationModel destination) {
    newTrip.value.remove(destination);
    newTrip.notifyListeners();
  }

  clearNotifier(){
    newTrip.value.clear();
    newTrip.notifyListeners();
  }

}
