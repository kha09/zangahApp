import 'package:flutter/material.dart';
import 'upload_dialog.dart';
import 'subject_card.dart';
import 'subject_details_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedTab = 0;
  String? selectedSubject;
  String? selectedSemester;
  List<Map<String, dynamic>> subjects = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: const Color(0xFF4A1E9E),
                  width: 2,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 20,
                    height: 2,
                    color: const Color(0xFF4666F6),
                    margin: const EdgeInsets.symmetric(vertical: 2),
                  ),
                  Container(
                    width: 15,
                    height: 2,
                    color: const Color(0xFF223CC7),
                    margin: const EdgeInsets.symmetric(vertical: 2),
                  ),
                  Container(
                    width: 18,
                    height: 2,
                    color: const Color(0xFF34C759),
                    margin: const EdgeInsets.symmetric(vertical: 2),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            const Text(
              "زنقه",
              style: TextStyle(
                fontSize: 24,
                color: Color(0xFF4A1E9E),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.menu,
              color: Color(0xFF4A1E9E),
              size: 28,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          // Segmented Control
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                color: const Color(0xFFF5F7FF),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => selectedTab = 0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: selectedTab == 0
                              ? const Color(0xFF4A1E9E)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Center(
                          child: Text(
                            "مكتبي",
                            style: TextStyle(
                              color: selectedTab == 0
                                  ? Colors.white
                                  : const Color(0xFF4A1E9E),
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => selectedTab = 1),
                      child: Container(
                        decoration: BoxDecoration(
                          color: selectedTab == 1
                              ? const Color(0xFF4A1E9E)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Center(
                          child: Text(
                            "الروزنامة",
                            style: TextStyle(
                              color: selectedTab == 1
                                  ? Colors.white
                                  : const Color(0xFF4A1E9E),
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                selectedTab == 0
                    ? selectedSubject != null
                        ? SubjectDetailsWidget(
                            subject: selectedSubject!,
                            semester: selectedSemester!,
                            onBack: () {
                              setState(() {
                                selectedSubject = null;
                                selectedSemester = null;
                              });
                            },
                          )
                        : subjects.isEmpty
                            ? Center(
                                child: Text(
                                  'لا يوجد مواد. اضغط على + لإضافة مادة',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              )
                            : SafeArea(
                                child: ListView.builder(
                                  padding: const EdgeInsets.all(16.0),
                                  itemCount: subjects.length,
                                  itemBuilder: (context, index) {
                                    final subject = subjects[index];
                                    return Padding(
                                      padding: const EdgeInsets.only(bottom: 16.0),
                                      child: SubjectCard(
                                        subject: subject['subject'] as String,
                                      semester: '',
                                        schedule: subject['hasSchedule'] == true ? 'جدول دراسي' : '',
                                        questions: subject['hasQuestions'] == true ? 'أسئلة' : '',
                                        onTap: (subjectName, semester) {
                                          setState(() {
                                            selectedSubject = subjectName;
                                            selectedSemester = '';
                                          });
                                        },
                                      ),
                                    );
                                  },
                                ),
                              )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/path_group.png',
                            width: 200,
                            height: 200,
                            fit: BoxFit.contain,
                          ),
                          const SizedBox(height: 32),
                          const Text(
                            "!أهلاً بالمزنوق",
                            style: TextStyle(
                              fontSize: 24,
                              color: Color(0xFF4A1E9E),
                              fontWeight: FontWeight.bold,
                            ),
                            textDirection: TextDirection.rtl,
                          ),
                          const SizedBox(height: 16),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 32),
                            child: Text(
                              "عشان تبدأ بالمذاكرة نحتاج منك ترفع لنا المنهج عن طريق الزر إلي بالأسفل",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                color: Color(0xFF4A1E9E),
                                height: 1.5,
                              ),
                              textDirection: TextDirection.rtl,
                            ),
                          ),
                        ],
                      ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await showDialog<Map<String, dynamic>>(
            context: context,
            builder: (context) => const UploadDialog(),
          );
          
          if (result != null) {
            setState(() {
              subjects.add({
                'subject': result['subject'],
                'filePath': result['filePath'],
                'fileName': result['fileName'],
                'hasSchedule': result['hasSchedule'],
                'hasQuestions': result['hasQuestions'],
                'hasSummary': result['hasSummary'],
              });
            });
          }
        },
        backgroundColor: const Color(0xFF4666F6),
        child: const Icon(Icons.add, size: 32),
      ),
    );
  }
}
