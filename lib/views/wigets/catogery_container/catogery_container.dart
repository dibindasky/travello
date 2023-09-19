import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travelapp/constants/colors.dart';
import 'package:travelapp/constants/sized_boxes.dart';
import 'package:travelapp/views/screens/screen_category.dart';

class CatogeryContainer extends StatelessWidget {
  const CatogeryContainer(
      {super.key,
      required this.headLine,
      required this.index,
      this.height = 0.10,
      required this.img,
      this.width = 0.10});

  final String headLine;
  final double width;
  final double height;
  final int index;
  final String img;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: InkWell(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ScreenCategory(
                    catogeryIndex: index,
                  )),
        ),
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage(img), fit: BoxFit.cover),
            boxShadow: [
              BoxShadow(
                color: blueSecondary.withOpacity(0.5),
                blurRadius: 7,
                offset: const Offset(0, 1),
              ),
            ],
            color: const Color.fromARGB(197, 44, 122, 238),
            borderRadius: BorderRadius.circular(SCREEN_WIDTH * 0.04),
          ),
          child: Center(
            child: SizedBox(
              height: SCREEN_HEIGHT * 0.020,
              child: FittedBox(
                child: Text(
                  headLine,
                  style: GoogleFonts.ubuntu(
                      fontWeight: FontWeight.w500,
                      color: whitePrimary,
                      shadows: [
                        const Shadow(
                            color: Colors.black,
                            blurRadius: 10,
                            offset: Offset(0, 1))
                      ]),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
            