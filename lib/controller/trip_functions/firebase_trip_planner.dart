import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travelapp/model/destination_model.dart';
import 'package:travelapp/controller/trip_functions/fetch_trip.dart';
import 'package:travelapp/controller/trip_functions/trip_list_maker.dart';

import '../functions/user_detail/user_detail_taker.dart';

class TripPlannerFirebase {
  TripListMaker tripListMaker = TripListMaker();
  ReposatoryTrip reposatoryTrip = ReposatoryTrip();

  FirebaseFirestore firebase = FirebaseFirestore.instance;
  final userid = currentUserDetail()!.uid;

  Future<bool> addTrip(
      {required List<DestinationModel> models,
      required String name,
      String? startDate,
      String? endDate}) async {
    List<String> places = [];
    Map<String, String> notes = {};
    for (var element in models) {
      places.add(element.id);
      notes[element.id] = '';
    }
    CollectionReference reference = firebase.collection('users');
    DocumentReference docRef = reference.doc(userid);
    CollectionReference tripCollection = docRef.collection('tripplanner');
    DocumentReference docTrip = tripCollection.doc();
    Map<String, dynamic> trip = {
      'places': places,
      'name': name,
      'notes': notes,
      'id': docTrip.id,
      'startDate': startDate ?? '',
      'endDate': endDate ?? '',
    };
    try {
      await docTrip.set(trip);
    } catch (e) {
      return false;
    }
    return true;
  }

  Future addMoreToTrip(
      {required List<String> places,
      required String tripid,
      required String name,
      required Map<String, dynamic> notes,
      required DestinationModel destinationModel}) async {
    CollectionReference reference = firebase.collection('users');
    DocumentReference docRef = reference.doc(userid);
    CollectionReference tripCollection = docRef.collection('tripplanner');
    DocumentReference docTrip = tripCollection.doc(tripid);
    notes[destinationModel.id] = '';
    Map<String, dynamic> trip = {'places': places, 'notes': notes};
    try {
      await docTrip.update(trip);
    } catch (e) {
      e;
    }
  }
}
