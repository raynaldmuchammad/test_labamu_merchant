import 'dart:async';

import 'package:mobile_app_labamu/core/base/base_cubit.dart';
import 'package:mobile_app_labamu/state/product_add_state.dart';

class ProductAddCubit extends BaseCubit<ProductAddState> {
  ProductAddCubit() : super(ProductAddInitial());

  @override
  FutureOr<void> initCubit() async {
    emit(ProductAddInitial());
  }

  @override
  FutureOr<void> loadCubit() async {
    emit(ProductAddLoading());
  }

  @override
  FutureOr<void> postCubit() async {
    emit(ProductAddLoading());
  }
}
