import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 1. Background gelap sesuai tema
      backgroundColor: const Color(0xFF1C1C1E),
      
      // 2. App Bar Kustom
      appBar: _buildAppBar(context),
      
      // 3. Body Utama
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Bagian Header Profil (Foto, Nama, Tombol Edit)
            _buildProfileHeader(),
            const SizedBox(height: 30),
            
            // Bagian Kartu Statistik (Height, Weight, Age)
            _buildStatsCard(),
            const SizedBox(height: 30),
            
            // Bagian Daftar Menu (Account & Other)
            _buildSettingsList(),
          ],
        ),
      ),
    );
  }

  /// Helper widget untuk membuat AppBar
  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent, // Transparan
      elevation: 0,
      // Tombol kembali
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
        onPressed: () => Navigator.of(context).pop(),
      ),
      // Judul "Profile"
      title: const Text(
        "Profile",
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      centerTitle: true,
      // Tombol Edit di kanan
      actions: [
        IconButton(
          icon: const Icon(Icons.edit, color: Colors.white),
          onPressed: () {
            // TODO: Fungsi untuk edit profile
          },
        ),
      ],
    );
  }

  /// Helper widget untuk bagian header (Foto, Nama, Tombol)
  Widget _buildProfileHeader() {
    return Column(
      children: [
        const CircleAvatar(
          radius: 50,
          backgroundColor: Color(0xFF2C2C2E), // Warna abu-abu gelap
          // Ganti dengan Image.asset jika punya gambar
          child: Icon(Icons.person, size: 50, color: Colors.white70),
        ),
        const SizedBox(height: 16),
        const Text(
          "Bambang", // Placeholder Nama
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          "@Faril", // Placeholder username
          style: TextStyle(color: Colors.grey, fontSize: 16),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            // TODO: Fungsi untuk edit profile
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueAccent, // Warna tombol
            shape: const StadiumBorder(), // Bentuk rounded penuh
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
          ),
          child: const Text(
            "Edit Profile",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }

  /// Helper widget untuk kartu statistik (Height, Weight, Age)
  Widget _buildStatsCard() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF2C2C2E), // Warna abu-abu gelap
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem("180 cm", "Height"),
          _buildStatItem("75 kg", "Weight"),
          _buildStatItem("22", "Age"),
        ],
      ),
    );
  }

  /// Helper widget untuk satu item statistik (misal: "180 cm" dan "Height")
  Widget _buildStatItem(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(color: Colors.grey, fontSize: 14),
        ),
      ],
    );
  }

  /// Helper widget untuk semua daftar menu (Account, Other, Logout)
  Widget _buildSettingsList() {
    return Column(
      children: [
        // --- Bagian Akun ---
        _buildSettingsSectionTitle("Account"),
        _buildSettingsItem(Icons.person, "Personal Data", () {}),
        _buildSettingsItem(Icons.notifications, "Notification", () {}),
        
        // --- Bagian Lainnya ---
        const SizedBox(height: 20),
        _buildSettingsSectionTitle("Other"),
        _buildSettingsItem(Icons.email, "Contact Us", () {}),
        _buildSettingsItem(Icons.settings, "Setting", () {}),

        // --- Tombol Logout ---
        const SizedBox(height: 20),
        _buildSettingsItem(
          Icons.logout,
          "Log Out",
          () {
            // TODO: Fungsi untuk Log out
          },
          color: Colors.red, // Beri warna merah
        ),
      ],
    );
  }

  /// Helper widget untuk judul seksi (misal: "Account")
  Widget _buildSettingsSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  /// Helper widget untuk satu baris menu (Item Setting)
  Widget _buildSettingsItem(IconData icon, String title, VoidCallback onTap,
      {Color? color}) {
    // Tentukan warna item, default-nya putih
    final itemColor = color ?? Colors.white;

    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(15),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: const Color(0xFF2C2C2E), // Warna abu-abu gelap
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: [
              Icon(icon, color: itemColor),
              const SizedBox(width: 16),
              Text(
                title,
                style: TextStyle(
                  color: itemColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(), // Dorong ikon panah ke paling kanan
              // Jangan tampilkan panah jika itu tombol logout
              if (color == null)
                const Icon(Icons.chevron_right, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}
