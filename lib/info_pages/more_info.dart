import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MoreInfoPage extends StatelessWidget {
  const MoreInfoPage({
    super.key,
    required this.title,
    required this.desc,
  });
  final String title;
  final String desc;

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Column(
        children: [
          Container(
            width: w,
            height: w,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    'assets/default.png',
                    fit: BoxFit.cover,
                    height: w,
                    width: w,
                  ),
                ),
                Container(
                  height: w,
                  width: w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xff303030),
                        Colors.transparent,
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                ),
                Container(
                  height: w,
                  alignment: Alignment.bottomLeft,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        title.toUpperCase(),
                        textAlign: TextAlign.start,
                        style: GoogleFonts.leagueSpartan(
                          shadows: [
                            const BoxShadow(
                                color: Colors.black,
                                blurRadius: 25,
                                offset: Offset(0, 4))
                          ],
                          height: 1.1,
                          fontSize: 36,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
