import 'dart:convert';

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
  String? _lastKnownTitle;
  bool _jsConsoleHooked = false;
  final List<String> _capturedConsoleLogs = [];

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
    _log('PaymentWebView created');
    _log('Initial URL: ${widget.url}');
    _initController();
    _startTitlePoller();
    _startConsoleHook();
  }

  void _log(String message) {
    debugPrint('[PAYMENT] $message');
  }

  void _initController() {
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (progress) {
            final p = progress.clamp(0, 100);
            _log('Loading Progress:\n$p%');
          },
          onUrlChange: (change) {
            final url = change.url;
            if (url != null) {
              _log('URL Changed\n$url');
            }
          },
          onPageStarted: (url) {
            _log('onPageStarted\nURL:\n$url');
            _setLoading(true);
          },
          onPageFinished: (url) {
            _log('onPageFinished\nURL:\n$url');
            _setLoading(false);
            _executePostLoadJs();
          },
          onHttpError: (error) {
            final statusCode = error.response?.statusCode;
            final requestUrl = error.request?.uri.toString();
            _log(
              'HTTP Error\nStatus Code: $statusCode\nDescription: ${error.toString()}\nURL: $requestUrl',
            );
          },
          onWebResourceError: (error) {
            _log(
              'Web Resource Error\nError Code: ${error.errorCode}\nDescription: ${error.description}\nError Type: ${error.errorType}\nFailing URL: ${error.url}',
            );
            _setError(error.description);
          },
          onNavigationRequest: (request) {
            _log('Navigation Request\nURL:\n${request.url}');
            final uri = Uri.tryParse(request.url);
            final status = _detectPaymentStatus(uri);
            if (status != null) {
              _log(
                'Detected Payment Status: ${status.name}\nCurrent URL:\n${request.url}',
              );
            } else {
              _log('UNKNOWN CALLBACK\nCurrent URL:\n${request.url}');
            }
            return _handleNavigation(request);
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  void _startTitlePoller() {
    Future.doWhile(() async {
      if (!mounted) return false;
      try {
        final result = await _controller.runJavaScriptReturningResult(
          'document.title',
        );
        final title = result.toString();
        if (title != _lastKnownTitle && title.isNotEmpty) {
          _log('Page Title:\n$title');
          _lastKnownTitle = title;
        }
      } catch (_) {
        // ignore title polling errors
      }
      await Future<void>.delayed(const Duration(seconds: 1));
      return mounted;
    });
  }

  void _startConsoleHook() {
    Future<void>.delayed(const Duration(seconds: 2), () {
      if (!mounted || _jsConsoleHooked) return;
      _jsConsoleHooked = true;
      final hook = '''
        (function() {
          if (window.__consoleHooked) return;
          window.__consoleHooked = true;
          var original = {
            log: console.log.bind(console),
            warn: console.warn.bind(console),
            error: console.error.bind(console),
            info: console.info.bind(console),
          };
          ['log', 'warn', 'error', 'info'].forEach(function(level) {
            console[level] = function() {
              var args = Array.prototype.slice.call(arguments);
              var msg = args.map(function(a) {
                try { return typeof a === 'object' ? JSON.stringify(a) : String(a); }
                catch(e) { return String(a); }
              }).join(' ');
              window.__flutterConsoleLogs = window.__flutterConsoleLogs || [];
              window.__flutterConsoleLogs.push(level + '|' + msg);
              original[level].apply(console, arguments);
            };
          });
        })();
      ''';
      _controller
          .runJavaScript(hook)
          .then((_) {
            Future.doWhile(() async {
              if (!mounted) return false;
              try {
                final result = await _controller.runJavaScriptReturningResult(
                  'window.__flutterConsoleLogs || "[]"',
                );
                final raw = result.toString();
                final decoded = jsonDecode(raw) as List<dynamic>;
                for (final entry in decoded) {
                  if (entry is String &&
                      !_capturedConsoleLogs.contains(entry)) {
                    _capturedConsoleLogs.add(entry);
                    final separatorIndex = entry.indexOf('|');
                    final level = separatorIndex > 0
                        ? entry.substring(0, separatorIndex)
                        : 'log';
                    final msg = separatorIndex > 0
                        ? entry.substring(separatorIndex + 1)
                        : entry;
                    _log('Console [$level]: $msg');
                  }
                }
              } catch (_) {
                // ignore console polling errors
              }
              await Future<void>.delayed(const Duration(milliseconds: 500));
              return mounted;
            });
          })
          .catchError((e) {
            _log('Failed to hook console: $e');
          });
    });
  }

  Future<void> _executePostLoadJs() async {
    try {
      final script = '''
        (function() {
          var title = document.title || '';
          var href = window.location.href || '';
          var body = '';
          try {
            body = document.body ? document.body.innerText.substring(0, 500) : '';
          } catch(e) {
            body = 'N/A';
          }
          return JSON.stringify({ title: title, href: href, body: body });
        })();
      ''';
      final result = await _controller.runJavaScriptReturningResult(script);
      final decoded = jsonDecode(result.toString()) as Map<String, dynamic>;
      final title = decoded['title']?.toString() ?? '';
      final href = decoded['href']?.toString() ?? '';
      final body = decoded['body']?.toString() ?? '';

      if (title.isNotEmpty) {
        _log('Page Title:\n$title');
        _lastKnownTitle = title;
      }
      _log('Current URL:\n$href');
      _log('Body Preview:\n$body');
    } catch (e) {
      _log('Failed to execute post-load JS: $e');
    }
  }

  PaymentStatus? _detectPaymentStatus(Uri? uri) {
    if (uri == null) return null;
    final path = uri.path.toLowerCase();
    final query = uri.queryParameters.map(
      (k, v) => MapEntry(k, v.toLowerCase()),
    );

    for (final route in _successPaths) {
      if (path == route) return PaymentStatus.success;
      final trimmed = route.replaceAll('/', '');
      if (path == '/$trimmed') return PaymentStatus.success;
      if (query['status'] == trimmed) return PaymentStatus.success;
      if (query['result'] == trimmed) return PaymentStatus.success;
      if (query['payment_status'] == trimmed) return PaymentStatus.success;
    }

    for (final route in _failurePaths) {
      if (path == route) return PaymentStatus.failed;
      final trimmed = route.replaceAll('/', '');
      if (path == '/$trimmed') return PaymentStatus.failed;
      if (query['status'] == trimmed) return PaymentStatus.failed;
      if (query['result'] == trimmed) return PaymentStatus.failed;
      if (query['payment_status'] == trimmed) return PaymentStatus.failed;
    }

    return PaymentStatus.unknown;
  }

  NavigationDecision _handleNavigation(NavigationRequest request) {
    final uri = Uri.tryParse(request.url);
    if (uri == null) return NavigationDecision.navigate;

    final path = uri.path.toLowerCase();
    final query = uri.queryParameters.map(
      (k, v) => MapEntry(k, v.toLowerCase()),
    );

    if (_matches(path, query, _successPaths)) {
      _log(
        '==============================\nPAYMENT SUCCESS DETECTED\nReference: ${uri.toString()}\nCurrent URL:\n${request.url}\n==============================',
      );
      WidgetsBinding.instance.addPostFrameCallback((_) {
        widget.onPaymentComplete?.call();
        if (mounted) {
          _log('Action:\nNavigate to MyTrips');
          Navigator.of(context).popUntil((route) => route.isFirst);
        }
      });
      return NavigationDecision.prevent;
    }

    if (_matches(path, query, _failurePaths)) {
      _log(
        '==============================\nPAYMENT FAILED DETECTED\nReference: ${uri.toString()}\nCurrent URL:\n${request.url}\n==============================',
      );
      WidgetsBinding.instance.addPostFrameCallback((_) {
        appToast(
          context: context,
          type: ToastType.error,
          message: context.tr.paymentWebViewFailed,
        );
        if (mounted) {
          _log('Action:\nClose Payment Screen');
          Navigator.of(context).pop();
        }
      });
      return NavigationDecision.prevent;
    }

    return NavigationDecision.navigate;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        _log('User attempted to pop WebView');
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(context.tr.paymentWebViewTitle),
          centerTitle: true,
          backgroundColor: AppColors.background(context),
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: AppColors.darkText(context),
            ),
            onPressed: () => Navigator.pop(context),
          ),
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
              _log('Retry button pressed\nLoading initial URL again');
              _setError(null);
              _controller.loadRequest(Uri.parse(widget.url));
            },
            child: Text(context.tr.paymentWebViewRetry),
          ),
        ],
      ),
    );
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

enum PaymentStatus { success, failed, cancelled, unknown }
