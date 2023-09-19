import 'dart:collection';

import 'package:get/get.dart';
import 'package:travelapp/models/destination_model.dart';
import 'package:travelapp/services/firebase/fetch_firebase_data.dart';

import '../services/sqflite/local_db.dart';
import '../views/wigets/lists/lists_catogery.dart';

class ListController extends GetxController {
  DataManager dataManager = DataManager();
  CatogoryClass catogoryObject = CatogoryClass();

  RxList<DestinationModel> searchList = <DestinationModel>[].obs;
  RxList<DestinationModel> favListFromFirebase = <DestinationModel>[].obs;
  RxList<DestinationModel> popularDestination = <DestinationModel>[].obs;
  
  RxList<bool> catogerySelector = RxList.generate(8, (index) => false);
  RxList<bool> discrictSelector = RxList.generate(14, (index) => false);
  Set<String> searchID = {};
  Map<String, Set<String>> districtsMap = HashMap<String, Set<String>>();
  Map<String, Set<String>> catogoryMap = HashMap<String, Set<String>>();
  List<DestinationModel> documentsFromFirebase = [];

  @override
  void onInit() async {
    await getData();
    getPopularListsToDisplay();
    super.onInit();
  }

  Future getData() async {
    List<Map<String, dynamic>> list = await dataManager.getAllCollectionDocs();
    documentsFromFirebase.clear();
    searchList.clear();
    districtsMap.clear();
    catogoryMap.clear();
    for (var element in list) {
      final docs = DestinationModel.modelMaker(element);
      documentsFromFirebase.add(docs);
      searchList.add(docs);
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

  getFavData() {
    SQLFlite sql = SQLFlite();
    favListFromFirebase.clear();
    for (var doc in documentsFromFirebase) {
      if (sql.favsNotifier.value.contains(doc.id)) {
        favListFromFirebase.add(doc);
      }
    }
  }

  sortData() {
    searchList.clear();
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
      return;
    }
    if (searchID.isEmpty) {
      for (var model in documentsFromFirebase) {
        searchList.add(model);
      }
    } else {
      for (var model in documentsFromFirebase) {
        if (searchID.contains(model.id)) {
          searchList.add(model);
        }
      }
    }
  }

    getPopularListsToDisplay() {
    popularDestination.clear();
    for (int i = 0; i < documentsFromFirebase.length; i++) {
      popularDestination.add(documentsFromFirebase[i]);
    }
    quickSortHelper(
        popularDestination, 0, popularDestination.length - 1);
    popularDestination.removeRange(10, popularDestination.length);
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

}
