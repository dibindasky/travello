import 'package:flutter/material.dart';
import 'package:travelapp/constants/colors.dart';
import 'package:travelapp/constants/sized_boxes.dart';
import 'package:travelapp/screens/trip_planner/trip_functions/calender_pick.dart';

// ignore: must_be_immutable
class CalenderDatePicker extends StatefulWidget {
  CalenderDatePicker({
    super.key,
    required this.dateObj,
  });

  DateTimeRange dateObj;

  @override
  State<CalenderDatePicker> createState() => _CalenderDatePickerState();
}

class _CalenderDatePickerState extends State<CalenderDatePicker> {
  final CalenderPicker calenderPicker = CalenderPicker();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Text(
              'Pick Dates : ',
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
            ),
            ElevatedButton(
                onPressed: () async {
                  await calenderPicker.showCalender(context, widget.dateObj);
                  setState(() {
                    calenderPicker.endDate;
                    calenderPicker.startDate;
                  });
                },
                child: const Icon(Icons.calendar_month_outlined)),
          ],
        ),
        addVerticalSpace(15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              decoration: const BoxDecoration(
                  boxShadow: [BoxShadow(color: Colors.black)],
                  color: whiteSecondary,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  const Text(
                    'Start Date : ',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                  ),
                  Text(calenderPicker.startDate)
                ],
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                  boxShadow: [BoxShadow(color: Colors.black)],
                  color: whiteSecondary,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  const Text(
                    'End Date : ',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                  ),
                  Text(calenderPicker.endDate)
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
