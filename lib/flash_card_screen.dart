import 'package:flutter/material.dart';
import 'services/api_service.dart';

class FlashCardScreen extends StatefulWidget {
  const FlashCardScreen({super.key});

  @override
  State<FlashCardScreen> createState() => _FlashCardScreenState();
}

class _FlashCardScreenState extends State<FlashCardScreen> {
  bool _isFlipped = false;
  int _currentIndex = 0;
  List<Map<String, String>> _flashcards = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadFlashcards();
  }

  Future<void> _loadFlashcards() async {
    try {
      final cards = await ApiService.getFlashcards();
      setState(() {
        _flashcards = cards;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('فشل تحميل البطاقات: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
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
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _flashcards.isEmpty
              ? Center(
                  child: Text(
                    'لا توجد بطاقات متاحة',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[600],
                    ),
                  ),
                )
              : Column(
                  children: [
                    const SizedBox(height: 16),

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
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(_flashcards.length, (index) {
                          final questionNumber = _flashcards.length - index;
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

                    // Flash Card
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _isFlipped = !_isFlipped;
                          });
                        },
                        child: TweenAnimationBuilder(
                          tween: Tween<double>(
                            begin: 0,
                            end: _isFlipped ? 180 : 0,
                          ),
                          duration: const Duration(milliseconds: 300),
                          builder: (context, double value, child) {
                            return Transform(
                              transform: Matrix4.identity()
                                ..setEntry(3, 2, 0.001)
                                ..rotateY(value * 3.1415927 / 180),
                              alignment: Alignment.center,
                              child: value < 90
                                  ? Card(
                                      margin: const EdgeInsets.all(32),
                                      elevation: 4,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: Container(
                                        padding: const EdgeInsets.all(24),
                                        alignment: Alignment.center,
                                        child: Text(
                                          _flashcards[_currentIndex]['question']!,
                                          style: TextStyle(
                                            fontSize: 24,
                                            color: Colors.blue[900],
                                            fontWeight: FontWeight.bold,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    )
                                  : Transform(
                                      transform: Matrix4.identity()..rotateY(3.1415927),
                                      alignment: Alignment.center,
                                      child: Card(
                                        margin: const EdgeInsets.all(32),
                                        elevation: 4,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(16),
                                        ),
                                        child: Container(
                                          padding: const EdgeInsets.all(24),
                                          alignment: Alignment.center,
                                          child: Text(
                                            _flashcards[_currentIndex]['answer']!,
                                            style: TextStyle(
                                              fontSize: 24,
                                              color: Colors.blue[900],
                                              fontWeight: FontWeight.bold,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    ),
                            );
                          },
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
                              onPressed: () {
                                setState(() {
                                  _currentIndex--;
                                  _isFlipped = false;
                                });
                              },
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
                          if (_currentIndex < _flashcards.length - 1)
                            TextButton.icon(
                              onPressed: () {
                                setState(() {
                                  _currentIndex++;
                                  _isFlipped = false;
                                });
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
