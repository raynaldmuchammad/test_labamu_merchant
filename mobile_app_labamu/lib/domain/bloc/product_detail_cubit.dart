import 'dart:async';
import 'package:mobile_app_labamu/core/base/base_cubit.dart';
import 'package:mobile_app_labamu/core/helper/general_helpepr.dart';
import 'package:mobile_app_labamu/data/model/product.dart';
import 'package:mobile_app_labamu/state/product_detail_state.dart';

class ProductDetailCubit extends BaseCubit<ProductDetailState> {
  ProductDetailCubit() : super(ProductDetailInitial());
  
  GeneralHelper generalHelper = GeneralHelper();
  late Product product;

  @override
  FutureOr<void> initCubit() async {
    emit(ProductDetailInitial());
  }

  @override
  FutureOr<void> loadCubit() async {
    emit(ProductDetailLoading());
  }

  @override
  FutureOr<void> postCubit() async {
    emit(ProductDetailLoading());
  }

  void selectProduct(Product product) {
    this.product = product;
    emit(ProductDetailLoaded(product));
  }
}
