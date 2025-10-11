import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:complex/logout.dart';
import 'package:flutter/material.dart';

class Distributedtwo extends StatefulWidget {
  const Distributedtwo({super.key});

  @override
  State<Distributedtwo> createState() => _DistributedtwoState();
}

class _DistributedtwoState extends State<Distributedtwo> {
  //
  int restaurantwhitebread = 0;
  int restaurantonewhitebread = 0;
  int restauranttwowhitebread = 0;
  int restaurantthreewhitebread = 0;

  int restauranttoastbread=0;
  int restaurantonetoastbread=0;
  int restauranttwotoastbread=0;
  int restaurantthreetoastbread=0;


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
        restauranttoastbread =data['توست']??0;
        restaurantwhitebread = data['خبز ابيض'] ?? 0;

      }
      if (res2.exists) {
        final data = res2.data()!;
        restaurantonetoastbread= data['توست']??0;
        restaurantonewhitebread = data['خبز ابيض'] ?? 0;

      }
      if (res3.exists) {
        final data = res3.data()!;
        restauranttwotoastbread = data['توست']??0;
        restauranttwowhitebread = data['خبز ابيض'] ?? 0;
      }
      if (res4.exists) {
        final data = res4.data()!;
        restaurantthreetoastbread = data['توست']??0;
        restaurantthreewhitebread = data['خبز ابيض'] ?? 0;
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
        'توست': 0,
        'خبز ابيض': 0,

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
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF80DEEA),
                Color(0xFFFFECB3)
              ],
            ),
          ),
          child: RefreshIndicator(
            onRefresh: loadData,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20, left: 20, right: 10, bottom: 50),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Transform.translate(
                        offset: const Offset(143, 0),
                        child: Row(children: [
                          buildBox('توست'),
                          buildBox('خبز ابيض'),
                        ]),
                      ),
                      const SizedBox(height: 30),
                      Row(children: [
                        const Text('RESTAURANT'),
                        const SizedBox(width: 53),
                        buildBox("$restauranttoastbread"),
                        buildBox("$restaurantwhitebread"),
                        IconButton(
                          icon: const Icon(Icons.restart_alt, color: Colors.red),
                          onPressed: () => resetRestaurant('dZaAycORyoQWtRtLN4r2qdm6Jlo1'),
                        ),
                      ]),
                      const SizedBox(height: 30),
                      Row(children: [
                        const Text('RESTAURANTONE'),
                        const SizedBox(width: 25),
                        buildBox("$restaurantonetoastbread"),
                        buildBox("$restaurantonewhitebread"),
                        IconButton(
                          icon: const Icon(Icons.restart_alt, color: Colors.red),
                          onPressed: () => resetRestaurant('spuesGx3irRXQhkxVrEk1vtCdvZ2'),
                        ),
                      ]),
                      const SizedBox(height: 30),
                      Row(children: [
                        const Text('RESTAURANTTWO'),
                        const SizedBox(width: 23),
                        buildBox("$restauranttwotoastbread"),
                        buildBox("$restauranttwowhitebread"),
                        IconButton(
                          icon: const Icon(Icons.restart_alt, color: Colors.red),
                          onPressed: () => resetRestaurant('S6T9EwZGopMgPsTFpZF01BVcpmn2'),
                        ),
                      ]),
                      const SizedBox(height: 30),
                      Row(children: [
                        const Text('RESTAURANTTHREE'),
                        const SizedBox(width: 10),
                        buildBox("$restaurantthreetoastbread"),
                        buildBox("$restaurantthreewhitebread"),
                        IconButton(
                          icon: const Icon(Icons.restart_alt, color: Colors.red),
                          onPressed: () => resetRestaurant('djXHszgUsCaqBb8ByJwJbjg1ec12'),
                        ),
                      ]),
                      const SizedBox(height: 30),
                      Row(children: [
                        const Text("المجموع"),
                        const SizedBox(width: 95),
                        buildsum("${restauranttoastbread + restaurantonetoastbread + restauranttwowhitebread + restaurantthreetoastbread}"),
                        buildsum("${restaurantwhitebread + restaurantonewhitebread + restauranttwowhitebread + restaurantthreewhitebread}"),
                      ]),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ),
          ),
        )
    );
  }


  Widget buildBox(String text) {
    return Container(
      height: 50,
      width: 100,
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
      width: 100,
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
