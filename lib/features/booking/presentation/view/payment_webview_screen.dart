import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:trip_marche/core/config/app_colors.dart';
import 'package:trip_marche/core/extensions/localization.dart';
import 'package:trip_marche/core/toast/app_toast.dart';

class PaymentWebViewScreen extends StatefulWidget {
  const PaymentWebViewScreen({
    super.key,
    required this.url,
    this.onPaymentComplete,
  });

  final String url;
  final VoidCallback? onPaymentComplete;

  @override
  State<PaymentWebViewScreen> createState() => _PaymentWebViewScreenState();
}

class _PaymentWebViewScreenState extends State<PaymentWebViewScreen> {
  late final WebViewController _controller;
  bool _isLoading = true;
  String? _loadError;

  static const _successPaths = <String>[
    '/payment/success',
    '/payment/success/',
    '/checkout/success',
    '/checkout/success/',
    '/success',
    '/success/',
  ];

  static const _failurePaths = <String>[
    '/payment/failed',
    '/payment/failed/',
    '/payment/cancelled',
    '/payment/cancel',
    '/payment/cancel/',
    '/checkout/failed',
    '/checkout/failed/',
    '/checkout/cancel',
    '/checkout/cancel/',
    '/failed',
    '/failed/',
    '/cancel',
    '/cancel/',
    '/cancelled',
    '/cancelled/',
  ];

  @override
  void initState() {
    super.initState();
    _initController();
  }

  void _initController() {
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (_) => _setLoading(true),
          onPageFinished: (_) => _setLoading(false),
          onWebResourceError: (error) => _setError(error.description),
          onNavigationRequest: (request) => _handleNavigation(request),
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.tr.paymentWebViewTitle),
        centerTitle: true,
      ),
      body: IndexedStack(
        index: _isLoading && _loadError == null ? 0 : 1,
        children: [
          const Center(child: CircularProgressIndicator()),
          Column(
            children: [
              if (_loadError != null) _buildErrorBar(context),
              Expanded(child: WebViewWidget(controller: _controller)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildErrorBar(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      color: AppColors.red,
      child: Row(
        children: [
          const Icon(Icons.error_outline, color: Colors.white),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              _loadError ?? context.tr.paymentWebViewError,
              style: const TextStyle(color: Colors.white),
            ),
          ),
          TextButton(
            onPressed: () {
              _setError(null);
              _controller.loadRequest(Uri.parse(widget.url));
            },
            child: Text(context.tr.paymentWebViewRetry),
          ),
        ],
      ),
    );
  }

  NavigationDecision _handleNavigation(NavigationRequest request) {
    final uri = Uri.tryParse(request.url);
    if (uri == null) return NavigationDecision.navigate;

    final path = uri.path.toLowerCase();
    final query = uri.queryParameters.map(
      (k, v) => MapEntry(k, v.toLowerCase()),
    );

    if (_matches(path, query, _successPaths)) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        widget.onPaymentComplete?.call();
        if (mounted) {
          Navigator.of(context).popUntil((route) => route.isFirst);
        }
      });
      return NavigationDecision.prevent;
    }

    if (_matches(path, query, _failurePaths)) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        appToast(
          context: context,
          type: ToastType.error,
          message: context.tr.paymentWebViewFailed,
        );
        if (mounted) Navigator.of(context).pop();
      });
      return NavigationDecision.prevent;
    }

    return NavigationDecision.navigate;
  }

  bool _matches(String path, Map<String, String> query, List<String> routes) {
    for (final route in routes) {
      if (path == route) return true;
      final trimmed = route.replaceAll('/', '');
      if (path == '/$trimmed') return true;
      if (query['status'] == trimmed) return true;
      if (query['result'] == trimmed) return true;
      if (query['payment_status'] == trimmed) return true;
    }
    return false;
  }

  void _setLoading(bool loading) {
    if (mounted && _isLoading != loading) {
      setState(() => _isLoading = loading);
    }
  }

  void _setError(String? error) {
    if (mounted && _loadError != error) {
      setState(() => _loadError = error);
    }
  }
}
