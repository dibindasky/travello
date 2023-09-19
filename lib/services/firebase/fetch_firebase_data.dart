import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:travelapp/models/destination_model.dart';

import '../../views/wigets/lists/lists_catogery.dart';

class DataManager with ChangeNotifier {
  // Private constructor
  DataManager._();
  // Singleton instance variable
  static final DataManager _instance = DataManager._();
  // Factory constructor to return the singleton instance
  factory DataManager() => _instance;

  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  CatogoryClass catogoryObject = CatogoryClass();

  List<DestinationModel> documentsFromFirebase = [];
  //popular
  ValueNotifier<List<DestinationModel>> popularDestination = ValueNotifier([]);
  //search notifier


  String shareLink = '';
  String profilepic = '';

  Future<List<Map<String, dynamic>>> getAllCollectionDocs() async {
    List<Map<String, dynamic>> list = [];
    try {
      await fireStore.collection('destinations').get().then((value) {
        list = value.docs.map((e) => e.data()).toList();
      });
    } on FirebaseException catch (e) {e;}
    return list;
  }

 

  Future<void> getprofile(String id) async {
    List<Map<String, dynamic>> list = [];
    FirebaseFirestore fireStore = FirebaseFirestore.instance;
    try {
      await fireStore.collection('users').get().then((value) {
        list = value.docs.map((e) => e.data()).toList();
      });
    } catch (e) {e;}
    profilepic = list[0]['profileimg'] ?? '';
  }

  Future<void> updatePopularity(
      {required String id, required int popularity}) async {
    final dest = fireStore.collection('destinations').doc(id);
    try {
      await dest.update({
        'popularity': ++popularity,
      });
    } catch (e) {e;}
  }
}
