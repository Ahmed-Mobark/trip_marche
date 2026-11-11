import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trip_marche/core/network/network_service/api_basehelper.dart';
import 'package:trip_marche/features/settings/data/datasources/help_center_remote_data_source.dart';

class _FakeApi implements ApiBaseHelper {
  _FakeApi(this.responses);

  final Map<String, Map<String, dynamic>> responses;
  final List<String> requested = [];

  @override
  Future<T> get<T>({
    required String url,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? body,
    Options? options,
    ApiEnvironment environment = ApiEnvironment.primary,
    bool includeCurrency = false,
  }) async {
    requested.add(url);
    return responses[url] as T;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  test('help content is read from the active pages API', () async {
    final api = _FakeApi({
      'pages': {
        'data': [
          {'slug': 'faq', 'title': 'الأسئلة الشائعة'},
          {'slug': 'contact-us', 'title': 'الاتصال بنا'},
        ],
      },
      'pages/faq': {
        'data': {
          'slug': 'faq',
          'title': 'الأسئلة الشائعة',
          'body': '<p>إزاي أحجز؟</p>',
        },
      },
    });
    final source = HelpCenterRemoteDataSourceImpl(api);

    final pages = await source.pages();
    final faq = await source.page('faq');

    expect(pages.map((page) => page.slug), ['faq', 'contact-us']);
    expect(faq.body, '<p>إزاي أحجز؟</p>');
    expect(api.requested, ['pages', 'pages/faq']);
  });
}
