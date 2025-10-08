//import 'package:firebase_core/firebase_core.dart';
import 'package:complex/pages/D/Distributed.dart';
import 'package:complex/pages/D/Distributedone.dart';
import 'package:complex/pages/R/Restaurant.dart';
import 'package:complex/pages/R/Restaurantone.dart';
import 'package:complex/pages/R/Restaurantthree.dart';
import 'package:complex/pages/R/Restauranttwo.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final String tole = "";

  bool _loading = false;
  bool _showPass = false;
  String? _errorMessage;

  Future<void> _login(String email, String password) async {
    setState(() {
      _loading = true;
      _errorMessage = null;
    });

    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = credential.user;
      if (user != null) {
        final userData =
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        if (userData.exists) {
          final role = userData['role'] ?? '';

          if (role == 'distributed') {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const Distributor()),
            );
          } else if (role == 'distributorone') {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const Distributorone()),
            );
          } else if (role == 'restaurant') {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const Restaurant()),
            );
          } else if (role == 'restaurantone') {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const Restaurantone()),
            );
          } else if (role == 'restauranttwo') {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const Restauranttwo()),
            );
          } else if (role == 'restaurantthree') {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const Restaurantthree()),
            );
          } else {
            setState(() {
              _errorMessage = "هذا المستخدم ليس له صلاحية الدخول";
            });
          }
        } else {
          setState(() {
            _errorMessage =
            "لم يتم العثور على بيانات المستخدم في قاعدة البيانات";
          });
        }
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        if (e.code == 'user-not-found') {
          _errorMessage = 'لم يتم العثور على هذا المستخدم';
        } else if (e.code == 'wrong-password') {
          _errorMessage = 'كلمة المرور غير صحيحة';
        } else {
          _errorMessage = 'حدث خطأ أثناء تسجيل الدخول: ${e.message}';
        }
      });
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: const Color.fromARGB(255, 48, 0, 0),
      backgroundColor: Colors.white,
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            _errorMessage = null;
          });
        },
        child: Center(
          child: Container(
            width: 340,
            height: 500,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: Colors.black, width: 2),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text(
                  "Login",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        style: TextStyle(color: Colors.black),
                        controller: _usernameController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.person,color: Colors.black,),
                          labelText: "اسم المستخدم",
                          labelStyle: TextStyle(color: Colors.black),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'الرجاء إدخال اسم المستخدم';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        style: TextStyle(color: Colors.black),
                        controller: _passwordController,
                        obscureText: !_showPass,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.lock,color: Colors.black,),
                          labelText: "كلمة المرور",
                          labelStyle: TextStyle(color: Colors.black),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _showPass ? Icons.visibility : Icons.visibility_off,
                              color: Colors.black,
                            ),

                            onPressed: () {
                              setState(() {
                                _showPass = !_showPass;
                              });
                            },
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'الرجاء إدخال كلمة المرور';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      if (_errorMessage != null)
                        Text(
                          _errorMessage!,
                          style: const TextStyle(color: Colors.red),
                        ),
                    ],
                  ),
                ),
                _loading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                  onPressed: () async {
                    if(_formKey.currentState!.validate()){
                      await _login(
                        _usernameController.text.trim(),
                        _passwordController.text.trim(),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 63, 63, 63),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3)
                      )
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 15,
                    ),
                    child: Text(
                      "تسجيل الدخول",
                      style: TextStyle(fontSize: 18,color: Colors.white),
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




