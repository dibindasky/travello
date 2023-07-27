import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travelapp/functions/user_detail/user_detail_taker.dart';
import 'package:travelapp/model/model_maker.dart';
import 'package:travelapp/screens/trip_planner/trip_functions/trip_list_maker.dart';

class TripPlannerFirebase {
  TripListMaker tripListMaker = TripListMaker();

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

}
