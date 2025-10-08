import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.logout),
      onPressed: () async {
        await FirebaseAuth.instance.signOut();
        Navigator.pushNamedAndRemoveUntil(
          context,
          "/Login",
              (route) => false,
        );
      },
      tooltip: 'تسجيل الخروج',
    );
  }
}
