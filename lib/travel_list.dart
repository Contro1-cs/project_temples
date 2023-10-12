import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_temples/info_pages/more_info.dart';
import 'package:project_temples/main.dart';

class TravelList extends StatefulWidget {
  const TravelList({
    super.key,
    required this.title,
    required this.img,
  });
  final String title;
  final String img;

  @override
  State<TravelList> createState() => _TravelListState();
}

String description =
    'Lorem ipsum dolor sit amet consectetur. Felis facilisi tristique scelerisque quam curabitur eget tortor nibh facilisi. Urna quis accumsan scelerisque non. Ut sed et nulla ultrices. Sit bibendum ultrices morbi pellentesque dolor velit. Ligula ullamcorper semper consequat quis duis. Molestie mattis urna a fusce quis tincidunt. Mauris justo nec auctor vitae scelerisque adipiscing aliquet amet. Pretium donec sed pharetra id quis etiam faucibus. Nulla posuere nibh consectetur habitant nisi dolor odio egestas';
bool _isTimerPaused = false;

var travel_list = [
  {
    'name': 'Dagdusheth 1',
    'city': 'Pune',
    'lat': "18°30'59.5",
    'long': "73°51'22.4",
    'maps':
        'https://www.google.com/maps/place/Shreemant+Dagdusheth+Halwai+Ganpati+Mandir/@18.5164297,73.853558,17z/data=!3m1!4b1!4m6!3m5!1s0x3bc2c06fa5b442ff:0x9df365f5b648bce1!8m2!3d18.5164297!4d73.8561329!16s%2Fm%2F04zxxlg?entry=ttu',
    'description': description,
  },
  {
    'name': 'Dagdusheth 2',
    'city': 'Pune',
    'lat': "18°30'59.5",
    'long': "73°51'22.4",
    'maps':
        'https://www.google.com/maps/place/Shreemant+Dagdusheth+Halwai+Ganpati+Mandir/@18.5164297,73.853558,17z/data=!3m1!4b1!4m6!3m5!1s0x3bc2c06fa5b442ff:0x9df365f5b648bce1!8m2!3d18.5164297!4d73.8561329!16s%2Fm%2F04zxxlg?entry=ttu',
    'description': description,
  },
  {
    'name': 'Dagdusheth 3',
    'city': 'Pune',
    'lat': "18°30'59.5",
    'long': "73°51'22.4",
    'maps':
        'https://www.google.com/maps/place/Shreemant+Dagdusheth+Halwai+Ganpati+Mandir/@18.5164297,73.853558,17z/data=!3m1!4b1!4m6!3m5!1s0x3bc2c06fa5b442ff:0x9df365f5b648bce1!8m2!3d18.5164297!4d73.8561329!16s%2Fm%2F04zxxlg?entry=ttu',
    'description': description,
  },
];

class _TravelListState extends State<TravelList>
    with SingleTickerProviderStateMixin {
  double _progressValue = 0.0;
  int index = 0;
  Timer? _timer;
  late AnimationController _animationController;
  late Animation<double> _progressAnimation;

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _progressValue += 1.0;
        action();
      });
    });
  }

  void _stopTimer() {
    _timer?.cancel();
  }

  action() {
    if (_progressValue == 5) {
      _progressValue = 0.0;
      index++;

      if (index >= travel_list.length) {
        Get.back();
        index = 0;
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );
    _progressAnimation =
        Tween<double>(begin: 0.0, end: 10.0).animate(_animationController);
    _animationController.repeat(reverse: false);
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animationController.value = 0.0;
      }
    });
    _startTimer();
  }

  @override
  void dispose() {
    _stopTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: bgGreen,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            //cover photo
            Container(
              height: 150,
              width: w,
              color: lightGreen,
              child: Stack(
                children: [
                  Image.asset(
                    widget.img,
                    height: 150,
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
                          widget.title.toUpperCase(),
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
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                children: [
                  //temple photo
                  Container(
                    width: w,
                    height: 250,
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
                        Container(
                          height: w,
                          alignment: Alignment.bottomLeft,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                '#${index + 1}',
                                textAlign: TextAlign.left,
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
                              Text(
                                travel_list[index]['name']!.toUpperCase(),
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
                  const SizedBox(height: 20),
                  Text(
                    travel_list[index]['description']!,
                    style: GoogleFonts.leagueSpartan(
                      color: Colors.black,
                      height: 1.1,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 10),
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
                  Container(
                    width: w,
                    padding: const EdgeInsets.symmetric(vertical: 15),
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
                              Get.to(
                                () => MoreInfoPage(
                                  title:
                                      travel_list[index]['name']!.toUpperCase(),
                                  desc: description,
                                ),
                              );
                              dispose();
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
            ),
          ],
        ),
      ),
    );
  }
}
