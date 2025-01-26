class SummaryCard {
  final String title;
  final String content;

  SummaryCard({
    required this.title,
    required this.content,
  });

  factory SummaryCard.fromJson(Map<String, dynamic> json) {
    return SummaryCard(
      title: json['title'] as String,
      content: json['content'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'content': content,
    };
  }
}
