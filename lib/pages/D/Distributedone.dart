import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:complex/logout.dart';
import 'package:flutter/material.dart';

class Distributorone extends StatefulWidget {
  const Distributorone({super.key});

  @override
  State<Distributorone> createState() => _DistributoroneState();
}

class _DistributoroneState extends State<Distributorone> {
  //
  int restaurantCarrot = 0;
  int restaurantoneCarrot = 0;
  int restauranttwoCarrot = 0;
  int restaurantthreeCarrot = 0;

  int restaurantChicken=0;
  int restaurantonecheck=0;
  int restauranttwocheck=0;
  int restaurantthreecheck=0;


  int restaurantOnion = 0;
  int restaurantoneOnion = 0;
  int restauranttwoOnion = 0;
  int restaurantthreeOnion = 0;

  int restaurantGarlic = 0;
  int restaurantoneGarlic = 0;
  int restauranttwoGarlic = 0;
  int restaurantthreeGarlic = 0;



  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    final res1 = await firestore.collection('restaurants').doc('dZaAycORyoQWtRtLN4r2qdm6Jlo1').get();
    if (res1.exists) {
      final data = res1.data()!;
      setState(() {
        restaurantCarrot = data['جزر'] ?? 0;
        restaurantChicken = data['جاج'] ?? 0;
        restaurantOnion = data['بصل'] ?? 0;
        restaurantGarlic = data['ثوم'] ?? 0;
      });
    }
  }
  void resetRestaurant(String uid) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("تأكيد"),
        content: const Text("هل أنت متأكد من تصفير أرقام هذا المطعم؟"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("لا"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text("نعم"),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      await firestore.collection('restaurants').doc(uid).update({
        'جزر': 0,
        'جاج': 0,
        'بصل': 0,
        'ثوم': 0,});
    }
    loadData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            "DISTRIBUTED",
            style: TextStyle(color: Colors.white),
          ),
        ),
        backgroundColor: Colors.black,
        actions: [LogoutButton()],
      ),
      body: SingleChildScrollView(

        child: ScrollConfiguration(
          behavior: const MaterialScrollBehavior().copyWith(
            dragDevices: {
              PointerDeviceKind.touch,
              PointerDeviceKind.mouse,
            },
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.only(top: 20, left: 20, right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Transform.translate(
                    offset: const Offset(143, 0),
                    child: Row(children: [
                      buildBox("جزر"),
                      buildBox("جاج"),
                      buildBox("بصل"),
                      buildBox("ثوم"),
                      buildBox("خيار"),
                      buildBox("بندورة"),
                      buildBox("لحمة"),
                    ]),
                  ),
                  const SizedBox(height: 30),

                  Row(children: [
                    const Text('RESTAURANT'),
                    const SizedBox(width: 53),
                    buildBox("$restaurantCarrot"),
                    buildBox("$restaurantChicken"),
                    buildBox("$restaurantOnion"),
                    buildBox("$restaurantGarlic"),

                  ]),
                  const SizedBox(height: 30),

                  Row(children: [
                    const Text('RESTAURANTONE'),
                    const SizedBox(width: 25),
                    buildBox("$restaurantoneCarrot"),
                    buildBox("$restaurantonecheck"),
                    buildBox("$restaurantoneOnion"),
                    buildBox("$restaurantoneGarlic"),
                  ]),
                  const SizedBox(height: 30),

                  Row(children: [
                    const Text('RESTAURANTTWO'),
                    const SizedBox(width: 23),
                    buildBox("$restauranttwoCarrot"),
                    buildBox("$restauranttwocheck"),
                    buildBox("$restauranttwoOnion"),
                    buildBox("$restauranttwoGarlic"),
                  ]),
                  const SizedBox(height: 30),

                  Row(children: [
                    const Text('RESTAURANTTHREE'),
                    const SizedBox(width: 10),
                    buildBox("$restaurantthreeCarrot"),
                    buildBox("$restaurantthreecheck"),
                    buildBox("$restaurantthreeOnion"),
                    buildBox("$restaurantthreeGarlic"),

                  ]),
                  const SizedBox(height: 30),
                  Row(children: [
                    const Text("مجموع"),
                    const SizedBox(width: 103),
                    buildBox("${restaurantCarrot + restaurantoneCarrot + restauranttwoCarrot + restaurantthreeCarrot}"),
                    buildBox("${restaurantChicken + restaurantonecheck + restauranttwocheck + restaurantthreecheck}"),
                    buildBox("${restaurantOnion + restaurantoneOnion + restauranttwoOnion + restaurantthreeOnion}"),
                    buildBox("${restaurantGarlic + restaurantoneGarlic + restauranttwoGarlic + restaurantthreeGarlic}"),
                  ]),
                  const SizedBox(height: 30),


                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


  Widget buildBox(String text) {
    return Container(
      height: 50,
      width: 70,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        border: Border.all(width: 1),
        borderRadius: const BorderRadius.horizontal(),
      ),
      alignment: Alignment.center,
      child: Text(text, textAlign: TextAlign.center),
    );
  }
}
