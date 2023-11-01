import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import 'package:project_temples/main.dart';

class PlannerPage extends StatefulWidget {
  const PlannerPage({super.key});

  @override
  State<PlannerPage> createState() => _PlannerPageState();
}

class _PlannerPageState extends State<PlannerPage> {
  List plannerList = [];
  void _fetchPlannerList() {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    FirebaseFirestore.instance
        .collection('planner')
        .doc(uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        final data = documentSnapshot.data() as Map<String, dynamic>;
        final list = data['list'] as List<dynamic>;
        setState(() {
          plannerList = list.cast<String>().toList();
        });
      }
    });
  }

  @override
  void initState() {
    _fetchPlannerList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(title: const Text('My Planner')),
      body: plannerList.isEmpty
          ? const Center(
              child: Text('You have no planned trips'),
            )
          : Column(
              children: [
                Container(
                  height: w,
                  width: w,
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.black)),
                  margin: const EdgeInsets.symmetric(vertical: 15),
                  child: Image.asset(
                    'assets/maps-default.png',
                    fit: BoxFit.cover,
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: plannerList.length,
                    itemBuilder: (context, index) {
                      if (plannerList.isEmpty) {
                        return const Center(
                          child: Text('No planned trips!'),
                        );
                      }
                      return Column(
                        children: [
                          ListTile(
                            title: Container(
                              decoration: BoxDecoration(
                                  color: bgGreen,
                                  border: Border.all(color: Colors.black),
                                  borderRadius: BorderRadius.circular(15)),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15,
                                vertical: 15,
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    plannerList[index]
                                            .substring(0, 1)
                                            .toUpperCase() +
                                        plannerList[index]
                                            .substring(1)
                                            .toLowerCase(),
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const Expanded(child: SizedBox()),
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        plannerList.removeWhere((element) =>
                                            element ==
                                            plannerList[index].toLowerCase());
                                      });
                                      FirebaseFirestore.instance
                                          .collection('planner')
                                          .doc(uid)
                                          .set({'list': plannerList});
                                    },
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Color.fromARGB(255, 239, 121, 113),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Visibility(
                            visible: index != plannerList.length - 1,
                            child: Text('x Hours'),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
    );
  }
}
