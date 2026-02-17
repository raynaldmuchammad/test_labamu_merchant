import 'package:mobile_app_labamu/core/base/base_repository.dart';
import 'package:mobile_app_labamu/data/model/product.dart';

abstract class ProductRepository extends BaseRepository {
  Future<List<Product>> fetchProducts(dynamic params);
  Future<Product> fetchProduct({required String id});
  Future<Product> addProduct({required Product product});
  Future<Product> updateProduct({required Product product});
}
