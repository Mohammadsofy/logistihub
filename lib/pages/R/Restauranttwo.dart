import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../logout.dart';

class Restauranttwo extends StatefulWidget {
  const Restauranttwo({super.key});

  @override
  State<Restauranttwo> createState() => _RestauranttwoState();
}

class _RestauranttwoState extends State<Restauranttwo> {
  final products = [
    {
      'imageUrl': 'images/OIP.png',
      'name': 'جزر',
      'section': 'خضار',
    },
    {
      'imageUrl': 'images/OIP (1).png',
      'name': 'جاج',
      'section': 'لحوم',
    },
    {
      'imageUrl': 'images/OIP (2).png',
      'name': 'بصل',
      'section': 'خضار',
    },
    {
      'imageUrl': 'images/OIP (3).png',
      'name': 'ثوم',
      'section': 'خضار',
    },
    {
      'imageUrl': 'images/OIP (4).jpg',
      'name': 'خيار',
      'section': 'خضار',
    },
    {
      'imageUrl': 'images/OIP (5).png',
      'name': 'بندورة',
      'section': 'خضار',
    },
    {
      'imageUrl': 'images/R.jpg',
      'name': 'بطاطه',
      'section': 'خضار',
    },
    {
      'imageUrl': 'images/R (1).jpg',
      'name': 'لحمة',
      'section': 'لحوم',
    },
    {
      'imageUrl': 'images/R (1).jpg',
      'name': 'تفاح',
      'section': 'فواكه',
    },
    {
      'imageUrl': 'images/R (1).jpg',
      'name': 'موز',
      'section': 'فواكه',
    },
  ];

  final List<String> sections = ['خضار', 'فواكه', 'لحوم'];

  late List<String> numbers;
  final Map<String, GlobalKey> sectionKeys = {};
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    numbers = List.filled(products.length, '0');
    for (var section in sections) {
      sectionKeys[section] = GlobalKey();
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadData();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> updateNumber(int index, String value) async {
    setState(() {
      numbers[index] = value;
    });
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;
    final uid = user.uid;
    final productName = products[index]['name']!;
    await FirebaseFirestore.instance
        .collection('Restauranttwos')
        .doc(uid)
        .set(
      {productName: int.tryParse(value) ?? 0},
      SetOptions(merge: true),
    );
  }

  Future<void> loadData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;
    final uid = user.uid;

    final doc = await FirebaseFirestore.instance.collection('Restauranttwos').doc(uid).get();
    if (doc.exists) {
      final data = doc.data()!;
      setState(() {
        for (int i = 0; i < products.length; i++) {
          final productName = products[i]['name']!;
          numbers[i] = (data[productName] ?? '0').toString();
        }
      });
    }
  }

  void _scrollToSection(String section) {
    final context = sectionKeys[section]?.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Restauranttwo", style: TextStyle(color: Colors.white))),
        backgroundColor: Colors.black,
        actions: const [LogoutButton()],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await loadData();
        },
        child: Container(
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
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                // الأزرار بالأعلى
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: sections.map((section) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color(0xFF80DEEA),
                                Color(0xFFFFECB3)
                              ],
                            ),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                )
                            ),
                            onPressed: () => _scrollToSection(section),
                            child: Text(section),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 12),
                // المنتجات بأقسامها
                Expanded(
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    child: Column(

                      children: sections.map((section) {
                        final sectionProducts = products
                            .asMap()
                            .entries
                            .where((entry) => entry.value['section'] == section)
                            .toList();
                        if (sectionProducts.isEmpty) return const SizedBox.shrink();
                        return Column(
                          key: sectionKeys[section],
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Container(
                                height: 50,
                                width: double.infinity,
                                padding: const EdgeInsets.all(8),
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
                                child: Center(
                                  child: Text(
                                    section,
                                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                            GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: sectionProducts.length,
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                childAspectRatio: 3 / 4,
                              ),
                              itemBuilder: (context, idx) {
                                final index = sectionProducts[idx].key;
                                final product = sectionProducts[idx].value;
                                return ProductBox(
                                  imageUrl: product['imageUrl'] as String,
                                  name: product['name'] as String,
                                  savedNumber: numbers[index],
                                  onSave: (value) => updateNumber(index, value),
                                );
                              },
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProductBox extends StatefulWidget {
  final String imageUrl;
  final String name;
  final String savedNumber;
  final ValueChanged<String> onSave;

  const ProductBox({
    super.key,
    required this.name,
    required this.imageUrl,
    required this.savedNumber,
    required this.onSave,
  });

  @override
  State<ProductBox> createState() => _ProductBoxState();
}

class _ProductBoxState extends State<ProductBox> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void handleSave() {
    widget.onSave(controller.text.isEmpty ? '0' : controller.text);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                widget.imageUrl,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Center(
            child: Text(
                widget.name,
                style: const TextStyle(
                  fontSize: 16,)),
          ),

          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'ادخل رقم المنتج',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF80DEEA),
                      Color(0xFFFFECB3)
                    ],
                  ),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: ElevatedButton(
                  onPressed: handleSave,
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      )
                  ),
                  child: const Text('حفظ',),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            "الرقم المدخل: ${widget.savedNumber}",
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}