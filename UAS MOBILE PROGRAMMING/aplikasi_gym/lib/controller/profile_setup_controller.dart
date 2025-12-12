import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:aplikasi_gym/controller/auth_controller.dart'; 
import 'package:aplikasi_gym/model/user_model.dart';
import 'package:aplikasi_gym/view/home/home_page.dart';

class ProfileSetupController extends GetxController {
  
  final AuthController authC = Get.find<AuthController>();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  final PageController pageController = PageController();
  var pageIndex = 0.obs;
  var isLoading = false.obs;

 
  var selectedGender = 'Male'.obs; 
  var selectedAge = 25.obs; 
  
  
  var selectedHeight = 170.0.obs; 
  var selectedWeight = 60.0.obs;  
  
  var selectedGoal = 'Keep Fit'.obs; 
  var selectedLevel = 'Beginner'.obs; 

  @override
  void onInit() {
    if (authC.currentUser.value != null) {
      final user = authC.currentUser.value!;
      
     
      selectedHeight.value = (user.height >= 100) ? user.height : 170.0;
      selectedWeight.value = (user.weight >= 30) ? user.weight : 60.0;
      selectedAge.value = user.age > 0 ? user.age : 25;
      
     
      String dbGoal = user.goal; 
      if (dbGoal.contains('lose')) {
        selectedGoal.value = "Lose Weight";
      } else if (dbGoal.contains('build') || dbGoal.contains('muscle')) {
        selectedGoal.value = "Build Muscle";
      } else {
        selectedGoal.value = "Keep Fit";
      }
      
      selectedLevel.value = user.level.isNotEmpty ? user.level : 'Beginner';
      selectedGender.value = user.gender.isNotEmpty ? user.gender.capitalizeFirst! : 'Male';
    }
    super.onInit();
  }
  
  void nextPage() {
    if (pageIndex.value < 6) { 
      pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
      pageIndex.value++; 
    } else {
      completeProfileSetup();
    }
  }

  void previousPage() {
    if (pageIndex.value > 0) {
      pageController.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
      pageIndex.value--;
    }
  }

  Future<void> completeProfileSetup() async {
    if (authC.currentUser.value == null) return;
    isLoading(true);

    try {
      final oldUser = authC.currentUser.value!;
      final uid = oldUser.uid;
      
     
      final dbGender = selectedGender.value.toLowerCase();
      String dbGoal = "maintain_weight";
      
      if (selectedGoal.value == "Lose Weight") dbGoal = "lose_weight";
      if (selectedGoal.value == "Build Muscle") dbGoal = "build_muscle";
      if (selectedGoal.value == "Keep Fit") dbGoal = "maintain_weight";

      final updateData = {
        'age': selectedAge.value,
        'height': selectedHeight.value,
        'weight': selectedWeight.value,
        'gender': dbGender,
        'goal': dbGoal,
        'level': selectedLevel.value,
        'profileSetupComplete': true, 
      };

      await _firestore.collection('users').doc(uid).update(updateData);
      
      final updatedUserModel = UserModel(
        uid: uid,
        email: oldUser.email,
        fullName: oldUser.fullName,
        profileSetupComplete: true, 
        age: selectedAge.value,
        height: selectedHeight.value,
        weight: selectedWeight.value,
        gender: dbGender,
        goal: dbGoal,
        level: selectedLevel.value,
      );
      
      authC.currentUser.value = updatedUserModel; 
      Get.offAll(() => const HomePage()); 

    } catch (e) {
      Get.snackbar("Gagal", "Error: ${e.toString()}");
    } finally {
      isLoading(false);
    }
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}