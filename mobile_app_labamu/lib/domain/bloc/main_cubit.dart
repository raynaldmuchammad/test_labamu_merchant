import 'dart:async';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import '../../core/constant/app_constant.dart';
import '../../core/helper/general_helpepr.dart';
import '../../core/base/base_cubit.dart';
import '../../state/main_state.dart';
import '../../data/repository_impl/main_repository.dart';

class MainCubit extends BaseCubit<MainState> {
  MainCubit() : super(MainLoading());

  MainRepository repository = MainRepository();
  GeneralHelper helper = GeneralHelper();

  String nextUrl = "";
  int total = 0;

  TextEditingController controller = TextEditingController();
  late int currentIndex = 0;

  @override
  FutureOr<void> initCubit() async {
    try {
      var isFirstInstall = await helper.read(AppConstant.isFirstInstall) ?? "1";

      if (isFirstInstall == "1") {
        await helper.store(AppConstant.isFirstInstall, "0");
        emit(BoardingLoaded());
      } else {
        emit(HomeLoaded());
      }
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  FutureOr<void> loadCubit() {}

  @override
  FutureOr<void> postCubit() {}
}
