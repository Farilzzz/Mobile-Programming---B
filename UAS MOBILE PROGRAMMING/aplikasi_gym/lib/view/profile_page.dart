import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:aplikasi_gym/controller/profile_controller.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Pastikan Controller di-put
    final controller = Get.put(ProfileController());

    return Scaffold(
      backgroundColor: const Color(0xFF1C1C1E),
      appBar: _buildAppBar(context, controller),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(color: Color(0xFF00F0FF)),
          );
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
            top: 10,
            bottom: 120,
          ),
          child: Column(
            children: [
              _buildProfileHeader(controller),
              const SizedBox(height: 25), 

              _buildStatsCard(controller),
              const SizedBox(height: 25), 

              _buildSettingsList(controller),
            ],
          ),
        );
      }),
    );
  }

  AppBar _buildAppBar(BuildContext context, ProfileController c) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: const Text(
        "Profile",
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
      actions: [
       
        IconButton(
          icon: const Icon(Icons.edit, color: Colors.white),
          onPressed: () => c.showEditSheet(), 
        ),
      ],
    );
  }

  Widget _buildProfileHeader(ProfileController c) {
    return Column(
      children: [
        const CircleAvatar(
          radius: 45, 
          backgroundColor: Color(0xFF2C2C2E),
          child: Icon(Icons.person, size: 45, color: Colors.white70),
        ),
        const SizedBox(height: 10),

        Text(
          c.username.value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 4),

        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: const Color(0xFF00F0FF).withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color(0xFF00F0FF)),
          ),
          child: Text(
            c.level.value.toUpperCase(),
            style: const TextStyle(
              color: Color(0xFF00F0FF),
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        const SizedBox(height: 15),

        
        ElevatedButton(
          onPressed: () => c.showEditSheet(), 
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF00F0FF),
            foregroundColor: Colors.black,
            shape: const StadiumBorder(),
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          ),
          child: const Text(
            "Edit Profile",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
        ),
      ],
    );
  }

  Widget _buildStatsCard(ProfileController c) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF2C2C2E),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem("${c.height.value.toStringAsFixed(0)} cm", "Height"),
          Container(width: 1, height: 30, color: Colors.grey.withOpacity(0.3)),
          _buildStatItem("${c.weight.value.toStringAsFixed(0)} kg", "Weight"),
          Container(width: 1, height: 30, color: Colors.grey.withOpacity(0.3)),
          _buildStatItem("${c.age.value} yo", "Age"),
        ],
      ),
    );
  }

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
        const SizedBox(height: 2),
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
      ],
    );
  }

  Widget _buildSettingsList(ProfileController c) {
    return Column(
      children: [
 
        _buildSettingsSectionTitle("General"),
        _buildSettingsItem(
          Icons.track_changes,
          "Goal: ${c.goal.value}", 
          () {},
        ),
      
        _buildSettingsItem(Icons.male, "Gender: ${c.gender.value}", () {}),

        const SizedBox(height: 15),

        _buildSettingsSectionTitle("Account"),
        _buildSettingsItem(
          Icons.person_outline,
          "Personal Data",
          () => c.showEditSheet(),
        ),
        _buildSettingsItem(Icons.notifications_none, "Notification", () {}),

        const SizedBox(height: 15),
        _buildSettingsSectionTitle("Other"),
        _buildSettingsItem(Icons.mail_outline, "Contact Us", () {}),
        _buildSettingsItem(Icons.settings_outlined, "Setting", () {}),

        const SizedBox(height: 15),
        _buildSettingsItem(
          Icons.logout,
          "Log Out",
          () => c.logout(),
          color: Colors.redAccent,
        ),
      ],
    );
  }

  Widget _buildSettingsSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildSettingsItem(
    IconData icon,
    String title,
    VoidCallback onTap, {
    Color? color,
  }) {
    final itemColor = color ?? Colors.white;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Material(
        color: const Color(0xFF2C2C2E),
        borderRadius: BorderRadius.circular(
          15,
        ), 
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(15), 
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
         
            decoration: BoxDecoration(
           
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              children: [
                Icon(icon, color: itemColor, size: 22),
                const SizedBox(width: 16),
                Text(
                  title,
                  style: TextStyle(
                    color: itemColor,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
                if (color == null)
                  const Icon(Icons.chevron_right, color: Colors.grey, size: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
