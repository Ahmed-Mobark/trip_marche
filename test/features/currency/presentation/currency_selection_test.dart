import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:trip_marche/core/injection/injection_container.dart';
import 'package:trip_marche/core/network/network_service/failures.dart';
import 'package:trip_marche/core/storage/data/storage_impl.dart';
import 'package:trip_marche/core/translation/app_localizations.dart';
import 'package:trip_marche/features/currency/data/models/currency_model.dart';
import 'package:trip_marche/features/currency/domain/entities/currency_entity.dart';
import 'package:trip_marche/features/currency/domain/repositories/currency_repository.dart';
import 'package:trip_marche/features/currency/domain/usecases/get_currencies_use_case.dart';
import 'package:trip_marche/features/currency/presentation/cubit/currency_cubit.dart';
import 'package:trip_marche/features/currency/presentation/view/currency_view.dart';

class _Repository implements CurrencyRepository {
  final currencies = [
    CurrencyModel.fromJson({
      'code': 'egp',
      'name': 'Egyptian Pound',
      'is_base': true,
    }).toEntity(),
    CurrencyModel.fromJson({'code': 'usd', 'name': 'US Dollar'}).toEntity(),
  ];

  @override
  Future<Either<Failure, List<CurrencyEntity>>> getCurrencies() async =>
      Right(currencies);
}

void main() {
  late Directory directory;
  late Box<String> strings;
  late Box<bool> booleans;
  late StorageImpl storage;
  late CurrencyCubit cubit;
  late _Repository repository;

  setUp(() async {
    directory = await Directory.systemTemp.createTemp('currency_selection_');
    Hive.init(directory.path);
    strings = await Hive.openBox<String>('stringBox');
    booleans = await Hive.openBox<bool>('boolBox');
    storage = StorageImpl(stringBox: strings, boolBox: booleans);
    repository = _Repository();
    cubit = CurrencyCubit(GetCurrenciesUseCase(repository), storage);
  });

  tearDown(() async {
    await cubit.close();
    await Hive.close();
    await directory.delete(recursive: true);
  });

  test('selection survives closing storage and recreating the Cubit', () async {
    await cubit.loadCurrencies();
    await cubit.selectCurrency(repository.currencies[1]);
    expect(strings.get('currency_code'), 'USD');
    expect(storage.getCurrencyCode(), 'USD');
    await cubit.close();
    await Hive.close();
    strings = await Hive.openBox<String>('stringBox');
    booleans = await Hive.openBox<bool>('boolBox');
    storage = StorageImpl(stringBox: strings, boolBox: booleans);
    cubit = CurrencyCubit(GetCurrenciesUseCase(repository), storage);
    expect(cubit.state.selectedCode, 'USD');
    await cubit.loadCurrencies();
    expect(cubit.state.selectedCode, 'USD');
  });

  test('missing saved currency falls back to an available currency', () async {
    repository.currencies.removeAt(0);
    await cubit.loadCurrencies();
    expect(cubit.state.selectedCode, 'USD');
    expect(storage.getCurrencyCode(), 'USD');
  });

  testWidgets('restores selection and keeps cards collapsed after selecting', (
    tester,
  ) async {
    await tester.runAsync(() => storage.storeCurrencyCode(currencyCode: 'USD'));
    sl.registerSingleton<CurrencyCubit>(cubit);
    addTearDown(() => sl.unregister<CurrencyCubit>());
    Widget app() => ScreenUtilInit(
      designSize: const Size(393, 852),
      builder: (_, __) => const MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: CurrencyView(),
      ),
    );
    await tester.pumpWidget(app());
    await tester.pumpAndSettle();
    expect(cubit.state.selectedCode, 'USD');
    Finder tile(String name) =>
        find.ancestor(of: find.text(name), matching: find.byType(InkWell));
    final egpHeight = tester.getSize(tile('Egyptian Pound')).height;
    final usdHeight = tester.getSize(tile('US Dollar')).height;
    expect(egpHeight, usdHeight);
    expect(find.byType(TextField), findsNothing);
    expect(find.text('Equivalent in Egyptian Pound'), findsNothing);
    expect(find.byIcon(Icons.radio_button_checked_rounded), findsOneWidget);
    await tester.runAsync(() async {
      await tester.tap(find.text('Egyptian Pound'));
      await strings.flush();
    });
    await tester.pumpAndSettle();
    expect(storage.getCurrencyCode(), 'EGP');
    expect(cubit.state.selectedCode, 'EGP');
    expect(tester.getSize(tile('Egyptian Pound')).height, egpHeight);
    expect(tester.getSize(tile('US Dollar')).height, usdHeight);
    expect(find.byType(TextField), findsNothing);
    expect(find.byIcon(Icons.radio_button_checked_rounded), findsOneWidget);
    await tester.pumpWidget(const SizedBox());
    await tester.pumpWidget(app());
    await tester.pumpAndSettle();
    expect(cubit.state.selectedCode, 'EGP');
  });
}
