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
  int restaurantMeat = 0;
  int restaurantoneMeat = 0;
  int restauranttwoMeat = 0;
  int restaurantthreeMeat = 0;

  int restaurantChicken=0;
  int restaurantoneChicken=0;
  int restauranttwoChicken=0;
  int restaurantthreeChicken=0;


  final FirebaseFirestore firestore = FirebaseFirestore.instance;




  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      loadData();});
  }

  Future<void> loadData() async {

    final res1 = await firestore.collection('restaurants').doc('dZaAycORyoQWtRtLN4r2qdm6Jlo1').get();
    final res2 = await firestore.collection('restaurants').doc('spuesGx3irRXQhkxVrEk1vtCdvZ2').get();
    final res3 = await firestore.collection('restaurants').doc('S6T9EwZGopMgPsTFpZF01BVcpmn2').get();
    final res4 = await firestore.collection('restaurants').doc('djXHszgUsCaqBb8ByJwJbjg1ec12').get();

    setState(() {
      if (res1.exists) {
        final data = res1.data()!;
        restaurantChicken = data['جاج'] ?? 0;
        restaurantMeat = data['لحمة'] ?? 0;

      }
      if (res2.exists) {
        final data = res2.data()!;
        restaurantoneChicken= data['جاج'] ?? 0;
        restaurantoneMeat = data['لحمة'] ?? 0;

      }
      if (res3.exists) {
        final data = res3.data()!;
        restauranttwoChicken = data['جاج'] ?? 0;
        restauranttwoMeat = data['لحمة'] ?? 0;
      }
      if (res4.exists) {
        final data = res4.data()!;
        restaurantthreeChicken = data['جاج'] ?? 0;
        restaurantthreeMeat = data['لحمة'] ?? 0;
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
        'لحمة': 0,
        'جاج': 0,
      });
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
      body: RefreshIndicator(
        onRefresh: () async {
          await loadData();
        },
        child: SingleChildScrollView(

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
                        buildBox("لحمة"),
                        buildBox("جاج"),
                      ]),
                    ),
                    const SizedBox(height: 30),

                    Row(children: [
                      const Text('RESTAURANT'),
                      const SizedBox(width: 53),
                      buildBox("$restaurantMeat"),
                      buildBox("$restaurantChicken"),
                      IconButton(
                        icon: const Icon(Icons.restart_alt, color: Colors.red),
                        onPressed: () => resetRestaurant('dZaAycORyoQWtRtLN4r2qdm6Jlo1'),
                      ),

                    ]),
                    const SizedBox(height: 30),

                    Row(children: [
                      const Text('RESTAURANTONE'),
                      const SizedBox(width: 25),
                      buildBox("$restaurantoneMeat"),
                      buildBox("$restaurantoneChicken"),
                      IconButton(
                        icon: const Icon(Icons.restart_alt, color: Colors.red),
                        onPressed: () => resetRestaurant('spuesGx3irRXQhkxVrEk1vtCdvZ2'),
                      ),
                    ]),
                    const SizedBox(height: 30),

                    Row(children: [
                      const Text('RESTAURANTTWO'),
                      const SizedBox(width: 23),
                      buildBox("$restauranttwoMeat"),
                      buildBox("$restauranttwoChicken"),
                      IconButton(
                        icon: const Icon(Icons.restart_alt, color: Colors.red),
                        onPressed: () => resetRestaurant('S6T9EwZGopMgPsTFpZF01BVcpmn2'),
                      ),
                    ]),
                    const SizedBox(height: 30),

                    Row(children: [
                      const Text('RESTAURANTTHREE'),
                      const SizedBox(width: 10),
                      buildBox("$restaurantthreeMeat"),
                      buildBox("$restaurantthreeChicken"),
                      IconButton(
                        icon: const Icon(Icons.restart_alt, color: Colors.red),
                        onPressed: () => resetRestaurant('djXHszgUsCaqBb8ByJwJbjg1ec12'),
                      ),

                    ]),
                    const SizedBox(height: 30),
                    Row(children: [
                      const Text("المجموع"),
                      const SizedBox(width: 95),
                      buildsum("${restaurantMeat + restaurantoneMeat + restauranttwoMeat + restaurantthreeMeat}"),
                      buildsum("${restaurantChicken + restaurantoneChicken + restauranttwoChicken + restaurantthreeChicken}"),
                    ]),
                    const SizedBox(height: 30),


                  ],
                ),
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
      child: Text(text, textAlign: TextAlign.center,style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
    );
  }
  Widget buildsum(String text) {
    return Container(
      height: 50,
      width: 70,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.red, width: 3),
        borderRadius: const BorderRadius.horizontal(),
      ),
      alignment: Alignment.center,
      child: Text(text, textAlign: TextAlign.center),
    );
  }
}
