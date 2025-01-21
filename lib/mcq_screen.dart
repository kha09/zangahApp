import 'package:flutter/material.dart';

class MCQScreen extends StatefulWidget {
  const MCQScreen({Key? key}) : super(key: key);

  @override
  State<MCQScreen> createState() => _MCQScreenState();
}

class _MCQScreenState extends State<MCQScreen> {
  int? _selectedAnswer;
  int _currentIndex = 6; // 7th question (0-based index)

  final List<String> _answers = ['x = 6', 'x = -2', 'x = -4', 'x = 4'];
  final Map<int, Color> _questionStatus = {
    0: Colors.red,
    1: Colors.green,
    2: Colors.green,
    3: Colors.green,
    4: Colors.green,
    5: Colors.red,
    6: Colors.blue,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.grey),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Row(
                    children: [
                      const Text(
                        'زلفة',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.purple,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Icon(Icons.note_alt_outlined, color: Colors.purple[700]),
                    ],
                  ),
                ],
              ),
            ),

            // Subtitle
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'اسئلة : رياضيات - الفصل الأول',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[400],
                ),
                textAlign: TextAlign.right,
              ),
            ),

            // Question Numbers
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: List.generate(11, (index) {
                  final questionNumber = 11 - index;
                  final status = _questionStatus[10 - index];
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: status ?? Colors.grey,
                        width: 2,
                      ),
                      color: status != null ? status : Colors.transparent,
                    ),
                    child: Center(
                      child: Text(
                        '$questionNumber',
                        style: TextStyle(
                          color: status != null ? Colors.white : Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),

            // Question Card
            Card(
              margin: const EdgeInsets.all(16),
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'x+3=7',
                      style: TextStyle(
                        fontSize: 32,
                        color: Colors.blue[900],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'ما هي قيمة x ؟',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.blue[900],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Answer Options
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                padding: const EdgeInsets.all(16),
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 2,
                children: List.generate(
                  _answers.length,
                  (index) => GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedAnswer = index;
                      });
                    },
                    child: Card(
                      elevation: _selectedAnswer == index ? 8 : 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(
                          color: _selectedAnswer == index
                              ? Colors.blue
                              : Colors.transparent,
                          width: 2,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          _answers[index],
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.blue[900],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Next Button
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextButton.icon(
                onPressed: () {
                  // Handle next question
                },
                icon: const Icon(Icons.arrow_back, color: Colors.blue),
                label: const Text(
                  'التالي',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
