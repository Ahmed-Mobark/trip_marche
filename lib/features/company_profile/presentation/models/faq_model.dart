class FAQModel {
  const FAQModel({
    required this.question,
    required this.answer,
    this.isExpanded = false,
  });

  final String question;
  final String answer;
  final bool isExpanded;
}
