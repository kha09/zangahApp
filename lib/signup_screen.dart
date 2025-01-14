import 'package:flutter/material.dart';
import 'signup_education_screen.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Logo and arrow
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.arrow_forward,
                        color: Color(0xFF223CC7),
                        size: 24,
                      ),
                    ),
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: const Color(0xFF4A1E9E),
                          width: 2,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 30,
                            height: 2,
                            color: const Color(0xFF4666F6),
                            margin: const EdgeInsets.symmetric(vertical: 2),
                          ),
                          Container(
                            width: 20,
                            height: 2,
                            color: const Color(0xFF223CC7),
                            margin: const EdgeInsets.symmetric(vertical: 2),
                          ),
                          Container(
                            width: 25,
                            height: 2,
                            color: const Color(0xFF34C759),
                            margin: const EdgeInsets.symmetric(vertical: 2),
                          ),
                          Container(
                            width: 15,
                            height: 2,
                            color: const Color(0xFF34C759),
                            margin: const EdgeInsets.symmetric(vertical: 2),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                // Title
                const Text(
                  "إنشاء حساب جديد",
                  style: TextStyle(
                    fontSize: 28,
                    color: Color(0xFF223CC7),
                    fontWeight: FontWeight.bold,
                  ),
                  textDirection: TextDirection.rtl,
                ),
                const SizedBox(height: 40),
                // Form fields
                _buildTextField("الاسم", "نص وهمي"),
                const SizedBox(height: 16),
                _buildTextField("البريد الإلكتروني", "نص وهمي"),
                const SizedBox(height: 16),
                _buildTextField("تاريخ الميلاد", "نص وهمي"),
                const SizedBox(height: 16),
                _buildTextField("كلمة المرور", "نص وهمي", isPassword: true),
                const SizedBox(height: 16),
                _buildTextField("تأكيد كلمة المرور", "نص وهمي", isPassword: true),
                const SizedBox(height: 24),
                // Login link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                    onPressed: () {},
                      child: const Text(
                        "تسجيل الدخول",
                        style: TextStyle(
                          color: Color(0xFF34C759),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Text(
                      "لديك حساب بالفعل؟ قم",
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                      textDirection: TextDirection.rtl,
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                // Next button
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignUpEducationScreen(),
                        ),
                      );
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: const Color(0xFF223CC7),
                    ),
                    icon: const Icon(Icons.arrow_back),
                    label: const Text(
                      "التالي",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, String placeholder, {bool isPassword = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            color: Color(0xFF223CC7),
            fontWeight: FontWeight.bold,
          ),
          textDirection: TextDirection.rtl,
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFF5F7FF),
            borderRadius: BorderRadius.circular(12),
          ),
          child: TextField(
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.right,
            obscureText: isPassword,
            decoration: InputDecoration(
              hintText: placeholder,
              hintStyle: const TextStyle(
                color: Colors.grey,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
