import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'loginpage.dart'; // تأكد مسار ملف LoginPage صح

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.logout),
      onPressed: () async {
        // تسجيل الخروج من Firebase
        await FirebaseAuth.instance.signOut();
        // العودة لصفحة تسجيل الدخول وحذف كل الصفحات السابقة
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
              (route) => false,
        );
      },
      tooltip: 'تسجيل الخروج',
    );
  }
}
