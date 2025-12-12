import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:aplikasi_gym/controller/auth_controller.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  final authC = Get.find<AuthController>();

  @override
  void initState() {
    super.initState();

    _startLoading();
  }

  void _startLoading() async {

    await Future.delayed(const Duration(seconds: 3));

 
    authC.checkLoginStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C1C1E),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
 
            Image.asset('assets/images/logo.png', width: 500.0, height: 500.0),
            const SizedBox(height: 20),
            const Text(
              'GYM APP',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            const CircularProgressIndicator(color: Color(0xFF00F0FF)),
          ],
        ),
      ),
    );
  }
}
