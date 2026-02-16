import 'dart:async';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:mobile_app_labamu/core/base/base_cubit.dart';
import 'package:mobile_app_labamu/core/helper/general_helpepr.dart';
import 'package:mobile_app_labamu/state/boarding_state.dart';

class BoardingCubit extends BaseCubit<BoardingState> {
  BoardingCubit() : super(BoardingLoading());

  late int totalPage = 0;
  late int pageIndex = 0;
  late bool isLastPage = false;

  GeneralHelper generalHelper = GeneralHelper();
  PageController controller = PageController(initialPage: 0, keepPage: false);

  List<Map<String, dynamic>> pages = [
    {
      "title": "Mulai Petualanganmu",
      "description":
          "Jelajahi Indonesia tanpa ribet. Pesan tiket perjalananmu dalam hitungan detik!",
      "image":
          "https://images.unsplash.com/photo-1550399504-8953e1a6ac87?q=80&w=1629&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    },
    {
      "title": "Perjalanan Jadi Lebih Mudah",
      "description":
          "Perjalanan nyaman dimulai di sini. Temukan rute, pesan kursi, dan berangkat tanpa khawatir.",
      "image":
          "https://images.unsplash.com/photo-1440778303588-435521a205bc?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    },
  ];

  @override
  FutureOr<void> initCubit() async {
    emit(BoardingLoading());

    totalPage = pages.length;
    emit(BoardingLoaded(pageIndex: pageIndex, isLastPage: isLastPage));
  }

  @override
  FutureOr<void> loadCubit() {
    //
  }

  @override
  FutureOr<void> postCubit() async {
    try {} catch (e) {
      log(e.toString());
    }
  }

  FutureOr<void> changePage(int index) {
    pageIndex = index;

    if (pageIndex == totalPage - 1) {
      isLastPage = true;
    } else {
      isLastPage = false;
    }

    emit(BoardingLoaded(pageIndex: pageIndex, isLastPage: isLastPage));
  }
}
