import 'dart:collection';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travelapp/views/screens/screen_splash.dart';

import '../../models/destination_model.dart';
import '../../views/wigets/lists/lists_catogery.dart';
import '../functions/user_detail/user_detail_taker.dart';
import 'fetch_firebase_data.dart';


// Repository for destinations
class ReposatoryDestination {
  final CatogoryClass catogoryObject = CatogoryClass();
  DataManager dataManager = DataManager();

  // add new destination to firebase

  Future<bool> addNewDestinastion(
      {required String name,
      required String location,
      required String description,
      required List<XFile> image,
      required int districtIndex,
      required int catogeryIndex}) async {
    FirebaseFirestore fireStore = FirebaseFirestore.instance;
    CollectionReference destinations = fireStore.collection('destinations');

    List<String> images;

    try {
      images = await imageConverter(image,
          name); //upload image to firebase and store the link to the image file
      DocumentReference newPlace = destinations.doc();
      Map<String, dynamic> newPlaceDetails = {
        'name': name,
        'catogory': catogoryObject.catagoryListForSearch[catogeryIndex],
        'description': description,
        'location': location,
        'images': images,
        'district': catogoryObject.districtsListForSearch[districtIndex],
        'popularity': 1,
        'id': newPlace.id
      };
      await newPlace.set(newPlaceDetails);
      controllerInitial.getData();
    } catch (e) {
      return false;
    }
    return true;
  }

//edit document in firebase

  Future<bool> editData(DestinationModel destination) async {
    try {
      FirebaseFirestore fireStore = FirebaseFirestore.instance;
      final dest = fireStore.collection('destinations').doc(destination.id);
      await dest.update({
        'description': destination.description,
        'location': destination.location,
        'images': destination.images,
        'district': destination.district,
      });
    } catch (e) {
      return false;
    }
    return true;
  }

//delete documnet form firebase

  Future<bool> deleteDoc(DestinationModel destination) async {
    FirebaseFirestore fireStore = FirebaseFirestore.instance;
    CollectionReference destinations = fireStore.collection('destinations');
    try {
      deletePic(destination.name);
      await destinations.doc(destination.id).delete();
      controllerInitial.getData();
    } catch (e) {
      return false;
    }
    return true;
  }

  Future<void> deletePic(String name) async {
    try {
      await FirebaseStorage.instance
          .ref()
          .child('DestinationImages')
          .child(name)
          .delete();
    } catch (e) {e;}
  }

// upload the image and return the url as string

  Future<List<String>> imageConverter(
      List<XFile> imageList, String placeName) async {
    List<String> imageString = [];
    for (var img in imageList) {
      File imgFile = File(img.path);
      //  filter the name from unwanded file names
      String imageName = imgFile.path.split('/').last.toString();
      Reference toRoot = FirebaseStorage.instance.ref();
      Reference toDirectory = toRoot.child('DestinationImages');
      Reference toImage = toDirectory.child('$placeName/$imageName');
      try {
        await toImage.putFile(imgFile);
        final url = await toImage.getDownloadURL();
        imageString.add(url);
      } catch (e) {e;}
    }
    return imageString;
  }

  Future<String> uploadProfile(XFile img,String id) async {
    String url = await uploadImage(img);
    FirebaseFirestore fireStore = FirebaseFirestore.instance;
    CollectionReference destinations = fireStore.collection('users');
    final userRef = destinations.doc(id);
    try {
      await userRef.update({
        'profileimg': url,
      });
    } catch (e) {e;}
    return url;
  }

  Future<String> uploadImage(XFile img) async {
    String url = '';
    File imgFile = File(img.path);
    String imageName = imgFile.path.split('/').last.toString();
    Reference toRoot = FirebaseStorage.instance.ref();
    Reference toDirectory = toRoot.child('userprofile');
    Reference toImage = toDirectory.child('${currentUserDetail()!.uid}/$imageName');
    try {
      await toImage.putFile(imgFile);
      url = await toImage.getDownloadURL();
    } catch (e) {e;}
    return url;
  }

// convert firebase documents in to models and return as map of id and model

  Map<String, DestinationModel> convertInToModels(
      List<QueryDocumentSnapshot<Map<String, dynamic>>> document) {
    Map<String, DestinationModel> destinations =
        HashMap<String, DestinationModel>();
    for (var destination in document) {
      destinations[destination['name']] = modelMaker(destination);
    }
    return destinations;
  }

// model maker from doc to model

  DestinationModel modelMaker(
      QueryDocumentSnapshot<Map<String, dynamic>> document) {
    return DestinationModel(
      popularity: document['popularity'],
      catogory: document['catogory'],
      name: document['name'],
      description: document['description'],
      location: document['location'],
      district: document['district'],
      images: document['images'],
      id: document['id'] ?? '1212',
    );
  }

  Future<bool> resetpopularity() async {
    FirebaseFirestore fireStore = FirebaseFirestore.instance;
    CollectionReference destinations = fireStore.collection('destinations');
    try {
      var snap = await destinations.get();
      for (var doc in snap.docs) {
        await doc.reference.update({'popularity': 1});
      }
    } catch (e) {
      return false;
    }
    return true;
  }
  
}
