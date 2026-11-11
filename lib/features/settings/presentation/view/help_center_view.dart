import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:trip_marche/core/extensions/localization.dart';
import 'package:trip_marche/core/injection/injection_container.dart';
import 'package:trip_marche/core/navigation/app_navigator.dart';
import 'package:trip_marche/core/theme/app_colors.dart';
import 'package:trip_marche/core/theme/app_text_styles.dart';

import '../../domain/entities/help_page.dart';
import '../../domain/repositories/help_center_repository.dart';
import 'help_article_view.dart';

class HelpCenterView extends StatefulWidget {
  const HelpCenterView({super.key});

  @override
  State<HelpCenterView> createState() => _HelpCenterViewState();
}

class _HelpCenterViewState extends State<HelpCenterView> {
  static const _customerSlugs = [
    'faq',
    'terms-and-conditions',
    'privacy-policy',
    'share-feedback',
    'contact-us',
    'about-us',
  ];

  late Future<List<HelpPage>> _pages;

  @override
  void initState() {
    super.initState();
    _reload();
  }

  void _reload() {
    _pages = sl<HelpCenterRepository>().pages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background(context),
      appBar: AppBar(
        backgroundColor: AppColors.background(context),
        title: Text(
          context.tr.helpCenterTitle,
          style: AppTextStyles.subtitle(),
        ),
      ),
      body: FutureBuilder<List<HelpPage>>(
        future: _pages,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: TextButton(
                onPressed: () => setState(_reload),
                child: Text(context.tr.helpCenterRetry),
              ),
            );
          }

          final bySlug = {
            for (final page in snapshot.data ?? <HelpPage>[]) page.slug: page,
          };
          final visible = [
            for (final slug in _customerSlugs)
              if (bySlug[slug] case final HelpPage page) page,
          ];
          if (visible.isEmpty) {
            return Center(child: Text(context.tr.helpCenterEmpty));
          }

          return ListView.separated(
            padding: const EdgeInsets.all(20),
            itemCount: visible.length,
            separatorBuilder: (_, __) => const SizedBox(height: 10),
            itemBuilder: (context, index) {
              final page = visible[index];
              return Material(
                color: AppColors.background(context),
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: AppColors.border(context)),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  leading: Icon(_icon(page.slug), color: AppColors.primary),
                  title: Text(page.title, style: AppTextStyles.bodyMedium()),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => sl<AppNavigator>().push(
                    screen: HelpArticleView(slug: page.slug, title: page.title),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  IconData _icon(String slug) => switch (slug) {
    'faq' => Iconsax.message_question,
    'terms-and-conditions' => Iconsax.task,
    'privacy-policy' => Iconsax.shield_tick,
    'share-feedback' => Iconsax.message_edit,
    'contact-us' => Iconsax.headphone,
    _ => Iconsax.info_circle,
  };
}
