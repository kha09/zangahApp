import 'package:flutter/material.dart';
import 'services/api_service.dart';
import 'models/mcq_model.dart';

class MCQScreen extends StatefulWidget {
  const MCQScreen({super.key});

  @override
  State<MCQScreen> createState() => _MCQScreenState();
}

class _MCQScreenState extends State<MCQScreen> {
  int _currentIndex = 0;
  List<MCQ> _mcqs = [];
  bool _isLoading = true;
  String? _selectedAnswer;
  bool _hasSubmitted = false;

  @override
  void initState() {
    super.initState();
    _loadMCQs();
  }

  Future<void> _loadMCQs() async {
    try {
      final mcqs = await ApiService.getMCQs();
      setState(() {
        _mcqs = mcqs;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('فشل تحميل الأسئلة: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _checkAnswer(String answer) {
    setState(() {
      _selectedAnswer = answer;
      _hasSubmitted = true;
    });
  }

  void _nextQuestion() {
    if (_currentIndex < _mcqs.length - 1) {
      setState(() {
        _currentIndex++;
        _selectedAnswer = null;
        _hasSubmitted = false;
      });
    }
  }

  void _previousQuestion() {
    if (_currentIndex > 0) {
      setState(() {
        _currentIndex--;
        _selectedAnswer = null;
        _hasSubmitted = false;
      });
    }
  }

  Color _getOptionColor(String option) {
    if (!_hasSubmitted) return Colors.white;
    
    if (option == _mcqs[_currentIndex].correctAnswer) {
      return Colors.green[100]!;
    }
    if (option == _selectedAnswer && option != _mcqs[_currentIndex].correctAnswer) {
      return Colors.red[100]!;
    }
    return Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF4A1E9E)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            Image.asset(
              'assets/images/mainpic.png',
              width: 40,
              height: 40,
              fit: BoxFit.contain,
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
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _mcqs.isEmpty
              ? Center(
                  child: Text(
                    'لا توجد أسئلة متاحة',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[600],
                    ),
                  ),
                )
              : Column(
                  children: [
                    const SizedBox(height: 16),

                    // Question Numbers
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(_mcqs.length, (index) {
                          final questionNumber = index + 1;
                          return Container(
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            width: 28,
                            height: 28,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: index == _currentIndex ? Colors.blue : Colors.grey,
                                width: 2,
                              ),
                              color: index == _currentIndex ? Colors.blue : Colors.transparent,
                            ),
                            child: Center(
                              child: Text(
                                '$questionNumber',
                                style: TextStyle(
                                  color: index == _currentIndex ? Colors.white : Colors.grey,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),

                    // Question Card
                    Expanded(
                      child: Card(
                        margin: const EdgeInsets.all(16),
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              // Question
                              Text(
                                _mcqs[_currentIndex].question,
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.blue[900],
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 24),
                              // Options
                              Expanded(
                                child: ListView.builder(
                                  itemCount: _mcqs[_currentIndex].options.length,
                                  itemBuilder: (context, index) {
                                    final option = _mcqs[_currentIndex].options.keys.elementAt(index);
                                    final optionText = _mcqs[_currentIndex].options[option]!;
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 8),
                                      child: InkWell(
                                        onTap: _hasSubmitted ? null : () => _checkAnswer(option),
                                        child: Container(
                                          padding: const EdgeInsets.all(16),
                                          decoration: BoxDecoration(
                                            color: _getOptionColor(option),
                                            border: Border.all(
                                              color: option == _selectedAnswer ? Colors.blue : Colors.grey[300]!,
                                              width: 2,
                                            ),
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          child: Row(
                                            children: [
                                              Container(
                                                width: 30,
                                                height: 30,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                    color: option == _selectedAnswer ? Colors.blue : Colors.grey[400]!,
                                                  ),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    option,
                                                    style: TextStyle(
                                                      color: option == _selectedAnswer ? Colors.blue : Colors.grey[600],
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 16),
                                              Expanded(
                                                child: Text(
                                                  optionText,
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.blue[900],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // Navigation Buttons
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (_currentIndex > 0)
                            TextButton.icon(
                              onPressed: _previousQuestion,
                              icon: const Icon(Icons.arrow_forward, color: Colors.blue),
                              label: const Text(
                                'السابق',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          else
                            const SizedBox.shrink(),
                          if (_currentIndex < _mcqs.length - 1)
                            TextButton.icon(
                              onPressed: _hasSubmitted ? _nextQuestion : null,
                              icon: const Icon(Icons.arrow_back, color: Colors.blue),
                              label: const Text(
                                'التالي',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          else
                            const SizedBox.shrink(),
                        ],
                      ),
                    ),
                  ],
                ),
    );
  }
}
