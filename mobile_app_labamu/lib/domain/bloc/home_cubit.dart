import 'dart:async';

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

  HomeCubit() : super(HomeLoading());

  @override
  FutureOr<void> initCubit() async {
    emit(HomeLoading());
    var result = await productUseCase.getProducts();
    products = result.map((product) => product).toList();
    emit(HomeLoaded());
  }

  @override
  FutureOr<void> loadCubit() {
    emit(HomeLoading());
    emit(HomeLoaded());
  }

  @override
  FutureOr<void> postCubit() {
    emit(HomeLoading());
    emit(HomeLoaded());
  }
}
