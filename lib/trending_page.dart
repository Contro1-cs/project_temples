import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_temples/main.dart';
import 'package:project_temples/travel_list.dart';
import 'package:project_temples/widgets/trending_trips.dart';

class TrendingPage extends StatefulWidget {
  const TrendingPage({super.key});

  @override
  State<TrendingPage> createState() => _TrendingPageState();
}

bool animationComplete = false;
String city = 'Pune';
String count = '6';
String content =
    'Lorem ipsum dolor sit amet consectetur. Felis facilisi tristique scelerisque quam curabitur eget tortor nibh facilisi. Urna quis accumsan scelerisque non. Ut sed et nulla ultrices. Sit bibendum ultrices morbi pellentesque dolor velit. Ligula ullamcorper semper consequat quis duis. Molestie mattis urna a fusce quis tincidunt. Mauris justo nec auctor vitae scelerisque adipiscing aliquet amet. Pretium donec sed pharetra id quis etiam faucibus. Nulla posuere nibh consectetur habitant nisi dolor odio egestas. Nulla diam urna sed lobortis facilisis est. Tristique feugiat aliquet nunc tristique urna ultrices. Fermentum erat et orci magnis praesent. Semper neque diam vestibulum accumsan sed eu';

class _TrendingPageState extends State<TrendingPage> {
  @override
  void initState() {
    super.initState();

    animationComplete = false;
  }

  @override
  void dispose() {
    animationComplete = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double coverW = w - 50;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            //Cover photo
            Hero(
              transitionOnUserGestures: true,
              tag: 'trending',
              child: Column(
                children: [
                  SizedBox(
                    width: w,
                    child: Stack(
                      children: [
                        Image.asset(
                          'assets/monsoon-expanded.png',
                          fit: BoxFit.cover,
                          height: coverW,
                          width: w,
                        ),
                        Container(
                          height: coverW,
                          width: w,
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.black,
                                Colors.transparent,
                              ],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                            ),
                          ),
                        ),
                        Container(
                          height: coverW,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            'Monsoon travel list'.toUpperCase(),
                            textAlign: TextAlign.center,
                            style: GoogleFonts.leagueSpartan(
                              shadows: [
                                const BoxShadow(
                                    color: Colors.black,
                                    blurRadius: 25,
                                    offset: Offset(0, 4))
                              ],
                              fontSize: 36,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 10),
            //Content
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    '$city | $count places'.toUpperCase(),
                    style: GoogleFonts.leagueSpartan(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    content,
                    style: GoogleFonts.leagueSpartan(
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                      fontSize: 16,
                      textStyle: const TextStyle(height: 1.1),
                    ),
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    height: 100,
                    width: w,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff303030),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const TrendingTrips(),
                          ),
                        );
                      },
                      child: Text(
                        'Explore now'.toUpperCase(),
                        style: GoogleFonts.leagueSpartan(
                          fontWeight: FontWeight.bold,
                          color: lightGreen,
                          fontSize: 32,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
