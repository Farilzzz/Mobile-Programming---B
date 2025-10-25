import 'dart:async';
import 'package:flutter/material.dart';
// Ganti 'nama_proyek_anda' dengan nama proyek Flutter Anda
import 'package:gym_app/view/home_page.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  // 1. PERBAIKAN BUG: Ganti _HomePageState menjadi _LoadingPageState
  State<LoadingPage> createState() => _LoadingPageState();
}

// 2. PERBAIKAN BUG: Ganti _HomePageState menjadi _LoadingPageState
class _LoadingPageState extends State<LoadingPage> {
  @override
  void initState() {
    super.initState();
    // Kita buat timer selama 3 detik
    Timer(const Duration(seconds: 3), () {
      // Setelah 3 detik, pindah ke HomeScreen
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const HomePage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // 3. Hapus 'const' di Scaffold, Center, dan Column
    //    karena Image.asset bukan 'const'
    return Scaffold(
      backgroundColor: const Color(0xFF1C1C1E), // Warna background gelap
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 4. GANTI Icon DENGAN Image.asset
            Image.asset(
              'assets/images/logo.png', // <-- GANTI DENGAN NAMA LOGO ANDA
              width: 500.0, // Atur lebar gambar
              height: 500.0, // Atur tinggi gambar
            ),
            const SizedBox(height: 20),
            const Text(
              'Gym App', // Ganti dengan nama aplikasi Anda
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
