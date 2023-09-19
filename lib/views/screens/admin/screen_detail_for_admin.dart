// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travelapp/constants/colors.dart';
import 'package:travelapp/constants/sized_boxes.dart';
import 'package:travelapp/models/destination_model.dart';
import 'package:travelapp/services/firebase/cred_firebase_admin_operations.dart';

import '../../wigets/lists/catogary_list_maker.dart';
import '../../wigets/lists/lists_catogery.dart';
import '../../wigets/text_fields/text_form_field.dart';

// ignore: must_be_immutable
class ScreenDetailsAdmin extends StatelessWidget {
  ScreenDetailsAdmin({super.key, this.index, this.destination});

  DestinationModel? destination;
  int? index;

  ReposatoryDestination repo = ReposatoryDestination();
  final CatogoryClass catogoryObject = CatogoryClass();

  RxList<bool> catogeryController = RxList.generate(8, (index) => false);
  RxList<bool> discrictController = RxList.generate(14, (index) => false);

  final placeNameController = TextEditingController();
  final locationController = TextEditingController();
  final descriptionController = TextEditingController();
  final popularutyNameController = TextEditingController();

  List<XFile> images = [];
  final ImagePicker imagepicker = ImagePicker();

  RxBool isWaiting = false.obs;
  RxBool isDeleting = false.obs;
  RxBool isRefresh = false.obs;

  @override
  Widget build(BuildContext context) {
    if (index != null) {
      placeNameController.text = destination!.name;
      locationController.text = destination!.location;
      descriptionController.text = destination!.description;
      popularutyNameController.text = destination!.popularity.toString();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('CRED  $index'),
        backgroundColor: blueSecondary,
        actions: [
          Obx(() {
            return index != null
                ? isDeleting.isTrue
                    ? const Center(
                        child: CircularProgressIndicator(
                        color: whitePrimary,
                      ))
                    : IconButton(
                        onPressed: () async {
                          isDeleting.value = true;
                          bool del = await repo.deleteDoc(destination!);
                          isDeleting.value = false;
                          if (del) {
                             Get.snackbar('Deleted', 'Destination deleted sucessfully',
                                      snackPosition: SnackPosition.BOTTOM,
                                      duration: const Duration(seconds: 2),
                                      backgroundColor: Colors.redAccent);
                            Navigator.pop(context);
                          } else {
                             Get.snackbar('Error', 'something went wrong',
                                      snackPosition: SnackPosition.BOTTOM,
                                      duration: const Duration(seconds: 2),
                                      backgroundColor: Colors.redAccent);
                          }
                        },
                        icon: const Icon(Icons.delete_forever_sharp))
                : TextButton.icon(
                    onPressed: () async {
                      isRefresh.value = true;
                      bool done = await repo.resetpopularity();
                      isRefresh.value = false;
                      if (done) {
                         Get.snackbar('Updated', 'Updated sucessfully',
                                      snackPosition: SnackPosition.BOTTOM,
                                      duration: const Duration(seconds: 2),
                                      backgroundColor: Colors.greenAccent);
                      } else {
                         Get.snackbar('Error', 'something went wrong',
                                      snackPosition: SnackPosition.BOTTOM,
                                      duration: const Duration(seconds: 2),
                                      backgroundColor: Colors.redAccent);
                      }
                    },
                    icon: isRefresh.isTrue
                        ? const Center(
                            child: CircularProgressIndicator(
                            color: whitePrimary,
                          ))
                        : const Icon(
                            Icons.refresh,
                            color: whitePrimary,
                          ),
                    label: const Text(
                      'reset popularity',
                      style: TextStyle(color: whitePrimary),
                    ));
          }),
          addHorizontalSpace(20),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(SCREEN_WIDTH * 0.06),
          child: Column(
            children: [
              index == null
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Select Catagory',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        CatogaryListMaker(
                            count: catogoryObject.catagoryListForSearch.length,
                            list: catogoryObject.catagoryListForSearch,
                            marker: catogeryController),
                        const Divider(
                          thickness: 2,
                        ),
                        const Text(
                          'Select District',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        CatogaryListMaker(
                            count: catogoryObject.districtsListForSearch.length,
                            list: catogoryObject.districtsListForSearch,
                            marker: discrictController),
                        const Divider(
                          thickness: 2,
                        ),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(4),
                            ),
                            color: whiteSecondary,
                          ),
                          margin: const EdgeInsets.all(10),
                          padding: const EdgeInsets.all(6),
                          child: Text('district :  ${destination!.district}'),
                        ),
                        Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(4),
                            ),
                            color: whiteSecondary,
                          ),
                          margin: const EdgeInsets.all(10),
                          padding: const EdgeInsets.all(6),
                          child: Text('catogory :  ${destination!.catogory}'),
                        ),
                      ],
                    ),
              addVerticalSpace(10),
              FormFields(
                  textContol: placeNameController, textLabel: 'place name'),
              addVerticalSpace(10),
              FormFields(
                  textContol: locationController,
                  function: null,
                  textLabel: 'location'),
              addVerticalSpace(10),
              FormFields(
                  textContol: descriptionController, textLabel: 'description'),
              addVerticalSpace(10),
              FormFields(
                  textContol: popularutyNameController,
                  textLabel: 'popularity'),
              addVerticalSpace(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                      onPressed: () async {
                        images = await ImagePicker().pickMultiImage();
                      },
                      icon: const Icon(Icons.cloud_upload),
                      label: const Text('Images')),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Obx(() {
                      return isWaiting.isTrue
                          ? const CircularProgressIndicator()
                          : ElevatedButton.icon(
                              onPressed: () async {
                                if (index == null && images.isEmpty) {
                                  Get.snackbar('Image missing', 'upload image before adding a destination to database',
                                      snackPosition: SnackPosition.BOTTOM,
                                      duration: const Duration(seconds: 2),
                                      backgroundColor: Colors.redAccent);
                                  return;
                                }
                                isWaiting.value = true;
                                bool wit = await addData();
                                if (wit) {
                                  Get.snackbar(
                                      'Updated', 'data updated sussfully',
                                      snackPosition: SnackPosition.BOTTOM,
                                      duration: const Duration(seconds: 2),
                                      backgroundColor: Colors.greenAccent);
                                } else {
                                  Get.snackbar('Error', 'something went wrong',
                                      snackPosition: SnackPosition.BOTTOM,
                                      duration: const Duration(seconds: 2),
                                      backgroundColor: Colors.redAccent);
                                }
                                isWaiting.value = false;
                              },
                              label: const Text('save Changes'),
                              icon: const Icon(Icons.save_as_outlined),
                            );
                    }),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

// to add or edit data send data to the reposetory
  Future<bool> addData() async {
    int catogeryIndex =
        catogeryController.indexWhere((element) => element == true);
    int districtIndex =
        catogeryController.indexWhere((element) => element == true);
    bool ret = false;

    if (index == null) {
      ret = await repo.addNewDestinastion(
          name: placeNameController.text,
          location: locationController.text,
          description: descriptionController.text,
          image: images,
          districtIndex: districtIndex,
          catogeryIndex: catogeryIndex);
    } else {
      List<String> imag;
      imag = await repo.imageConverter(images, destination!.name);
      destination!.name = placeNameController.text;
      destination!.location = locationController.text;
      destination!.description = descriptionController.text;
      destination!.images.addAll(imag);
      ret = await repo.editData(destination!);
    }

    placeNameController.text = '';
    locationController.text = '';
    descriptionController.text = '';
    images = [];
    catogeryController.fillRange(0, 8, false);
    discrictController.fillRange(0, 14, false);
    return ret;
  }
}
