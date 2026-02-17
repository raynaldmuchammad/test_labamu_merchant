abstract class ProductAddState {}

class ProductAddInitial extends ProductAddState {}

class ProductAddLoading extends ProductAddState {}

class ProductAddSuccess extends ProductAddState {}

class ProductAddError extends ProductAddState {
  final String message;

  ProductAddError(this.message);
}
