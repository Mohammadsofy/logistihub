import 'package:complex/pages/D/Distributed.dart';
import 'package:complex/pages/D/Distributedone.dart';
import 'package:complex/pages/D/Distributedtwo.dart';
import 'package:complex/pages/R/Restaurant.dart';
import 'package:complex/pages/R/Restaurantone.dart';
import 'package:complex/pages/R/Restaurantthree.dart';
import 'package:complex/pages/R/Restauranttwo.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';
import 'loginpage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/Login',
      routes: {//
        '/Login': (context) => const LoginPage(),
        '/distributed': (context) => const Distributed(),
        '/distributedone': (context) => const Distributedone(),
        '/distributedtwo': (context) => const Distributedtwo(),
        '/restaurant': (context) => const Restaurant(),
        '/restaurantthree': (context) => const Restaurantthree(),
        '/restauranttwo': (context) => const Restauranttwo(),
        '/restaurantone': (context) => const Restaurantone(),

      },
    );
  }
}

