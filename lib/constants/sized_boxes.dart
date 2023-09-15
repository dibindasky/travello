// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

late var SCREEN_HEIGHT;
late var SCREEN_WIDTH;


Widget addVerticalSpace(double size){
  return SizedBox(height: size,);
}

Widget addHorizontalSpace(double size){
  return SizedBox(width: size,);
}
void addSize(BuildContext context){
  screenHeight(context);
  screenWidth(context);
}
void screenHeight(BuildContext context){
  SCREEN_HEIGHT= MediaQuery.of(context).size.height;
}
void screenWidth(BuildContext context){
  SCREEN_WIDTH= MediaQuery.of(context).size.width;
}