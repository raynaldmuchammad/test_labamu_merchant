import 'package:mobile_app_labamu/core/constant/url_endpoint.dart';
import 'package:mobile_app_labamu/data/model/product.dart';
import 'package:mobile_app_labamu/domain/repository/product_repository.dart';

class ProductRepositoryImpl extends ProductRepository {
  @override
  Future<List<Product>> fetchProducts() async {
    final response = await provider.get(UrlEndpoint.product);
    return (response as List).map((e) => Product.fromJson(e)).toList();
  }

  @override
  Future<Product> fetchProduct({required String id}) async {
    throw UnimplementedError();
  }

  @override
  Future<Product> updateProduct({required Product product}) async {
    throw UnimplementedError();
  }
}
