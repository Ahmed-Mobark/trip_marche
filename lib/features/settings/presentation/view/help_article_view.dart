import 'package:flutter/material.dart';
import 'package:trip_marche/core/extensions/localization.dart';
import 'package:trip_marche/core/injection/injection_container.dart';
import 'package:trip_marche/core/navigation/app_navigator.dart';
import 'package:trip_marche/core/theme/app_colors.dart';
import 'package:trip_marche/core/theme/app_text_styles.dart';
import 'package:trip_marche/features/chat/presentation/view/conversations_view.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../domain/entities/help_page.dart';
import '../../domain/repositories/help_center_repository.dart';

class HelpArticleView extends StatefulWidget {
  const HelpArticleView({super.key, required this.slug, this.title});

  final String slug;
  final String? title;

  @override
  State<HelpArticleView> createState() => _HelpArticleViewState();
}

class _HelpArticleViewState extends State<HelpArticleView> {
  late final Future<HelpPage> _page;

  @override
  void initState() {
    super.initState();
    _page = sl<HelpCenterRepository>().page(widget.slug);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background(context),
      appBar: AppBar(
        backgroundColor: AppColors.background(context),
        title: Text(
          widget.title ?? context.tr.helpCenterTitle,
          style: AppTextStyles.subtitle(),
        ),
      ),
      body: FutureBuilder<HelpPage>(
        future: _page,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData) {
            return Center(child: Text(context.tr.helpCenterEmpty));
          }
          final page = snapshot.data!;
          final showSupport =
              widget.slug == 'share-feedback' || widget.slug == 'contact-us';
          final dark = Theme.of(context).brightness == Brightness.dark;
          return Column(
            children: [
              Expanded(
                child: _HelpHtml(
                  key: ValueKey(
                    '${page.slug}-${Localizations.localeOf(context).languageCode}-$dark',
                  ),
                  body: page.body,
                  direction:
                      Localizations.localeOf(context).languageCode == 'ar'
                      ? 'rtl'
                      : 'ltr',
                  dark: dark,
                ),
              ),
              if (showSupport)
                SafeArea(
                  top: false,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
                    child: SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: () => sl<AppNavigator>().push(
                          screen: const ConversationsView(startSupport: true),
                        ),
                        child: Text(
                          widget.slug == 'share-feedback'
                              ? context.tr.helpCenterSendFeedback
                              : context.tr.helpCenterContactSupport,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

class _HelpHtml extends StatefulWidget {
  const _HelpHtml({
    super.key,
    required this.body,
    required this.direction,
    required this.dark,
  });

  final String body;
  final String direction;
  final bool dark;

  @override
  State<_HelpHtml> createState() => _HelpHtmlState();
}

class _HelpHtmlState extends State<_HelpHtml> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.disabled)
      ..setBackgroundColor(widget.dark ? const Color(0xFF101827) : Colors.white)
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (request) {
            final uri = Uri.tryParse(request.url);
            if (uri != null &&
                ['https', 'http', 'mailto', 'tel'].contains(uri.scheme)) {
              launchUrl(uri, mode: LaunchMode.externalApplication);
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadHtmlString(
        '''<!doctype html><html dir="${widget.direction}"><head><meta name="viewport" content="width=device-width, initial-scale=1"><style>body{font:16px/1.8 system-ui,sans-serif;color:${widget.dark ? '#e2e8f0' : '#334155'};background:${widget.dark ? '#101827' : '#ffffff'};padding:16px}a{color:${widget.dark ? '#c084fc' : '#7e22ce'}}img{max-width:100%;height:auto}</style></head><body>${widget.body}</body></html>''',
      );
  }

  @override
  Widget build(BuildContext context) => WebViewWidget(controller: _controller);
}
