import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:complex/logout.dart';
import 'package:flutter/material.dart';

class Distributor extends StatefulWidget {
  const Distributor({super.key});

  @override
  State<Distributor> createState() => _DistributorState();
}

class _DistributorState extends State<Distributor> {
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
    final res2 = await firestore.collection('restaurants').doc('spuesGx3irRXQhkxVrEk1vtCdvZ2').get();
    final res3 = await firestore.collection('restaurants').doc('S6T9EwZGopMgPsTFpZF01BVcpmn2').get();
    final res4 = await firestore.collection('restaurants').doc('djXHszgUsCaqBb8ByJwJbjg1ec12').get();

    setState(() {
      if (res1.exists) {
        final data = res1.data()!;
        restaurantCarrot = data['جزر'] ?? 0;
        restaurantChicken = data['جاج'] ?? 0;
        restaurantOnion = data['بصل'] ?? 0;
        restaurantGarlic = data['ثوم'] ?? 0;
      }
      if (res2.exists) {
        final data = res2.data()!;
        restaurantoneCarrot = data['جزر'] ?? 0;
        restaurantonecheck = data['جاج'] ?? 0;
        restaurantoneOnion = data['بصل'] ?? 0;
        restaurantoneGarlic = data['ثوم'] ?? 0;
      }
      if (res3.exists) {
        final data = res3.data()!;
        restauranttwoCarrot = data['جزر'] ?? 0;
        restauranttwocheck = data['جاج'] ?? 0;
        restauranttwoOnion = data['بصل'] ?? 0;
        restauranttwoGarlic = data['ثوم'] ?? 0;
      }
      if (res4.exists) {
        final data = res4.data()!;
        restaurantthreeCarrot = data['جزر'] ?? 0;
        restaurantthreecheck = data['جاج'] ?? 0;
        restaurantthreeOnion = data['بصل'] ?? 0;
        restaurantthreeGarlic = data['ثوم'] ?? 0;
      }
    });
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
                    IconButton(
                      icon: const Icon(Icons.restart_alt, color: Colors.red),
                      onPressed: () => resetRestaurant('dZaAycORyoQWtRtLN4r2qdm6Jlo1'),
                    ),

                  ]),
                  const SizedBox(height: 30),

                  Row(children: [
                    const Text('RESTAURANTONE'),
                    const SizedBox(width: 25),
                    buildBox("$restaurantoneCarrot"),
                    buildBox("$restaurantonecheck"),
                    buildBox("$restaurantoneOnion"),
                    buildBox("$restaurantoneGarlic"),
                    IconButton(
                      icon: const Icon(Icons.restart_alt, color: Colors.red),
                      onPressed: () => resetRestaurant('spuesGx3irRXQhkxVrEk1vtCdvZ2'),
                    ),
                  ]),
                  const SizedBox(height: 30),

                  Row(children: [
                    const Text('RESTAURANTTWO'),
                    const SizedBox(width: 23),
                    buildBox("$restauranttwoCarrot"),
                    buildBox("$restauranttwocheck"),
                    buildBox("$restauranttwoOnion"),
                    buildBox("$restauranttwoGarlic"),
                    IconButton(
                      icon: const Icon(Icons.restart_alt, color: Colors.red),
                      onPressed: () => resetRestaurant('S6T9EwZGopMgPsTFpZF01BVcpmn2'),
                    ),
                  ]),
                  const SizedBox(height: 30),

                  Row(children: [
                    const Text('RESTAURANTTHREE'),
                    const SizedBox(width: 10),
                    buildBox("$restaurantthreeCarrot"),
                    buildBox("$restaurantthreecheck"),
                    buildBox("$restaurantthreeOnion"),
                    buildBox("$restaurantthreeGarlic"),
                    IconButton(
                      icon: const Icon(Icons.restart_alt, color: Colors.red),
                      onPressed: () => resetRestaurant('djXHszgUsCaqBb8ByJwJbjg1ec12'),
                    ),

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
