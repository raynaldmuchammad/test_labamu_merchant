import 'package:mobile_app_labamu/data/model/product.dart';
import 'package:mobile_app_labamu/domain/repository/product_repository.dart';

class ProductUseCase {
  final ProductRepository repository;

  ProductUseCase(this.repository);

  Future<List<Product>> getProducts() async {
    return await repository.fetchProducts();
  }

  Future<Product> getProduct(String id) async {
    return await repository.fetchProduct(id: id);
  }

  Future<Product> updateProduct(Product product) async {
    return await repository.updateProduct(product: product);
  }
}
