import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:aplikasi_gym/controller/auth_controller.dart';
import 'package:aplikasi_gym/view/auth/sign_up_page.dart';
import 'package:aplikasi_gym/widgets/custom_textfield.dart';
import 'package:aplikasi_gym/widgets/custom_button.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authC = Get.put(AuthController());

    
    return Scaffold(
      
      backgroundColor: Colors.black, 
      body: Stack(
        children: [
   
          Positioned.fill(
            child: Image.asset(
              'assets/images/login.png', 
              fit: BoxFit.cover, 
            ),
          ),

          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.4), 
                    Colors.black.withOpacity(0.8), 
                  ],
                ),
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
                    // --- Header Teks ---
                    const Text(
                      "WELCOME BACK,",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        letterSpacing: 1.0,
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      "Sign in to continue your journey",
                      style: TextStyle(fontSize: 16, color: Colors.white70),
                    ),

                    const SizedBox(height: 40),

            
                    CustomTextField(
                      controller: authC.emailC,
                      hintText: "Email",
                      icon: Icons.email_outlined,
                    ),

                    Obx(() => CustomTextField(
                      controller: authC.passwordC,
                      hintText: "Password",
                      icon: Icons.lock_outline,
                      isObscure: authC.isPasswordHidden.value,
                      suffixIcon: IconButton(
                        icon: Icon(
                          authC.isPasswordHidden.value
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.grey,
                        ),
                        onPressed: () => authC.isPasswordHidden.toggle(),
                      ),
                    )),

                    // --- Forgot Password ---
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: const Text(
                          "Forgot Password?",
                          style: TextStyle(color: Colors.white70),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // --- Tombol Sign In ---
                    Obx(() => CustomButton(
                      text: "Sign In",
                      onPressed: () => authC.login(),
                      isLoading: authC.isLoading.value,
                      // Menggunakan warna Cyan seperti desain referensi
                      color: const Color(0xFF00F0FF), 
                      textColor: Colors.black, // Teks hitam agar kontras dengan Cyan
                    )),

                    const SizedBox(height: 30),

                    // --- Social Media Icons ---
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.g_mobiledata, color: Colors.white, size: 40),
                        SizedBox(width: 20),
                        Icon(Icons.apple, color: Colors.white, size: 40),
                        SizedBox(width: 20),
                        Icon(Icons.facebook, color: Colors.white, size: 40),
                      ],
                    ),

                    const SizedBox(height: 40),

                    // --- Link ke Sign Up ---
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't have an account? ",
                          style: TextStyle(color: Colors.white70),
                        ),
                        GestureDetector(
                          onTap: () => Get.to(() => const SignUpPage()),
                          child: const Text(
                            "Sign Up",
                            style: TextStyle(
                              color: Color(0xFF00F0FF), // Warna Cyan juga
                              fontWeight: FontWeight.bold,
                            ),
                          ),
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