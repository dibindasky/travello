import 'package:flutter/material.dart';
import 'package:travelapp/constants/colors.dart';
// import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;

class TermsDialog extends StatefulWidget {
  TermsDialog({super.key, required this.headline, required this.fileName,});
  final String headline;
  final String fileName;

  @override
  State<TermsDialog> createState() => _TermsDialogState();
}

class _TermsDialogState extends State<TermsDialog> {
  String data = '';

  @override
  Widget build(BuildContext context) {
    loadAsset();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: whiteSecondary,
        title: Text(
          widget.headline,
          style: TextStyle(color: Colors.black),
        ),
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.close,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(data)
          ),
      ),
    );
  }

    loadAsset() async {
      String fileText=await rootBundle.loadString('assets/images/policy/${widget.fileName}');
      setState(() {
        data=fileText;
      });
  }
}
