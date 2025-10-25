import 'package:flutter/material.dart';
import 'package:gym_app/view/focus_exercise_page.dart';
import 'package:gym_app/view/profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  // Daftar halaman untuk BottomNav
  static final List<Widget> _widgetOptions = <Widget>[
    const HomeContent(), // <-- Konten Home kita yang baru
    const Center(
        child: Text('Halaman Share', style: TextStyle(color: Colors.white))),
    const Center(
        child: Text('Halaman Favorite', style: TextStyle(color: Colors.white))),
    const ProfilePage(), // Halaman Profil
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C1C1E),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF2C2C2E),
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.share), label: "Share"),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Favorite"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        showUnselectedLabels: false,
        showSelectedLabels: false,
      ),
    );
  }
}

// --- KONTEN BARU UNTUK HALAMAN HOME ("HELLO FARIL") ---

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView( // Gunakan ListView agar bisa scroll
        children: [
          // 1. Header "HELLO FARIL"
          _buildHeader(context), // <-- Kirim context
          const SizedBox(height: 20),

          // 2. Daftar Kategori Vertikal
          _buildCategoryCard(
            context: context,
            title: "All Exercise",
            imagePath: "assets/images/all_exercise.png",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const FocusExercisePage()),
              );
            },
          ),
          _buildCategoryCard(
            context: context,
            title: "Tips Exercise in GYM",
            imagePath: "assets/images/tips_exercise.png",
            onTap: () {
              // TODO: Buat halaman untuk ini
            },
          ),
          _buildCategoryCard(
            context: context,
            title: "Tips Cutting",
            imagePath: "assets/images/tips_cutting.png",
            onTap: () {
              // TODO: Buat halaman untuk ini
            },
          ),
          _buildCategoryCard(
            context: context,
            title: "Tips Bulking",
            imagePath: "assets/images/tips_bulking.png",
            onTap: () {
              // TODO: Buat halaman untuk ini
            },
          ),
        ],
      ),
    );
  }

  /// Helper untuk Header "HELLO FARIL" (Sudah di-update)
  Widget _buildHeader(BuildContext context) { // <-- Terima context
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      // 1. Ubah jadi Row
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // 2. Kolom Teks
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "HELLO FARIL",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4),
              Text(
                "Good Morning",
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
            ],
          ),
          
          // 3. Tambahkan Avatar Profil
          InkWell(
            onTap: () {
              // Navigasi ke Halaman Profile
              // Pilihan 1: Langsung navigasi (paling simpel)
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ProfilePage()),
              );
              // Pilihan 2: Panggil Bottom Nav (lebih rumit, perlu callback)
              // Untuk UTS, Pilihan 1 sudah sangat cukup.
            },
            borderRadius: BorderRadius.circular(25),
            child: const CircleAvatar(
              radius: 25,
              backgroundColor: Color(0xFF2C2C2E), // Warna abu-abu gelap
              // Ganti dengan gambar profil jika ada
              child: Icon(Icons.person, color: Colors.white, size: 30),
            ),
          ),
        ],
      ),
    );
  }

  /// Helper untuk Kartu Kategori (Desain Baru)
  Widget _buildCategoryCard({
    required BuildContext context,
    required String title,
    required String imagePath,
    required VoidCallback onTap,
  }) {
    // ... (Kode ini tidak berubah)
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        height: 160,
        margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.cover,
            onError: (exception, stackTrace) {},
          ),
          color: const Color(0xFF2C2C2E),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: LinearGradient(
              colors: [
                Colors.black.withOpacity(0.7),
                Colors.transparent,
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.center,
            ),
          ),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}