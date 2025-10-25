import 'package:flutter/material.dart';
import 'package:gym_app/view/loading_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Menghilangkan banner debug
      theme: ThemeData(
        // Kita bisa atur font default di sini agar konsisten
        fontFamily: 'Poppins', // (Pastikan Anda sudah menambahkan font Poppins jika ingin)
      ),
      // 2. Ganti home menjadi SplashScreen()
      home: const LoadingPage(),
    );
  }
}