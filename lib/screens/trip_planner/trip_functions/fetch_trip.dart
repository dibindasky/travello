import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:travelapp/data_manageer/fetch_firebase_data.dart';
import 'package:travelapp/functions/user_detail/user_detail_taker.dart';
import 'package:travelapp/model/model_maker.dart';
import 'package:travelapp/model/trip_model.dart';

class ReposatoryTrip with ChangeNotifier {
  ReposatoryTrip._() {
    getTrips();
  }
  static final ReposatoryTrip _instance = ReposatoryTrip._();
  factory ReposatoryTrip() => _instance;

  final DataManager dataManager = DataManager();

  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  List<DestinationModel> allTripDestinations = [];
  ValueNotifier<List<DestinationModel>> tripListNotifier = ValueNotifier([]);

  List<Map<String, dynamic>> tripslist = [];

  getTrips() async {
    tripslist.clear();
    tripslist = await getAllTrips();
    List<TripModel> models = [];
    for (var element in tripslist) {
      models.add(TripModel(
          endDate: element['startDate'],
          startDate: element['endDate'],
          name: element['name'] as String,
          places: idConverter(element['places']),
          notes: element['notes'],
          id: element['id'] as String));
    }
    allTripDestinations.clear();
    for (var model in models) {
      // List<String> date = model.endDate!.split('/').toList();
      // final DateTime last =
      //     DateTime(date[2] as int, date[1] as int, date[0] as int, 0, 0);
      // if (DateTime.now().compareTo(last) > 0) {
      //   await delete(model, true);
      // } else {
      for (var destination in dataManager.documentsFromFirebase) {
        if (model.places.contains(destination.id) &&
            !allTripDestinations.contains(destination)) {
          allTripDestinations.add(destination);
        }
        // }
      }
    }
  }

  Future<List<Map<String, dynamic>>> getAllTrips() async {
    List<Map<String, dynamic>> list = [];
    try {
      await fireStore
          .collection('users')
          .doc(currentUserDetail()!.uid)
          .collection('tripplanner')
          .get()
          .then((value) => list = value.docs.map((e) => e.data()).toList());
    } catch (e) {
      print('====================e====================');
    }
    return list;
  }

  getNotifier(String tripName) {
    tripListNotifier.value.clear();
    var map = tripslist.firstWhere((map) => map['name'] as String == tripName);
    for (var destination in allTripDestinations) {
      if (idConverter(map['places']).contains(destination.id)) {
        tripListNotifier.value.add(destination);
      }
    }
    tripListNotifier.notifyListeners();
  }

  Future<void> updateNote(TripModel tripModel) async {
    FirebaseFirestore fireStore = FirebaseFirestore.instance;
    final dest = fireStore
        .collection('users')
        .doc(currentUserDetail()!.uid)
        .collection('tripplanner')
        .doc(tripModel.id);
    try {
      await dest.update({'notes': tripModel.notes});
    } catch (e) {
      print('==================$e========================');
    }
    getNotifier(tripModel.name);
  }

  Future<void> delete(TripModel tripModel, bool all) async {
    FirebaseFirestore fireStore = FirebaseFirestore.instance;
    final dest = fireStore
        .collection('users')
        .doc(currentUserDetail()!.uid)
        .collection('tripplanner')
        .doc(tripModel.id);
    try {
      if (all || tripModel.places.isEmpty) {
        await dest.delete();
      } else {
        await dest.update({
          'notes': tripModel.notes,
          'places': tripModel.places,
          'startDate': tripModel.startDate,
          'endDate': tripModel.endDate,
        });
      }
    } catch (e) {
      print('==================$e========================');
    }
    await getTrips();
    getNotifier(tripModel.name);
  }

  List<String> idConverter(List<dynamic> array) {
    List<String> ids = [];
    for (var id in array) {
      ids.add(id as String);
    }
    return ids;
  }
}
