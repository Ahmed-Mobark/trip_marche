import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:trip_marche/core/theme/app_colors.dart';
import 'package:trip_marche/core/theme/app_text_styles.dart';
import 'package:trip_marche/core/toast/app_toast.dart';
import 'package:trip_marche/core/widgets/custom_loading.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BookingPdfViewerScreen extends StatefulWidget {
  const BookingPdfViewerScreen({
    super.key,
    required this.filePath,
    this.title = 'Booking Details',
  });

  final String filePath;
  final String title;

  @override
  State<BookingPdfViewerScreen> createState() =>
      _BookingPdfViewerScreenState();
}

class _BookingPdfViewerScreenState extends State<BookingPdfViewerScreen> {
  WebViewController? _controller;
  var _loading = true;
  var _loadFailed = false;
  var _isDownloading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _controller = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setBackgroundColor(AppColors.scaffoldBg(context))
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

      _controller!.loadRequest(Uri.file(widget.filePath));
    });
  }

  Future<void> _downloadPdf() async {
    if (_isDownloading) return;

    setState(() => _isDownloading = true);

    try {
      final status = await Permission.storage.request();
      if (!status.isGranted) {
        if (mounted) {
          appToast(
            context: context,
            type: ToastType.error,
            message: 'Storage permission is required to download the PDF',
          );
        }
        return;
      }

      final sourceFile = File(widget.filePath);
      if (!await sourceFile.exists()) {
        if (mounted) {
          appToast(
            context: context,
            type: ToastType.error,
            message: 'PDF file not found',
          );
        }
        return;
      }

      Directory targetDir;
      if (Platform.isAndroid) {
        final externalDir = await getExternalStorageDirectory();
        targetDir = Directory('${externalDir!.path}/TripMarche');
      } else {
        final docsDir = await getApplicationDocumentsDirectory();
        targetDir = Directory(docsDir.path);
      }

      if (!await targetDir.exists()) {
        await targetDir.create(recursive: true);
      }

      final fileName =
          'booking_${DateTime.now().millisecondsSinceEpoch}.pdf';
      final targetPath = '${targetDir.path}/$fileName';
      await sourceFile.copy(targetPath);

      if (mounted) {
        appToast(
          context: context,
          type: ToastType.success,
          message: 'PDF downloaded successfully',
        );
      }
    } catch (e) {
      if (mounted) {
        appToast(
          context: context,
          type: ToastType.error,
          message: 'Failed to download PDF. Please try again.',
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isDownloading = false);
      }
    }
  }

  Future<void> _retry() async {
    setState(() {
      _loadFailed = false;
      _loading = true;
    });
    if (_controller != null) {
      await _controller!.loadRequest(Uri.file(widget.filePath));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBg(context),
      appBar: AppBar(
        backgroundColor: AppColors.scaffoldBg(context),
        surfaceTintColor: Colors.transparent,
        foregroundColor: AppColors.darkText(context),
        elevation: 0,
        title: Text(
          widget.title,
          style: AppTextStyles.subtitle(color: AppColors.darkText(context)),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        actions: [
          IconButton(
            onPressed: _isDownloading ? null : _downloadPdf,
            icon: _isDownloading
                ? SizedBox(
                    width: 20.r,
                    height: 20.r,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: AppColors.darkText(context),
                    ),
                  )
                : Icon(Icons.download_rounded),
            tooltip: 'Download PDF',
          ),
        ],
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          if (_controller != null && !_loadFailed)
            WebViewWidget(controller: _controller!)
          else if (_loadFailed)
            Center(
              child: Padding(
                padding: EdgeInsetsDirectional.symmetric(horizontal: 24.w),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Failed to load PDF',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.body(color: AppColors.greyText(context)),
                    ),
                    SizedBox(height: 16.h),
                    FilledButton(
                      onPressed: _retry,
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            ),
          if (_loading || _controller == null)
            const Center(child: CustomLoading()),
        ],
      ),
    );
  }
}
