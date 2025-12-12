import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:aplikasi_gym/view/auth/profile_setup_page.dart';
import 'package:aplikasi_gym/view/home/home_page.dart'; 
import 'package:aplikasi_gym/view/auth/login_page.dart'; 
import 'package:aplikasi_gym/model/user_model.dart';

class AuthController extends GetxController {
  
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  var isLoading = false.obs;
  var isPasswordHidden = true.obs;
  Rx<UserModel?> currentUser = Rx<UserModel?>(null); 
  
  TextEditingController emailC = TextEditingController();
  TextEditingController passwordC = TextEditingController();
  TextEditingController nameC = TextEditingController();



  void checkLoginStatus() async {
    User? user = _auth.currentUser;

    if (user == null) {

      Get.offAll(() => const LoginPage());
    } else {
      
      try {
        DocumentSnapshot doc = await _firestore.collection('users').doc(user.uid).get();
        if (doc.exists) {
           final userModel = UserModel.fromDocumentSnapshot(doc);
           currentUser.value = userModel; 

           if (userModel.profileSetupComplete == true) {
             Get.offAll(() => const HomePage());
           } else {
             Get.offAll(() => const ProfileSetupPage());
           }
        } else {
        
          Get.offAll(() => const ProfileSetupPage());
        }
      } catch (e) {
        
        Get.offAll(() => const LoginPage());
      }
    }
  }

 

  Future<void> signUp() async {
    isLoading(true);
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: emailC.text,
        password: passwordC.text,
      );
      
      UserModel newUser = UserModel(
        uid: userCredential.user!.uid,
        email: emailC.text,
        fullName: nameC.text,
        gender: 'male', age: 0, height: 0.0, weight: 0.0,
        goal: 'maintain_weight', profileSetupComplete: false,
        level: 'Beginner',
      );
      
      await _firestore.collection('users').doc(newUser.uid).set(newUser.toJson());
      
     
      checkLoginStatus(); 

    } on FirebaseAuthException catch (e) {
      Get.snackbar("Gagal Sign Up", e.message ?? "Terjadi kesalahan.");
    } finally {
      isLoading(false);
    }
  }

  Future<void> login() async {
    isLoading(true);
    try {
      await _auth.signInWithEmailAndPassword(
        email: emailC.text,
        password: passwordC.text,
      );
      emailC.clear();
      passwordC.clear();
      
      
      checkLoginStatus();

    } on FirebaseAuthException catch (e) {
      Get.snackbar("Gagal Login", e.message ?? "Email/Password salah.");
    } finally {
      isLoading(false);
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
    currentUser.value = null; 
    Get.offAll(() => const LoginPage()); 
  }

  @override
  void onClose() {
    emailC.dispose();
    passwordC.dispose();
    nameC.dispose();
    super.onClose();
  }
}