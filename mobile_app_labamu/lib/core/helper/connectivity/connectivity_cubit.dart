import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app_labamu/core/helper/connectivity/connection_service.dart';
import 'package:mobile_app_labamu/core/helper/connectivity/connectivity_state.dart';

class ConnectivityCubit extends Cubit<ConnectivityState> {
  final ConnectionService connectionService;
  StreamSubscription? subscription;

  ConnectivityCubit({required this.connectionService})
      : super(ConnectivityInitial());

  FutureOr<void> initialize() async {
    await connectionService.initialize();
    subscription = connectionService.connectionStream.listen((isConnected) {
      if (isConnected) {
        emit(ConnectivityConnected());
      } else {
        emit(ConnectivityDisconnected());
      }
    });
  }

  FutureOr<void> onChanged() async {
    if (connectionService.isConnected) {
      emit(ConnectivityConnected());
    } else {
      emit(ConnectivityDisconnected());
    }
  }

  FutureOr<void> onClose() async {
    await subscription?.cancel();
    await connectionService.dispose();
    return super.close();
  }
}
