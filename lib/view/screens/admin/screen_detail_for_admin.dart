// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travelapp/constants/colors.dart';
import 'package:travelapp/constants/sized_boxes.dart';
import 'package:travelapp/model/destination_model.dart';
import 'package:travelapp/controller/firebase/cred_firebase_admin_operations.dart';
import 'package:travelapp/provider/wigets/text_fields/text_form_field.dart';

import '../../wigets/lists/catogary_list_maker.dart';
import '../../wigets/lists/lists_catogery.dart';

// ignore: must_be_immutable
class ScreenDetailsAdmin extends StatefulWidget {
  ScreenDetailsAdmin({super.key, this.index, this.destination});

  DestinationModel? destination;
  int? index;

  @override
  State<ScreenDetailsAdmin> createState() => _ScreenDetailsAdminState();
}

class _ScreenDetailsAdminState extends State<ScreenDetailsAdmin> {
  ReposatoryDestination repo = ReposatoryDestination();

  final CatogoryClass catogoryObject = CatogoryClass();

  List<bool> catogeryController = List.generate(8, (index) => false);
  List<bool> discrictController = List.generate(14, (index) => false);

  final placeNameController = TextEditingController();
  final locationController = TextEditingController();
  final descriptionController = TextEditingController();
  final popularutyNameController = TextEditingController();

  List<XFile> images = [];

  final ImagePicker imagepicker = ImagePicker();

  bool isWaiting = false;
  bool isDeleting = false;
  bool isRefresh = false;

  @override
  Widget build(BuildContext context) {
    if (widget.index != null) {
      placeNameController.text = widget.destination!.name;
      locationController.text = widget.destination!.location;
      descriptionController.text = widget.destination!.description;
      popularutyNameController.text = widget.destination!.popularity.toString();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('CRED  ${widget.index}'),
        backgroundColor: blueSecondary,
        actions: [
          widget.index != null
              ? isDeleting
                  ? const Center(
                      child: CircularProgressIndicator(
                      color: whitePrimary,
                    ))
                  : IconButton(
                      onPressed: () async {
                        setState(() {
                          isDeleting = true;
                        });
                        bool del = await repo.deleteDoc(widget.destination!);
                        setState(() {
                          isDeleting = false;
                        });
                        if (del) {
                          snackShow(context, 'deleted');
                          Navigator.pop(context);
                        } else {
                          snackShow(context, 'something went wrong');
                        }
                      },
                      icon: const Icon(Icons.delete_forever_sharp))
              :  TextButton.icon(
                      onPressed: () async {
                        setState(() {
                          isRefresh=true;
                        });
                        bool done=await repo.resetpopularity();
                        setState(() {
                          isRefresh=false;
                        });
                        if(done){
                          snackShow(context, 'updated');
                        }else{
                          snackShow(context, 'something went wrong');
                        }
                      },
                      icon:isRefresh
                  ? const Center(
                      child: CircularProgressIndicator(
                      color: whitePrimary,
                    ))
                  : const Icon(Icons.refresh,color: whitePrimary,),
                      label: const Text('reset popularity',style: TextStyle(color: whitePrimary),)),
          addHorizontalSpace(20),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(SCREEN_WIDTH * 0.06),
          child: Column(
            children: [
              widget.index == null
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
                          child: Text(
                              'district :  ${widget.destination!.district}'),
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
                          child: Text(
                              'catogory :  ${widget.destination!.catogory}'),
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
                    child: isWaiting
                        ? const CircularProgressIndicator()
                        : ElevatedButton.icon(
                            onPressed: () async {
                              if (widget.index == null && images.isEmpty) {
                                snackShow(context, 'upload image');
                                return;
                              }
                              setState(() {
                                isWaiting = true;
                              });
                              bool wit = await addData();
                              if (wit) {
                                snackShow(context, 'updated');
                              } else {
                                snackShow(context, 'something went wrong');
                              }
                            },
                            label: const Text('save Changes'),
                            icon: const Icon(Icons.save_as_outlined),
                          ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void snackShow(BuildContext context, String data) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Center(child: Text(data)),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.only(left: 80, right: 80),
        duration: const Duration(seconds: 1),
        backgroundColor: blueSecondary,
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

    if (widget.index == null) {
      ret = await repo.addNewDestinastion(
          name: placeNameController.text,
          location: locationController.text,
          description: descriptionController.text,
          image: images,
          districtIndex: districtIndex,
          catogeryIndex: catogeryIndex);
    } else {
      List<String> imag;
      imag = await repo.imageConverter(images, widget.destination!.name);
      widget.destination!.name = placeNameController.text;
      widget.destination!.location = locationController.text;
      widget.destination!.description = descriptionController.text;
      widget.destination!.images.addAll(imag);
      ret = await repo.editData(widget.destination!);
    }

    placeNameController.text = '';
    locationController.text = '';
    descriptionController.text = '';
    images = [];
    catogeryController.fillRange(0, 8, false);
    discrictController.fillRange(0, 14, false);
    setState(() {
      isWaiting = false;
    });
    return ret;
  }
}
