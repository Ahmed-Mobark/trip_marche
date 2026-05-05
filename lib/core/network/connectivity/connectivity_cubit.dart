import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Tracks **link-layer** connectivity (Wi‑Fi / mobile / ethernet present).
///
/// Emits `false` only when the OS reports no network interface
/// ([ConnectivityResult.none]) — e.g. airplane mode or all radios off.
///
/// Does **not** ping the public internet, so a slow or weak connection still
/// emits `true` and the global offline overlay stays hidden.
class ConnectivityCubit extends Cubit<bool> {
  ConnectivityCubit() : super(true) {
    _subscription = _connectivity.onConnectivityChanged.listen(_emitFromResults);
    _checkInitial();
  }

  final Connectivity _connectivity = Connectivity();
  late final StreamSubscription<List<ConnectivityResult>> _subscription;

  Future<void> _checkInitial() async {
    try {
      final results = await _connectivity.checkConnectivity();
      _emitFromResults(results);
    } catch (_) {
      // Prefer not blocking the app if the platform check fails.
      emit(true);
    }
  }

  void _emitFromResults(List<ConnectivityResult> results) {
    emit(_hasNetworkInterface(results));
  }

  /// `true` if any active network path exists; `false` only for true “no network”.
  static bool _hasNetworkInterface(List<ConnectivityResult> results) {
    if (results.isEmpty) {
      // Ambiguous — avoid flashing offline on transient empty results.
      return true;
    }
    return results.any((r) => r != ConnectivityResult.none);
  }

  Future<void> checkConnection() async {
    await _checkInitial();
  }

  @override
  Future<void> close() async {
    await _subscription.cancel();
    return super.close();
  }
}
