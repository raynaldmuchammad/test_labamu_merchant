import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class ConnectionService {
  final Connectivity connectivity;
  final InternetConnectionChecker internetConnectionChecker;

  final StreamController<bool> controller = StreamController<bool>.broadcast();

  StreamSubscription? connectionSubs;
  StreamSubscription? internetSubs;

  bool isConnectedConnection = false;
  bool get isConnected => isConnectedConnection;

  ConnectionService({
    Connectivity? connectivity,
    InternetConnectionChecker? internetConnectionChecker,
  })  : connectivity = connectivity ?? Connectivity(),
        internetConnectionChecker =
            internetConnectionChecker ?? InternetConnectionChecker();

  Stream<bool> get connectionStream => controller.stream;
  
  Future<void> initialize() async {
    await checkConnection();

    connectionSubs = connectivity.onConnectivityChanged.listen((_) {
      checkConnection();
    });

    internetSubs = internetConnectionChecker.onStatusChange.listen((_) {
      checkConnection();
    });
  }

  Future<void> checkConnection() async {
    final hasInternet = await internetConnectionChecker.hasConnection;

    if (isConnected != hasInternet) {
      isConnectedConnection = hasInternet;
      controller.add(isConnected);
    }
  }

  Future<void> dispose() async {
    await connectionSubs?.cancel();
    await internetSubs?.cancel();
    await controller.close();
  }
}
