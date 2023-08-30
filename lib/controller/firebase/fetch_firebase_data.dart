import 'dart:async';
import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:travelapp/model/destination_model.dart';

import '../../view/wigets/lists/lists_catogery.dart';
import '../sqflite/local_db.dart';

class DataManager with ChangeNotifier {
  // Private constructor
  DataManager._() {
    getData();
  }
  // Singleton instance variable
  static final DataManager _instance = DataManager._();
  // Factory constructor to return the singleton instance
  factory DataManager() => _instance;

  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  CatogoryClass catogoryObject = CatogoryClass();
  List<bool> catogerySelector = List.generate(8, (index) => false);
  List<bool> discrictSelector = List.generate(14, (index) => false);

  List<DestinationModel> documentsFromFirebase = [];
  //favourates
  ValueNotifier<List<DestinationModel>> favListFromFirebase = ValueNotifier([]);
  //popular
  ValueNotifier<List<DestinationModel>> popularDestination = ValueNotifier([]);
  //search notifier
  ValueNotifier<List<DestinationModel>> searchDestination = ValueNotifier([]);
  Set<String> searchID = {};

  Map<String, Set<String>> districtsMap = HashMap<String, Set<String>>();
  Map<String, Set<String>> catogoryMap = HashMap<String, Set<String>>();

  String shareLink = '';
  String profilepic = '';

  Future getData() async {
    List<Map<String, dynamic>> list = await getAllCollectionDocs();
    documentsFromFirebase.clear();
    searchDestination.value.clear();
    districtsMap.clear();
    catogoryMap.clear();
    for (var element in list) {
      final docs = modelMaker(element);
      documentsFromFirebase.add(docs);
      searchDestination.value.add(docs);
      searchID.add(docs.id);
      if (!districtsMap.containsKey(docs.district)) {
        districtsMap[docs.district] = {};
      }
      Set<String> set = districtsMap[docs.district]!;
      set.add(docs.id);
      districtsMap[docs.district] = set;
      if (!catogoryMap.containsKey(docs.catogory)) {
        catogoryMap[docs.catogory] = {};
      }
      Set<String> set1 = catogoryMap[docs.catogory]!;
      set1.add(docs.id);
      catogoryMap[docs.catogory] = set1;
    }
  }

  Future<List<Map<String, dynamic>>> getAllCollectionDocs() async {
    List<Map<String, dynamic>> list = [];
    try {
      await fireStore.collection('destinations').get().then((value) {
        list = value.docs.map((e) => e.data()).toList();
      });
    } on FirebaseException catch (e) {e;}
    return list;
  }

  getFavData() {
    SQLFlite sql = SQLFlite();
    favListFromFirebase.value.clear();
    for (var doc in documentsFromFirebase) {
      if (sql.favsNotifier.value.contains(doc.id)) {
        favListFromFirebase.value.add(doc);
      }
    }
    favListFromFirebase.notifyListeners();
  }

  getPopularListsToDisplay() {
    popularDestination.value.clear();
    for (int i = 0; i < documentsFromFirebase.length; i++) {
      popularDestination.value.add(documentsFromFirebase[i]);
    }
    quickSortHelper(
        popularDestination.value, 0, popularDestination.value.length - 1);
    popularDestination.value.removeRange(10, popularDestination.value.length);
    popularDestination.notifyListeners();
  }

  void quickSortHelper(List<DestinationModel> arr, int start, int end) {
    if (start >= end) return;
    int pivot = start;
    int left = start + 1;
    int right = end;
    while (left <= right) {
      if (arr[left].popularity < arr[pivot].popularity &&
          arr[right].popularity > arr[pivot].popularity) {
        swap(arr, left++, right--);
      }
      if (arr[left].popularity >= arr[pivot].popularity) left++;
      if (arr[right].popularity <= arr[pivot].popularity) right--;
    }
    swap(arr, right, pivot);
    quickSortHelper(arr, start, right - 1);
    quickSortHelper(arr, right + 1, end);
  }

  void swap(List<DestinationModel> arr, int i, int j) {
    DestinationModel temp = arr[i];
    arr[i] = arr[j];
    arr[j] = temp;
  }

  DestinationModel modelMaker(Map<String, dynamic> document) {
    return DestinationModel(
      popularity: document['popularity'],
      catogory: document['catogory'],
      name: document['name'],
      description: document['description'],
      location: document['location'],
      district: document['district'],
      images: document['images'],
      id: document['id'],
    );
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

  sortData() {
    searchDestination.value.clear();
    searchID.clear();
    Set<String> getSet = {};
    if (discrictSelector.contains(true)) {
      //if any district selected all destination in district added to getSet
      for (int i = 0; i < discrictSelector.length; i++) {
        Set<String> tempSet = {};
        if (discrictSelector[i]) {
          //check which districts are selected
          tempSet = districtsMap[catogoryObject.districtsListForSearch[i]]!;
          for (var id in tempSet) {
            getSet.add(id);
          }
        }
      }
    }
    if (getSet.isEmpty) {
      //if nothing is added then check for selected catogorys
      for (int i = 0; i < catogerySelector.length; i++) {
        Set<String> tempSet = {};
        if (catogerySelector[i]) {
          //add destinations in selected catogories
          tempSet = catogoryMap[catogoryObject.catagoryListForSearch[i]]!;
          for (var id in tempSet) {
            searchID.add(id);
          }
        }
      }
    } else if (catogerySelector.contains(true)) {
      // both catogory and district are selected enter here after district vise sorting
      for (int i = 0; i < catogerySelector.length; i++) {
        Set<String> tempSet = {};
        if (catogerySelector[i]) {
          //sort the set that sorted with district with selected catogory
          tempSet = catogoryMap[catogoryObject.catagoryListForSearch[i]]!;
          for (var id in tempSet) {
            if (getSet.contains(id)) {
              searchID.add(id);
            }
          }
        }
      }
    } else {
      searchID = getSet;
    }
    if (discrictSelector.contains(true) &&
        catogerySelector.contains(true) &&
        searchID.isEmpty) {
      searchDestination.notifyListeners();
      return;
    }
    if (searchID.isEmpty) {
      for (var model in documentsFromFirebase) {
        searchDestination.value.add(model);
      }
    } else {
      for (var model in documentsFromFirebase) {
        if (searchID.contains(model.id)) {
          searchDestination.value.add(model);
        }
      }
    }
    searchDestination.notifyListeners();
  }
}
