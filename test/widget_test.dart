import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trip_marche/core/app/app_body.dart';

void main() {
  test('app keeps its initial theme mode', () {
    const app = MyApp(initialThemeMode: AdaptiveThemeMode.light);

    expect(app.initialThemeMode, AdaptiveThemeMode.light);
  });
}
