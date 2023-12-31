import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_temples/main.dart';
import 'package:url_launcher/url_launcher.dart';

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
    Uri googleUri = Uri.parse("https://www.google.com/search?q=$title");
    Uri mapsUri = Uri.parse(
        "https://www.google.com/maps/place/Shreemant+Dagdusheth+Halwai+Ganpati+Mandir/@18.5164297,73.853558,17z/data=!3m1!4b1!4m6!3m5!1s0x3bc2c06fa5b442ff:0x9df365f5b648bce1!8m2!3d18.5164297!4d73.8561329!16s%2Fm%2F04zxxlg?entry=ttu");

    return Scaffold(
      backgroundColor: bgGreen,
      body: SingleChildScrollView(
        child: Column(
          children: [
            //cover photo
            Container(
              width: w,
              height: w,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
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
                  Center(
                    child: Text(
                      title.toUpperCase(),
                      textAlign: TextAlign.center,
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
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            //info
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                children: [
                  //links
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          launchUrl(googleUri);
                        },
                        child: CircleAvatar(
                          backgroundColor: const Color(0xff303030),
                          radius: 30,
                          child: SvgPicture.asset('assets/google.svg'),
                        ),
                      ),
                      CircleAvatar(
                        backgroundColor: const Color(0xff303030),
                        radius: 30,
                        child: Icon(
                          Icons.add,
                          color: lightGreen,
                          size: 30,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          launchUrl(mapsUri);
                        },
                        child: CircleAvatar(
                          backgroundColor: const Color(0xff303030),
                          radius: 30,
                          child: SvgPicture.asset('assets/google-maps.svg'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  //Content
                  const SizedBox(height: 20),
                  Text(
                    desc + desc,
                    style: GoogleFonts.leagueSpartan(
                      color: Colors.black,
                      height: 1.1,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
