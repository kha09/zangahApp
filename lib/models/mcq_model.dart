class MCQ {
  final String question;
  final Map<String, String> options;
  final String correctAnswer;

  MCQ({
    required this.question,
    required this.options,
    required this.correctAnswer,
  });

  factory MCQ.fromJson(Map<String, dynamic> json) {
    return MCQ(
      question: json['question'] as String,
      options: Map<String, String>.from(json['options'] as Map),
      correctAnswer: json['correct_answer'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'question': question,
      'options': options,
      'correct_answer': correctAnswer,
    };
  }
}
