import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:aplikasi_gym/controller/profile_setup_controller.dart';
import 'package:aplikasi_gym/widgets/custom_button.dart';

class ProfileSetupPage extends StatelessWidget {
  const ProfileSetupPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileSetupController());

    return Scaffold(
      backgroundColor: const Color(0xFF1C1C1E),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => controller.previousPage(),
        ),
        title: Obx(() => Text(
          "Step ${controller.pageIndex.value + 1} of 7", 
          style: const TextStyle(color: Colors.white70, fontSize: 16)
        )),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: controller.pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _buildScrollable(_buildGenderPage(controller)),
                _buildScrollable(_buildAgePage(controller)),
                _buildScrollable(_buildWeightPage(controller)),
                _buildScrollable(_buildHeightPage(controller)),
                _buildScrollable(_buildLevelPage(controller)),
                _buildScrollable(_buildGoalPage(controller)),
                _buildScrollable(_buildReviewPage(controller)), 
              ],
            ),
          ),
          SafeArea(
            child: Container(
              padding: const EdgeInsets.all(20.0),
              width: double.infinity,
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator(color: Color(0xFF00F0FF)));
                }
                return CustomButton(
                  text: controller.pageIndex.value == 6 ? "Finish & Start" : "Next >",
                  color: const Color(0xFF00F0FF),
                  textColor: Colors.black,
                  onPressed: () => controller.nextPage(),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScrollable(Widget child) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: child,
      ),
    );
  }



  Widget _buildGenderPage(ProfileSetupController c) {
    return Column(
      children: [
        const Text("TELL US ABOUT YOURSELF", textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w900)),
        const SizedBox(height: 30),
        Obx(() => Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _genderCard(c, "Male", Icons.male),
            const SizedBox(width: 20),
            _genderCard(c, "Female", Icons.female),
          ],
        )),
      ],
    );
  }

  Widget _buildAgePage(ProfileSetupController c) {
    return Column(
      children: [
        const Text("HOW OLD ARE YOU?", style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
        const SizedBox(height: 30),
        Obx(() => Text("${c.selectedAge.value}", style: const TextStyle(color: Colors.white, fontSize: 70, fontWeight: FontWeight.bold))),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(icon: const Icon(Icons.remove_circle_outline, color: Colors.grey, size: 50), onPressed: () => c.selectedAge.value--),
            const SizedBox(width: 30),
            IconButton(icon: const Icon(Icons.add_circle, color: Color(0xFF00F0FF), size: 50), onPressed: () => c.selectedAge.value++),
          ],
        ),
      ],
    );
  }

  Widget _buildWeightPage(ProfileSetupController c) {
    return Column(
      children: [
        const Text("WHAT'S YOUR WEIGHT?", style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
        const SizedBox(height: 20),
        Obx(() => RichText(
          text: TextSpan(children: [
            // UPDATE: PAKE .toInt() BIAR BULAT (GAK ADA KOMA)
            TextSpan(text: "${c.selectedWeight.value.toInt()}", style: const TextStyle(color: Colors.white, fontSize: 60, fontWeight: FontWeight.bold)),
            const TextSpan(text: " kg", style: TextStyle(color: Color(0xFF00F0FF), fontSize: 20, fontWeight: FontWeight.bold)),
          ]),
        )),
        Obx(() => Slider(
            value: c.selectedWeight.value, min: 30, max: 150,
            activeColor: const Color(0xFF00F0FF), inactiveColor: const Color(0xFF2C2C2E),
            onChanged: (val) => c.selectedWeight.value = val)),
      ],
    );
  }

  Widget _buildHeightPage(ProfileSetupController c) {
    return Column(
      children: [
        const Text("WHAT'S YOUR HEIGHT?", style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
        const SizedBox(height: 20),
        Obx(() => RichText(
          text: TextSpan(children: [
  
            TextSpan(text: "${c.selectedHeight.value.toInt()}", style: const TextStyle(color: Colors.white, fontSize: 60, fontWeight: FontWeight.bold)),
            const TextSpan(text: " cm", style: TextStyle(color: Color(0xFF00F0FF), fontSize: 20, fontWeight: FontWeight.bold)),
          ]),
        )),
        Obx(() => Slider(
            value: c.selectedHeight.value, min: 100, max: 220,
            activeColor: const Color(0xFF00F0FF), inactiveColor: const Color(0xFF2C2C2E),
            onChanged: (val) => c.selectedHeight.value = val)),
      ],
    );
  }

  Widget _buildLevelPage(ProfileSetupController c) {
    return Column(
      children: [
        const Text("YOUR EXPERIENCE?", style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
        const SizedBox(height: 20),
        Obx(() => Column(children: [
          _optionCard(c, "Beginner", "New to gym (0-6 mo)", true),
          _optionCard(c, "Intermediate", "Regular (6mo - 2 yr)", true),
          _optionCard(c, "Advance", "Gymbro! (2+ yr)", true),
        ])),
      ],
    );
  }

  Widget _buildGoalPage(ProfileSetupController c) {
    return Column(
      children: [
        const Text("WHAT'S YOUR GOAL?", style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
        const SizedBox(height: 20),
        Obx(() => Column(children: [
          _optionCard(c, "Lose Weight", "Burn fat", false),
          _optionCard(c, "Build Muscle", "Gain mass", false),
          _optionCard(c, "Keep Fit", "Stay healthy", false),
        ])),
      ],
    );
  }


  Widget _buildReviewPage(ProfileSetupController c) {
    return Column(
      children: [
        const Text("SUMMARY", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        const Text("Check before we start", style: TextStyle(color: Colors.grey)),
        const SizedBox(height: 30),
        
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFF2C2C2E),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color(0xFF00F0FF).withOpacity(0.3)),
          ),
  
          child: Obx(() => Column(
            children: [
              _reviewItem("Gender", c.selectedGender.value),
              const Divider(color: Colors.grey),
              _reviewItem("Age", "${c.selectedAge.value} yo"),
              const Divider(color: Colors.grey),
              _reviewItem("Weight", "${c.selectedWeight.value.toInt()} kg"),
              const Divider(color: Colors.grey),
              _reviewItem("Height", "${c.selectedHeight.value.toInt()} cm"),
              const Divider(color: Colors.grey),
              // Karena ada Obx, pas kamu ganti Level, teks ini bakal berubah sendiri
              _reviewItem("Level", c.selectedLevel.value),
              const Divider(color: Colors.grey),
              // Pas kamu ganti Goal, teks ini juga bakal berubah sendiri
              _reviewItem("Goal", c.selectedGoal.value),
            ],
          )),
        ),
      ],
    );
  }

  Widget _reviewItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey, fontSize: 16)),
          Text(value, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
        ],
      ),
    );
  }


  Widget _genderCard(ProfileSetupController c, String gender, IconData icon) {
    bool isSelected = c.selectedGender.value == gender;
    return GestureDetector(
      onTap: () => c.selectedGender.value = gender,
      child: Container(
        width: 100, height: 100,
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF00F0FF) : const Color(0xFF2C2C2E),
          borderRadius: BorderRadius.circular(100),
        ),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(icon, size: 30, color: isSelected ? Colors.black : Colors.white),
          const SizedBox(height: 5),
          Text(gender, style: TextStyle(color: isSelected ? Colors.black : Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
        ]),
      ),
    );
  }


  Widget _optionCard(ProfileSetupController c, String value, String subtitle, bool isLevel) {
    bool isSelected = isLevel ? c.selectedLevel.value == value : c.selectedGoal.value == value;
    return GestureDetector(
      onTap: () {
       
        if (isLevel) {
          c.selectedLevel.value = value;
        } else {
          c.selectedGoal.value = value;
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF00F0FF) : const Color(0xFF2C2C2E),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(children: [
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(value, style: TextStyle(color: isSelected ? Colors.black : Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
            Text(subtitle, style: TextStyle(color: isSelected ? Colors.black87 : Colors.grey, fontSize: 12)),
          ])),
          if (isSelected) const Icon(Icons.check_circle, color: Colors.black, size: 20),
        ]),
      ),
    );
  }
}