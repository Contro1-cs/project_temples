import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_temples/main.dart';
import 'package:project_temples/travel_list.dart';
import 'package:project_temples/trending_page.dart';
import 'package:project_temples/widgets/seasonal_cards.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    searchController.text = '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;

    List travelList = [
      {
        'title': "Spring trips",
        'img': 'assets/spring-trips.png',
        'path': const TravelList(
          title: 'Spring Trips',
          img: 'assets/spring-trips.png',
        ),
      },
      {
        'title': "Fall trips",
        'img': 'assets/fall-trips.png',
        'path': const TravelList(
          title: 'Fall Trips',
          img: 'assets/fall-trips.png',
        ),
      },
      {
        'title': "winter trips",
        'img': 'assets/winter-trips.png',
        'path': const TravelList(
          title: 'winter Trips',
          img: 'assets/winter-trips.png',
        ),
      },
      {
        'title': "hiking trips",
        'img': 'assets/hiking-trips.png',
        'path': const TravelList(
          title: 'hiking Trips',
          img: 'assets/hiking-trips.png',
        ),
      },
      {
        'title': "family trips",
        'img': 'assets/family-trips.png',
        'path': const TravelList(
          title: 'family Trips',
          img: 'assets/family-trips.png',
        ),
      },
      {
        'title': "Veteran trips",
        'img': 'assets/veteran-trips.png',
        'path': const TravelList(
          title: 'Veteran Trips',
          img: 'assets/veteran-trips.png',
        ),
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xffF4FFE9),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //Search box
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        border: Border.all(color: darkGreen, width: 0.2),
                        color: lightGreen,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xff303030).withOpacity(0.5),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      width: w,
                      alignment: Alignment.center,
                      child: TextFormField(
                        controller: searchController,
                        keyboardType: TextInputType.text,
                        style: GoogleFonts.poppins(
                          color: darkGreen,
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                        ),
                        cursorColor: darkGreen,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.search, color: darkGreen),
                          hintText: 'Pune',
                          hintStyle: GoogleFonts.poppins(
                            color: Colors.grey.shade600,
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                          ),
                          border: InputBorder.none,
                          focusColor: const Color(0xff303030),
                          fillColor: const Color(0xff303030),
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          'TRENDING ',
                          style: GoogleFonts.leagueSpartan(
                            fontSize: 40,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        Icon(
                          Icons.rocket_launch,
                          size: 30,
                          color: darkGreen,
                        ),
                      ],
                    ),

                    //Trending
                    GestureDetector(
                      onTap: () {
                        Get.to(
                          () => const TrendingPage(),
                        );
                      },
                      child: Hero(
                        tag: 'trending',
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              width: w,
                              height: w,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.5),
                                    blurRadius: 10,
                                  ),
                                ],
                              ),
                              child: const CircleAvatar(
                                radius: 50,
                                backgroundImage:
                                    AssetImage("assets/monsoon-list.png"),
                              ),
                            ),
                            Container(
                              width: w,
                              height: w,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
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
                            Text(
                              'MONSOON TRAVEL LIST',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.leagueSpartan(
                                fontSize: 36,
                                fontWeight: FontWeight.w900,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),

                    //Seasonal
                    Text(
                      'SEASONAL',
                      style: GoogleFonts.leagueSpartan(
                        fontSize: 26,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
              SizedBox(
                width: w,
                height: 720,
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: travelList.length,
                  itemBuilder: (context, index) {
                    String title = travelList[index]['title'];
                    String image = travelList[index]['img'];
                    Widget page = travelList[index]['path'];
                    return SeasonalCards(
                      title: title,
                      img: image,
                      ontap: () {
                        Get.to(
                          () => page,
                          transition: Transition.cupertino,
                          duration: const Duration(milliseconds: 650),
                        );
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
