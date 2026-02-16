import 'dart:async';

import 'package:mobile_app_labamu/core/helper/general_helpepr.dart';
import 'package:mobile_app_labamu/core/base/base_cubit.dart';
import 'package:mobile_app_labamu/state/splash_state.dart';

class SplashCubit extends BaseCubit<SplashState> {
  SplashCubit() : super(SplashLoading());

  GeneralHelper helper = GeneralHelper();

  @override
  FutureOr<void> initCubit() async {
    try {
      emit(SplashLoading());

      emit(SplashLoaded());
    } catch (e) {
      emit(SplashLoaded());
    }
  }

  @override
  FutureOr<void> loadCubit() {
    //
  }

  @override
  FutureOr<void> postCubit() {
    //
  }
}
