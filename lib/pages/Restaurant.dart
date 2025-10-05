import 'package:complex/logout.dart';
import 'package:flutter/material.dart';

class Restaurant extends StatelessWidget {
  const Restaurant({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(
          child: const Text("RESTAURANT",
              style: TextStyle(color: Colors.white))),
        backgroundColor: Colors.black,
      actions: const[LogoutButton()],),
      body: const Center(child: Text("RESTAURANT")),
    );
  }
}