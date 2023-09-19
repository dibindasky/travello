import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:travelapp/constants/colors.dart';
import 'package:travelapp/constants/sized_boxes.dart';
import 'package:travelapp/models/destination_model.dart';

import '../../services/functions/map_function/map_lounch.dart';
import '../wigets/favorite Icon/favourite.dart';
import '../wigets/text_fields/buttons/button_login.dart';

class ScreenDetails extends StatelessWidget {
  ScreenDetails({super.key,this.index=0, required this.destination});

  final int index;
  final MapLaunch mapLaunch = MapLaunch();
  final DestinationModel destination;

  @override
  Widget build(BuildContext context) {
    final List img = destination.images;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: SCREEN_HEIGHT * 0.08,
        iconTheme: const IconThemeData(color: blueSecondary),
        title: Text(
          destination.catogory,
          style: const TextStyle(color: Colors.black),
        ),
        backgroundColor: whitePrimary,
        elevation: 0,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 35),
            child: FavButton(
              destination: destination,
              color: bluePrimary,
              size: 30,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // addVerticalSpace(20),   
              SizedBox(
                height: SCREEN_HEIGHT * 0.50,
                width: SCREEN_WIDTH,
                child: CarouselSlider.builder(
                  itemCount: img.length,
                  itemBuilder: (context, index, realIndex) {
                    return Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
                      height: double.infinity,
                      width: double.infinity,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          img[index],
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                  options: CarouselOptions(
                    aspectRatio: 1,
                    viewportFraction: 1,
                    enlargeCenterPage: true,
                    height: double.infinity,
                    autoPlay: true,
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 800),
                  ),
                ),
              ),
              addVerticalSpace(30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ButtonContainer(
                    textIn: destination.name,
                    radius: 15,
                    color: blueSecondary,
                    fontColor: whitePrimary,
                    height: 40,
                  ),
                  InkWell(
                    onTap: () {
                      mapLaunch.launchInApp(destination.location);
                    },
                    child: ButtonContainer(
                      textIn: 'map',
                      color: Colors.green,
                      radius: 50,
                      fontColor: whitePrimary,
                      height: 50,
                      // width: 100,
                      visibleIcon: true,
                      icon: const Icon(
                        Icons.location_on_outlined,
                        color: whiteSecondary,
                      ),
                    ),
                  ),
                ],
              ),
              addVerticalSpace(20),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: whiteSecondary),
                child: Text(
                  destination.description,
                  style: const TextStyle(fontSize: 15),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
