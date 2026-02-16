import 'dart:async';

import 'package:mobile_app_labamu/core/base/base_cubit.dart';
import 'package:mobile_app_labamu/data/repository_impl/product_repository_impl.dart';
import 'package:mobile_app_labamu/domain/use_case/product_use_case.dart';
import 'package:mobile_app_labamu/state/home_state.dart';

class HomeCubit extends BaseCubit<HomeState> {
  ProductUseCase productUseCase = ProductUseCase(new ProductRepositoryImpl());

  HomeCubit() : super(HomeLoading());

  void loadHome() {
    emit(HomeLoaded());
  }

  @override
  FutureOr<void> initCubit() {
    emit(HomeLoading());
    
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
