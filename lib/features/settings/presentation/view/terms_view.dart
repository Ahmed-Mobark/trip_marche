import 'package:flutter/material.dart';

import 'help_article_view.dart';

/// Customer terms are separate from the partner terms in the admin Help Center.
class TermsView extends StatelessWidget {
  const TermsView({super.key});

  @override
  Widget build(BuildContext context) =>
      const HelpArticleView(slug: 'terms-and-conditions');
}
