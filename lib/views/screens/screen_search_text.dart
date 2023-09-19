import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travelapp/constants/sized_boxes.dart';
import 'package:travelapp/models/destination_model.dart';
import 'package:travelapp/views/screens/bottombar_items/search_place.dart';
import 'package:travelapp/views/screens/screen_details.dart';

import '../../services/firebase/fetch_firebase_data.dart';

class SearchTextScreen extends StatefulWidget {
  const SearchTextScreen({super.key});

  @override
  State<SearchTextScreen> createState() => _SearchTextScreenState();
}

class _SearchTextScreenState extends State<SearchTextScreen> {
  final DataManager dataManager = DataManager();
  String searchValue = '';
  final TextEditingController search=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            addVerticalSpace(20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: const Color.fromARGB(255, 255, 250, 250),
                    boxShadow: const [BoxShadow(spreadRadius: 1,blurRadius: 1,color: Colors.black26)]),
                child: TextField(
                  controller: search,
                  onChanged: (value) => setState(() {
                    searchValue = value;
                  }),
                  decoration:  InputDecoration(
                      label: const Text('search'),
                      suffixIcon: IconButton(onPressed: (){
                        setState(() {
                          search.text='';
                          searchValue='';
                        });
                      }, icon: const Icon(Icons.highlight_remove_sharp,color: Colors.black38)),
                      prefixIcon: const Icon(Icons.search,),
                      prefixIconColor: Colors.black,
                      border: InputBorder.none),
                ),
              ),
            ),
            Expanded(
              child: Obx(() {
                  List<DestinationModel> list = controllers.searchList
                      .where((element) => element.name
                          .toLowerCase()
                          .contains(searchValue.toLowerCase()))
                      .toList();

                  return ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      DestinationModel data = list[index];

                      return ListTile(
                        leading: CircleAvatar(
                            backgroundImage:
                                NetworkImage(data.images[0])),
                        title: Text(data.name),
                        subtitle: Text(data.catogory),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ScreenDetails(destination: data),
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
