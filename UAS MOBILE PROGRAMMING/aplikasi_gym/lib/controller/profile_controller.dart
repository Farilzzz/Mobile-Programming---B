import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:aplikasi_gym/view/auth/login_page.dart'; 

class ProfileController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  var isLoading = false.obs;

  
  var username = "Gym Bro".obs;
  var email = "".obs;
  var level = "Beginner".obs;
  var height = 170.0.obs;
  var weight = 60.0.obs;
  var age = 20.obs;
  var goal = "Keep Fit".obs; 
  var gender = "Male".obs;

 
  final nameC = TextEditingController();
  final ageC = TextEditingController();
  final heightC = TextEditingController();
  final weightC = TextEditingController();

 
  var tempGender = "Male".obs;
  var tempGoal = "Keep Fit".obs;

  @override
  void onInit() {
    super.onInit();
    fetchProfile();
  }


  void fetchProfile() async {
    User? user = _auth.currentUser;
    if (user != null) {
      isLoading.value = true;
      try {
        var doc = await _firestore.collection('users').doc(user.uid).get();
        if (doc.exists) {
          var data = doc.data()!;
          username.value = data['fullName'] ?? "Gym Bro";
          email.value = data['email'] ?? "";
          level.value = data['level'] ?? "Beginner";
          
       
          String dbGoal = data['goal'] ?? "maintain_weight";
          if (dbGoal.contains('lose')) goal.value = "Lose Weight";
          else if (dbGoal.contains('build')) goal.value = "Build Muscle";
          else goal.value = "Keep Fit";

      
          String dbGender = data['gender'] ?? "male";
          gender.value = dbGender.toLowerCase() == "female" ? "Female" : "Male";
          
        
          height.value = (data['height'] ?? 170).toDouble();
          weight.value = (data['weight'] ?? 60).toDouble();
          age.value = (data['age'] ?? 20).toInt();
        }
      } catch (e) {
        print("Error fetch: $e");
      } finally {
        isLoading.value = false;
      }
    }
  }


  void showEditSheet() {
    
    nameC.text = username.value;
    ageC.text = age.value.toString();
    heightC.text = height.value.toStringAsFixed(0);
    weightC.text = weight.value.toStringAsFixed(0);
    
   
    tempGender.value = gender.value;
    tempGoal.value = goal.value;

    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Color(0xFF1C1C1E),
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
      
        child: Obx(() => SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(child: Text("Edit Profile", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold))),
              const SizedBox(height: 20),
              
              _label("Full Name"),
              _inputField(nameC),
              
              const SizedBox(height: 15),
              Row(children: [
                Expanded(child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start, 
                  children: [_label("Age"), _inputField(ageC, isNumber: true)]
                )),
                const SizedBox(width: 10),
                Expanded(child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start, 
                  children: [_label("Height (cm)"), _inputField(heightC, isNumber: true)]
                )),
                const SizedBox(width: 10),
                Expanded(child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start, 
                  children: [_label("Weight (kg)"), _inputField(weightC, isNumber: true)]
                )),
              ]),

              const SizedBox(height: 15),
              
           
              _label("Gender"),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(color: const Color(0xFF2C2C2E), borderRadius: BorderRadius.circular(10)),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: tempGender.value, 
                    dropdownColor: const Color(0xFF2C2C2E),
                    isExpanded: true,
                    items: ["Male", "Female"].map((String val) {
                      return DropdownMenuItem(value: val, child: Text(val, style: const TextStyle(color: Colors.white)));
                    }).toList(),
                    onChanged: (val) {
                      if (val != null) tempGender.value = val; 
                    },
                  ),
                ),
              ),

              const SizedBox(height: 15),

      
              _label("Goal"),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(color: const Color(0xFF2C2C2E), borderRadius: BorderRadius.circular(10)),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: tempGoal.value, 
                    dropdownColor: const Color(0xFF2C2C2E),
                    isExpanded: true,
                    items: ["Lose Weight", "Build Muscle", "Keep Fit"].map((String val) {
                      return DropdownMenuItem(value: val, child: Text(val, style: const TextStyle(color: Colors.white)));
                    }).toList(),
                    onChanged: (val) {
                      if (val != null) tempGoal.value = val; 
                    },
                  ),
                ),
              ),

              const SizedBox(height: 25),
              
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF00F0FF)),
                  onPressed: () => saveProfile(),
                  child: const Text("Save Changes", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                ),
              ),
              
              Padding(
                 padding: EdgeInsets.only(bottom: MediaQuery.of(Get.context!).viewInsets.bottom)
              ),
            ],
          ),
        )),
      ),
      isScrollControlled: true,
    );
  }

  Widget _label(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5, left: 2),
      child: Text(text, style: const TextStyle(color: Colors.grey, fontSize: 12)),
    );
  }

  Widget _inputField(TextEditingController c, {bool isNumber = false}) {
    return TextField(
      controller: c,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xFF2C2C2E),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
        contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      ),
    );
  }

  void saveProfile() async {
  
    FocusManager.instance.primaryFocus?.unfocus();

    User? user = _auth.currentUser;
    if (user != null) {
      Get.back(); 
      
      isLoading.value = true; 
      try {
        
        String newName = nameC.text;
        int newAge = int.tryParse(ageC.text) ?? age.value;
        double newHeight = double.tryParse(heightC.text) ?? height.value;
        double newWeight = double.tryParse(weightC.text) ?? weight.value;
        
        
        String dbGender = tempGender.value.toLowerCase();
        String dbGoal = "maintain_weight";
        if (tempGoal.value == "Lose Weight") dbGoal = "lose_weight";
        else if (tempGoal.value == "Build Muscle") dbGoal = "build_muscle";

    
        await _firestore.collection('users').doc(user.uid).update({
          'fullName': newName,
          'age': newAge,
          'height': newHeight,
          'weight': newWeight,
          'gender': dbGender,
          'goal': dbGoal,
        });

       
        username.value = newName;
        age.value = newAge;
        height.value = newHeight;
        weight.value = newWeight;
        gender.value = tempGender.value;
        goal.value = tempGoal.value;

        Get.snackbar("Success", "Profile updated!", backgroundColor: Colors.green, colorText: Colors.white);
      } catch (e) {
        Get.snackbar("Error", "Gagal update profile: $e", backgroundColor: Colors.redAccent, colorText: Colors.white);
        print(e);
      } finally {
        isLoading.value = false;
      }
    }
  }


  void logout() async {
    try {
      await _auth.signOut();
    
      Get.offAll(() => const LoginPage()); 
    } catch (e) {
      Get.snackbar("Error", "Logout gagal: $e");
    }
  }
}