import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_temples/main.dart';

class SeasonalCards extends StatelessWidget {
  const SeasonalCards({
    super.key,
    required this.title,
    required this.img,
    required this.ontap,
  });
  final String title;
  final String img;
  final Function()? ontap;

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: ontap,
      child: Container(
        height: 120,
        width: w,
        color: lightGreen,
        child: Stack(
          children: [
            Image.asset(
              img,
              height: 120,
              fit: BoxFit.cover,
            ),
            Container(
              width: w,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xff141414),
                    Colors.transparent,
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              alignment: Alignment.bottomLeft,
              child: Text(
                title.toUpperCase(),
                style: GoogleFonts.leagueSpartan(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
