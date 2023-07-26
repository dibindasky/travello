import 'package:flutter/material.dart';

class CalenderPicker{
  CalenderPicker._();
  static final _instance=CalenderPicker._();
  factory CalenderPicker()=>_instance;
 Future showCalender(BuildContext context,DateTimeRange dateObj) async {
    DateTimeRange? dateTimeRange = await showDateRangePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2150),
      initialDateRange: dateObj,
    );
    if (dateTimeRange == null) return;
      dateObj = dateTimeRange;
      startDate =
          '${dateObj.start.day}/${dateObj.start.month}/${dateObj.start.year}';
      endDate =
          '${dateObj.end.day}/${dateObj.end.month}/${dateObj.end.year}';
  }

String startDate='';
String endDate='';
}