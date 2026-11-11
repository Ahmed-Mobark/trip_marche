import 'package:flutter/material.dart';

import 'help_article_view.dart';

/// Kept for callers that open FAQ directly; content comes from the Help Center API.
class FaqsView extends StatelessWidget {
  const FaqsView({super.key});

  @override
  Widget build(BuildContext context) => const HelpArticleView(slug: 'faq');
}
