import 'package:flutter/material.dart';
import 'package:travelapp/constants/sized_boxes.dart';
import 'package:travelapp/data_manageer/fetch_firebase_data.dart';
import 'package:travelapp/functions/login_functions.dart';

class ScreenSplash extends StatefulWidget {
  ScreenSplash({super.key,required this.logOrNot});

  final bool logOrNot;
  final DataManager dataManager = DataManager();

  @override
  State<ScreenSplash> createState() => _ScreenSplashState();
}

class _ScreenSplashState extends State<ScreenSplash> {
  takeDatas()async{
    await widget.dataManager.getData();
    widget.dataManager.getPopularListsToDisplay();
  }

  @override
  Widget build(BuildContext context) {
    takeDatas();
    LogAuth.loginOrHome(context, widget.logOrNot);
    addSize(context);
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/background/trlwlp3.jpg'),
              fit: BoxFit.cover),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            addVerticalSpace(50),
            const Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                'Explore Kerala \nWith Us . .',
                style: TextStyle(fontSize: 50, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
