import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mobile_app_labamu/core/base/base_cubit.dart';
import 'package:mobile_app_labamu/core/helper/general_helpepr.dart';
import 'package:mobile_app_labamu/data/model/product.dart';
import 'package:mobile_app_labamu/data/repository_impl/product_repository_impl.dart';
import 'package:mobile_app_labamu/domain/use_case/product_use_case.dart';
import 'package:mobile_app_labamu/state/home_state.dart';

class HomeCubit extends BaseCubit<HomeState> {
  ProductUseCase productUseCase = ProductUseCase(new ProductRepositoryImpl());
  GeneralHelper generalHelper = GeneralHelper();
  List<Product> products = [];

  ScrollController scrollController = ScrollController();

  HomeCubit() : super(HomeLoading());

  var page = 1;
  var limit = 10;

  @override
  FutureOr<void> initCubit() async {
    emit(HomeLoading());
    var result = await productUseCase.getProducts({
      "_page": page,
      "_limit": limit,
    });

    products = result.map((product) => product).toList();

    scrollController.addListener(loadCubit);

    emit(HomeLoaded());
  }

  @override
  FutureOr<void> loadCubit() async {
    emit(HomeLoadingPagination());

    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent) {
      page++;

      var result = await productUseCase.getProducts({
        "_page": page,
        "_limit": limit,
      });

      if (result.isEmpty) {
        emit(HomeLoaded());
        return;
      }

      products.addAll(result);
      emit(HomeLoaded());
    }
  }

  @override
  FutureOr<void> postCubit() {
    emit(HomeLoading());
    emit(HomeLoaded());
  }
}
