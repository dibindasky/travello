import 'package:flutter/material.dart';
import 'package:travelapp/constants/colors.dart';

class Switchs extends StatefulWidget {
  const Switchs({super.key});

  @override
  State<Switchs> createState() => _SwitchsState();
}

class _SwitchsState extends State<Switchs> {
  bool darkState = false;
  @override
  Widget build(BuildContext context) {
    return Switch(
      activeColor: bluePrimary,
      value: darkState,
      onChanged: (value) {
        setState(() {
          darkState = darkState ? false : true;
        });
      },
    );
  }
}
