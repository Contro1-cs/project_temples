import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_temples/info_pages/more_info.dart';
import 'package:project_temples/main.dart';
import 'package:project_temples/model/temple.dart';
import 'package:project_temples/widgets/trips_info.dart';

class TrendingTrips extends StatefulWidget {
  const TrendingTrips({
    super.key,
  });

  @override
  State<TrendingTrips> createState() => _TrendingTripsState();
}

late DocumentSnapshot<Object?> templeDoc;

class _TrendingTripsState extends State<TrendingTrips>
    with SingleTickerProviderStateMixin {
  int count = 0;
  late AnimationController _animationController;
  late Animation<double> _progressAnimation;
  List<Temple> travelList = [];
  PageController pageController = PageController();

  animationInit() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );
    _progressAnimation =
        Tween<double>(begin: 0.0, end: 10.0).animate(_animationController);
    _animationController.repeat(reverse: false);
  }

  @override
  void initState() {
    super.initState();
    count = travelList.length;
    animationInit();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: bgGreen,
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List<Widget>.generate(travelList.length, (int index) {
              return Container(
                width: 8.0,
                height: 8.0,
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: currentPage == index ? Colors.blue : Colors.grey,
                ),
              );
            }),
          ),
          //Top Bar Photo
          Container(
            height: 150,
            width: double.infinity,
            color: lightGreen,
            child: Stack(
              children: [
                Image.asset(
                  'assets/hiking-trips.png',
                  height: 150,
                  fit: BoxFit.cover,
                ),
                Container(
                  width: double.infinity,
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
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 30,
                  ),
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        color: Colors.white,
                        icon: const Icon(Icons.arrow_back_ios_new),
                      ),
                      const SizedBox(width: 15),
                      Text(
                        'trending'.toUpperCase(),
                        style: GoogleFonts.leagueSpartan(
                          color: Colors.white,
                          fontSize: 35,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          //Animation Controller
          AnimatedBuilder(
            animation: _progressAnimation,
            builder: (context, child) {
              return LinearProgressIndicator(
                value: _progressAnimation.value / 10.0,
                backgroundColor: lightGreen,
                valueColor: AlwaysStoppedAnimation(darkGreen),
                borderRadius: BorderRadius.circular(1000),
                minHeight: 7,
              );
            },
          ),
          const SizedBox(height: 15),

          const Expanded(
            child: TripsList(
              trending: true,
            ),
          ),
          Container(
            width: w,
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(20),
                      backgroundColor: darkGreen,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MoreInfoPage(
                            title: templeDoc['title'],
                            description: templeDoc['description'],
                          ),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.info_outline,
                      color: Colors.white,
                      size: 20,
                    ),
                    label: Text(
                      'More info'.toUpperCase(),
                      style: GoogleFonts.leagueSpartan(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(20),
                      backgroundColor: const Color(0xff303030),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {},
                    icon: const Icon(
                      Icons.arrow_circle_right_outlined,
                      color: Colors.white,
                      size: 20,
                    ),
                    label: Text(
                      'Next'.toUpperCase(),
                      style: GoogleFonts.leagueSpartan(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
