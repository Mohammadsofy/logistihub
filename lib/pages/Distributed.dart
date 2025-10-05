import 'package:flutter/material.dart';

import '../logout.dart';

class Distributor extends StatefulWidget {
  const Distributor({super.key});

  @override
  State<Distributor> createState() => _DistributorState();
}

class _DistributorState extends State<Distributor> {
  final products = [
    {
      'imageUrl': 'images/OIP.png',
    },
    {
      'imageUrl': 'images/OIP (1).png',
    },
    {
      'imageUrl': 'images/OIP (2).png',
    },
    {
      'imageUrl': 'images/OIP (3).png',
    },
    {
      'imageUrl': 'images/OIP (4).jpg',
    },
    {
      'imageUrl': 'images/OIP (5).png',
    },
    {
      'imageUrl': 'images/R.jpg',
    },
    {
      'imageUrl': 'images/R (1).jpg',
    },
  ];

  // قائمة أرقام المنتجات (نفس عدد المنتجات)
  List<String> numbers = [];

  @override
  void initState() {
    super.initState();
    numbers = List.filled(products.length, '0'); // رقم افتراضي لكل منتج
  }

  void updateNumber(int index, String value) {
    setState(() {
      numbers[index] = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("RESTAURANT", style: TextStyle(color: Colors.white))),
        backgroundColor: Colors.black,
        actions: const [LogoutButton()],
      ),
      body: Padding(
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
              savedNumber: numbers[index],
              onSave: (value) => updateNumber(index, value),
            );
          },
        ),
      ),
    );
  }
}

class ProductBox extends StatefulWidget {
  final String imageUrl;
  final String savedNumber;
  final ValueChanged<String> onSave;

  const ProductBox({
    super.key,
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