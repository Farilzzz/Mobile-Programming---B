import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:aplikasi_gym/controller/auth_controller.dart';
import 'package:aplikasi_gym/model/user_model.dart';

class WorkoutLogController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final AuthController authC = Get.find<AuthController>();

  var isLoading = false.obs;
  var logList = <Map<String, dynamic>>[].obs;

  
  final exerciseNameC = TextEditingController();
  final weightC = TextEditingController();
  final repsC = TextEditingController();
  final setsC = TextEditingController();

  @override
  void onInit() {
    fetchLogs(); 
    super.onInit();
  }

  
  void fetchLogs() {
    String uid = authC.currentUser.value?.uid ?? "";
    if (uid.isEmpty) return;

    _firestore.collection('users').doc(uid).collection('logs')
      .orderBy('created_at', descending: true) 
      .snapshots()
      .listen((snapshot) {
        logList.value = snapshot.docs.map((doc) => {
          'id': doc.id,
          ...doc.data()
        }).toList();
    });
  }


  Future<void> addLog({String? forcedName}) async {
    
    String name = forcedName ?? exerciseNameC.text;
    
    if (name.isEmpty || weightC.text.isEmpty || repsC.text.isEmpty || setsC.text.isEmpty) {
      Get.snackbar("Error", "Please fill all fields");
      return;
    }

    try {
      isLoading(true);
      String uid = authC.currentUser.value!.uid;

  
      await _firestore.collection('users').doc(uid).collection('logs').add({
        'exercise_name': name,
        'weight_kg': double.parse(weightC.text),
        'reps': int.parse(repsC.text),
        'sets': int.parse(setsC.text),
        'created_at': FieldValue.serverTimestamp(),
      });

     
      await _addXp(20); 

      _clearForm();
      if(forcedName == null) Get.back(); 
      
      Get.snackbar("Success", "Workout Logged! (+20 XP)", backgroundColor: Colors.green, colorText: Colors.white);

    } catch (e) {
      Get.snackbar("Error", "Failed to add log: $e");
    } finally {
      isLoading(false);
    }
  }

  Future<void> updateLog(String logId) async {
    try {
      isLoading(true);
      String uid = authC.currentUser.value!.uid;

      await _firestore.collection('users').doc(uid).collection('logs').doc(logId).update({
        'exercise_name': exerciseNameC.text,
        'weight_kg': double.parse(weightC.text),
        'reps': int.parse(repsC.text),
        'sets': int.parse(setsC.text),
      });

      Get.back(); 
      _clearForm();
      Get.snackbar("Success", "Log Updated!");
    } catch (e) {
      Get.snackbar("Error", "Failed to update: $e");
    } finally {
      isLoading(false);
    }
  }

 
  Future<void> deleteLog(String logId) async {
    try {
      String uid = authC.currentUser.value!.uid;
      await _firestore.collection('users').doc(uid).collection('logs').doc(logId).delete();
      Get.snackbar("Deleted", "Workout log removed");
    } catch (e) {
      Get.snackbar("Error", "Failed to delete");
    }
  }

 
  Future<void> _addXp(int amount) async {
    UserModel? user = authC.currentUser.value;
    if (user == null) return;

    int newXp = user.currentXp + amount;
    int newMax = user.maxXp;
    String newLevel = user.level;

  
    if (newXp >= newMax) {
      newXp = newXp - newMax; 
      newMax = (newMax * 1.5).toInt(); 
      
    
      if (user.level == 'Beginner') newLevel = 'Intermediate';
      else if (user.level == 'Intermediate') newLevel = 'Advance';
      
      Get.snackbar("LEVEL UP!", "You are now $newLevel!", 
        backgroundColor: Colors.amber, colorText: Colors.black, duration: const Duration(seconds: 4));
    }

    
    await _firestore.collection('users').doc(user.uid).update({
      'currentXp': newXp,
      'maxXp': newMax,
      'level': newLevel,
    });


    user.currentXp = newXp;
    user.maxXp = newMax;
    user.level = newLevel;
    authC.currentUser.refresh(); 
  }

  void _clearForm() {
    exerciseNameC.clear();
    weightC.clear();
    repsC.clear();
    setsC.clear();
  }
}