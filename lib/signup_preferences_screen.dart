import 'package:flutter/material.dart';
import 'signin_screen.dart';

class SignUpPreferencesScreen extends StatefulWidget {
  const SignUpPreferencesScreen({super.key});

  @override
  State<SignUpPreferencesScreen> createState() => _SignUpPreferencesScreenState();
}

class _SignUpPreferencesScreenState extends State<SignUpPreferencesScreen> {
  final Map<String, bool> goals = {
    'تلحق تختم': false,
    'تنظم وقتك': false,
    'تقوي مذاكرتك': false,
  };

  final Map<String, bool> studyPreferences = {
    'استخدم ألوان كثير': false,
    'قلم / لون واحد يكفي': false,
    'أفضل القراءة': false,
    'أفضل الاستماع / المشاهدة': false,
    'أذاكر لساعات طويلة': false,
    'أذاكر على أوقات متفرقة': false,
  };

  final Map<String, bool> challengingSubjects = {
    'رياضيات': false,
    'علوم طبيعية و تطبيقية': false,
    'اللغة الإنجليزية': false,
    'الحاسب / البرمجة': false,
    'أخرى': false,
  };

  String otherSubject = '';

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
                
                // Goals Section
                _buildSectionTitle("ايش هدفك؟", "حدد جميع أهدافك"),
                ...goals.entries.map((entry) => _buildCheckboxItem(
                  entry.key,
                  entry.value,
                  (value) => setState(() => goals[entry.key] = value!),
                )),
                const SizedBox(height: 24),

                // Study Preferences Section
                _buildSectionTitle("كيف تحب تذاكر؟", "حدد جميع تفضيلاتك"),
                ...studyPreferences.entries.map((entry) => _buildCheckboxItem(
                  entry.key,
                  entry.value,
                  (value) => setState(() => studyPreferences[entry.key] = value!),
                )),
                const SizedBox(height: 24),

                // Challenging Subjects Section
                _buildSectionTitle("ايش المواد اللي تعاني منها؟", "حدد احتياجك"),
                ...challengingSubjects.entries.map((entry) {
                  if (entry.key == 'أخرى') {
                    return Column(
                      children: [
                        _buildCheckboxItem(
                          entry.key,
                          entry.value,
                          (value) => setState(() => challengingSubjects[entry.key] = value!),
                        ),
                        if (challengingSubjects['أخرى']!)
                          Padding(
                            padding: const EdgeInsets.only(right: 32.0),
                            child: TextField(
                              textDirection: TextDirection.rtl,
                              textAlign: TextAlign.right,
                              decoration: const InputDecoration(
                                hintText: 'اكتب المادة هنا',
                                hintTextDirection: TextDirection.rtl,
                              ),
                              onChanged: (value) => setState(() => otherSubject = value),
                            ),
                          ),
                      ],
                    );
                  }
                  return _buildCheckboxItem(
                    entry.key,
                    entry.value,
                    (value) => setState(() => challengingSubjects[entry.key] = value!),
                  );
                }),
                const SizedBox(height: 40),

                // Start Studying Button
                Center(
                  child: TextButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignInScreen(),
                        ),
                      );
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: const Color(0xFF223CC7),
                    ),
                    icon: const Icon(Icons.arrow_back),
                    label: const Text(
                      "نبدأ مذاكرة",
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

  Widget _buildSectionTitle(String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              color: Color(0xFF4A1E9E),
              fontWeight: FontWeight.bold,
            ),
            textDirection: TextDirection.rtl,
          ),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 14,
              color: const Color(0xFF4A1E9E).withOpacity(0.7),
            ),
            textDirection: TextDirection.rtl,
          ),
        ],
      ),
    );
  }

  Widget _buildCheckboxItem(String label, bool value, Function(bool?) onChanged) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: CheckboxListTile(
        title: Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black87,
          ),
        ),
        value: value,
        onChanged: onChanged,
        controlAffinity: ListTileControlAffinity.leading,
        contentPadding: EdgeInsets.zero,
        activeColor: const Color(0xFF4A1E9E),
      ),
    );
  }
}
