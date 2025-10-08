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
      'name': 'جزر'
    },
    {
      'imageUrl': 'images/OIP (1).png',
      'name': 'جاج'
    },
    {
      'imageUrl': 'images/OIP (2).png',
      'name': 'بصل'
    },
    {
      'imageUrl': 'images/OIP (3).png',
      'name': 'ثوم'
    },
    {
      'imageUrl': 'images/OIP (4).jpg',
      'name': 'خيار'
    },
    {
      'imageUrl': 'images/OIP (5).png',
      'name': 'بندورة'
    },
    {
      'imageUrl': 'images/R.jpg',
      'name': 'بطاطه'
    },
    {
      'imageUrl': 'images/R (1).jpg',
      'name': 'لحمة'
    },
  ];


  List<String> numbers = [];

  @override
  void initState() {
    super.initState();
    numbers = List.filled(products.length, '0');
    loadData();
  }

  Future<void> updateNumber(int index, String value) async {
    setState(() {
      numbers[index] = value;
    });
    final user = FirebaseAuth.instance.currentUser;
    if(user == null)return;
    final uid = user.uid;
    final productName= products[index]['name']!;
    await FirebaseFirestore.instance
        .collection('restaurants')
    .doc(uid)
        .set(
      {productName: int.tryParse(value) ?? 0},
      SetOptions(merge: true),
    );
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
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: GridView.builder(
            itemCount: products.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 3 / 4,
            ),
            itemBuilder: (context, index) {
              final product = products[index];
              return ProductBox(
                imageUrl: product['imageUrl'] as String,
                name: product['name'] as String,
                savedNumber: numbers[index],
                onSave: (value) => updateNumber(index, value),
              );
            },
          ),
        ),
      ),
    );
  }
  Future<void> loadData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;
    final uid = user.uid;

    final doc = await FirebaseFirestore.instance.collection('restaurants').doc(uid).get();
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
    // يمكنك مسح الحقل بعد الحفظ إذا أردت:
    // controller.clear();
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
              ElevatedButton(
                onPressed: handleSave,
                child: const Text('حفظ'),
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