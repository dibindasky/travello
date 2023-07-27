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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            addVerticalSpace(10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  SizedBox(
                    width: SCREEN_WIDTH * 0.75,
                    child: TextField(
                      onChanged: (value) => setState(() {
                        searchValue = value;
                      }),
                      enabled: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50)),
                      ),
                    ),
                  ),
                  IconButton(onPressed: () {}, icon: const Icon(Icons.search))
                ],
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
