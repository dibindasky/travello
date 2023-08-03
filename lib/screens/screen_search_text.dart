import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:travelapp/constants/sized_boxes.dart';
import 'package:travelapp/data_manageer/fetch_firebase_data.dart';
import 'package:travelapp/model/model_maker.dart';
import 'package:travelapp/screens/screen_details.dart';

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
              child: ValueListenableBuilder(
                valueListenable: dataManager.searchDestination,
                builder: (context, value, child) {
                  List<DestinationModel> list = value
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
                                CachedNetworkImageProvider(data.images[0])),
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
