import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trip_marche/core/extensions/localization.dart';
import 'package:trip_marche/core/theme/app_colors.dart';
import 'package:trip_marche/core/theme/app_text_styles.dart';
import 'package:webview_flutter/webview_flutter.dart';

/// Full-screen in-app browser for a single URL (partner portal, policies, etc.).
class AppWebViewScreen extends StatefulWidget {
  const AppWebViewScreen({
    super.key,
    required this.url,
    required this.title,
  });

  final String url;
  final String title;

  @override
  State<AppWebViewScreen> createState() => _AppWebViewScreenState();
}

class _AppWebViewScreenState extends State<AppWebViewScreen> {
  late final WebViewController _controller;
  var _loading = true;
  var _loadFailed = false;

  @override
  void initState() {
    super.initState();
    final uri = Uri.tryParse(widget.url);
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(AppColors.scaffoldBg)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (_) {
            if (mounted) {
              setState(() {
                _loading = true;
                _loadFailed = false;
              });
            }
          },
          onPageFinished: (_) {
            if (mounted) {
              setState(() => _loading = false);
            }
          },
          onWebResourceError: (WebResourceError error) {
            if (error.isForMainFrame == false) {
              return;
            }
            if (mounted) {
              setState(() {
                _loading = false;
                _loadFailed = true;
              });
            }
          },
        ),
      );

    if (uri != null) {
      _controller.loadRequest(uri);
    } else {
      _loadFailed = true;
      _loading = false;
    }
  }

  Future<void> _reload() async {
    setState(() {
      _loadFailed = false;
      _loading = true;
    });
    await _controller.reload();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      appBar: AppBar(
        backgroundColor: AppColors.scaffoldBg,
        surfaceTintColor: Colors.transparent,
        foregroundColor: AppColors.darkText,
        elevation: 0,
        title: Text(
          widget.title,
          style: AppTextStyles.subtitle(color: AppColors.darkText),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          if (!_loadFailed)
            WebViewWidget(controller: _controller)
          else
            Center(
              child: Padding(
                padding: EdgeInsetsDirectional.symmetric(horizontal: 24.w),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      context.tr.authWebViewLoadFailed,
                      textAlign: TextAlign.center,
                      style: AppTextStyles.body(color: AppColors.greyText),
                    ),
                    SizedBox(height: 16.h),
                    FilledButton(
                      onPressed: _reload,
                      child: Text(context.tr.authWebViewRetry),
                    ),
                  ],
                ),
              ),
            ),
          if (_loading && !_loadFailed)
            Align(
              alignment: Alignment.topCenter,
              child: LinearProgressIndicator(
                minHeight: 2,
                color: AppColors.primary,
                backgroundColor: AppColors.border,
              ),
            ),
        ],
      ),
    );
  }
}
