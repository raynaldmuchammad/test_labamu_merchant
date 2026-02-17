import 'package:mobile_app_labamu/data/model/product.dart';

abstract class ProductDetailState {}

class ProductDetailInitial extends ProductDetailState {}

class ProductDetailLoading extends ProductDetailState {}

class ProductDetailLoaded extends ProductDetailState {
  final Product product;

  ProductDetailLoaded(this.product);
}

class ProductDetailError extends ProductDetailState {
  final String message;

  ProductDetailError(this.message);
}
