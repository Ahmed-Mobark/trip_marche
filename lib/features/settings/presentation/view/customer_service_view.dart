import 'package:flutter/material.dart';

import 'help_article_view.dart';

/// Contact details are managed through the Help Center instead of app constants.
class CustomerServiceView extends StatelessWidget {
  const CustomerServiceView({super.key});

  @override
  Widget build(BuildContext context) =>
      const HelpArticleView(slug: 'contact-us');
}
