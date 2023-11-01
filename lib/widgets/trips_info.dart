import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_temples/travel_list.dart';

class TripsList extends StatefulWidget {
  const TripsList({
    super.key,
    required this.trending,
  });
  final bool trending;
  @override
  State<TripsList> createState() => _TripsListState();
}

int currentPage = 0;
bool exit = false;

class _TripsListState extends State<TripsList> {
  final PageController _pageController = PageController();
  List<DocumentSnapshot> _temples = [];

  @override
  void initState() {
    super.initState();
    exit = false;
    _fetchTemples();
    startAutoPageSwitch();
  }

  // Fetch data from Firestore 'temples' collection
  void _fetchTemples() {
    if (widget.trending) {
      FirebaseFirestore.instance
          .collection('trending')
          .get()
          .then((QuerySnapshot querySnapshot) {
        setState(() {
          _temples = querySnapshot.docs;
          templeDoc = _temples[0];
        });
      });
    } else {
      FirebaseFirestore.instance
          .collection('t')
          .get()
          .then((QuerySnapshot querySnapshot) {
        setState(() {
          _temples = querySnapshot.docs;
          templeDoc = _temples[0];
        });
      });
    }
  }

  // Automatically switch to the next page every 5 seconds
  void startAutoPageSwitch() {
    Future.delayed(const Duration(seconds: 5), () {
      if (exit == false) {
        if (currentPage < _temples.length - 1) {
          _pageController.animateToPage(currentPage + 1,
              duration: const Duration(milliseconds: 500), curve: Curves.ease);
        } else {
          // Get.back();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;

    return PageView.builder(
      controller: _pageController,
      itemCount: _temples.length,
      itemBuilder: (context, index) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
          child: Column(
            children: [
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
                            _temples[index]['title']!.toUpperCase(),
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
                _temples[index]['description']!,
                style: GoogleFonts.leagueSpartan(
                  color: Colors.black,
                  height: 1.1,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        );
      },
      onPageChanged: (int page) {
        setState(() {
          templeDoc = _temples[page];
          currentPage = page;
          startAutoPageSwitch();
        });
      },
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    exit = true;
    super.dispose();
  }
}
