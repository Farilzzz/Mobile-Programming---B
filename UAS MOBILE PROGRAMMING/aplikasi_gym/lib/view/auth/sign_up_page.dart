import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:aplikasi_gym/controller/auth_controller.dart';
import 'package:aplikasi_gym/widgets/custom_textfield.dart';
import 'package:aplikasi_gym/widgets/custom_button.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authC = Get.find<AuthController>(); 

    return Scaffold(
      backgroundColor: const Color(0xFF1C1C1E),
      body: Stack(
        children: [
          // 1. BACKGROUND GAMBAR
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/sign_up.png'), 
                fit: BoxFit.cover,
              ),
            ),
          ),
          
          // 2. OVERLAY GELAP
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.black.withOpacity(0.4), const Color(0xFF1C1C1E)],
              ),
            ),
          ),

          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    
                    const Text("JOIN THE CLUB,",
                      style: TextStyle(fontSize: 32, fontWeight: FontWeight.w900, color: Colors.white)),
                    const Text("Start your journey now!",
                      style: TextStyle(fontSize: 16, color: Colors.white70)),
                    
                    const SizedBox(height: 40),

                    // FIELD NAMA LENGKAP
                    CustomTextField(
                      controller: authC.nameC,
                      hintText: "Full Name",
                      icon: Icons.person_outline,
                    ),

                    // FIELD EMAIL
                    CustomTextField(
                      controller: authC.emailC,
                      hintText: "Email",
                      keyboardType: TextInputType.emailAddress,
                      icon: Icons.email_outlined,
                    ),

                    // FIELD PASSWORD
                    Obx(() => CustomTextField(
                      controller: authC.passwordC,
                      hintText: "Password",
                      icon: Icons.lock_outline,
                      isObscure: authC.isPasswordHidden.value,
                      suffixIcon: IconButton(
                        icon: Icon(
                          authC.isPasswordHidden.value ? Icons.visibility_off : Icons.visibility,
                          color: Colors.grey,
                        ),
                        onPressed: () => authC.isPasswordHidden.toggle(),
                      ),
                    )),

                    const SizedBox(height: 30),

                    // TOMBOL SIGN UP
                    Obx(() => CustomButton(
                      text: "Sign Up",
                      onPressed: () => authC.signUp(),
                      isLoading: authC.isLoading.value,
                      color: const Color(0xFF00F0FF),
                      textColor: Colors.black,
                    )),

                    const SizedBox(height: 40),

                    // Link Sign In
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Already have an account? ", style: TextStyle(color: Colors.grey)),
                        GestureDetector(
                          onTap: () => Get.back(),
                          child: const Text("Sign In", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}