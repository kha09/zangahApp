import 'package:flutter/material.dart';
import 'models/summary_model.dart';

class SummaryScreen extends StatefulWidget {
  final List<SummaryCard> summaryCards;

  const SummaryScreen({
    super.key,
    required this.summaryCards,
  });

  @override
  State<SummaryScreen> createState() => _SummaryScreenState();
}

class _SummaryScreenState extends State<SummaryScreen> {
  int _currentIndex = 0;

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
      body: Column(
        children: [
          const SizedBox(height: 16),

          // Subtitle
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'الملخص',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blue[400],
              ),
              textAlign: TextAlign.right,
            ),
          ),

          // Card Numbers
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(widget.summaryCards.length, (index) {
                final cardNumber = widget.summaryCards.length - index;
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
                      '$cardNumber',
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

          // Summary Card
          Expanded(
            child: Card(
              margin: const EdgeInsets.all(32),
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Container(
                padding: const EdgeInsets.all(24),
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.summaryCards[_currentIndex].title,
                      style: TextStyle(
                        fontSize: 32,
                        color: Colors.blue[900],
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Text(
                          widget.summaryCards[_currentIndex].content,
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.blue[900],
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Next Button
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
                  ),
                if (_currentIndex < widget.summaryCards.length - 1)
                  TextButton.icon(
                    onPressed: () {
                      setState(() {
                        _currentIndex++;
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
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
