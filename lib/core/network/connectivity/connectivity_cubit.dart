import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class ConnectivityCubit extends Cubit<bool> {
  final InternetConnection _internetConnection;
  late final StreamSubscription<InternetStatus> _subscription;

  /// Emits `true` when connected, `false` when offline.
  ConnectivityCubit(this._internetConnection) : super(true) {
    _subscription = _internetConnection.onStatusChange.listen((status) {
      emit(status == InternetStatus.connected);
    });
    _checkInitial();
  }

  Future<void> _checkInitial() async {
    final connected = await _internetConnection.hasInternetAccess;
    emit(connected);
  }

  Future<void> checkConnection() async {
    final connected = await _internetConnection.hasInternetAccess;
    emit(connected);
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
