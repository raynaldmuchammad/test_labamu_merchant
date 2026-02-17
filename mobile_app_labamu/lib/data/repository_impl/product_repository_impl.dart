import 'package:mobile_app_labamu/core/app/env.dart';
import 'package:mobile_app_labamu/data/model/product.dart';
import 'package:mobile_app_labamu/core/constant/url_endpoint.dart';
import 'package:mobile_app_labamu/domain/repository/product_repository.dart';
import 'package:mobile_app_labamu/core/helper/connectivity/connection_service.dart';

class ProductRepositoryImpl extends ProductRepository {
  ConnectionService connectivityService = ConnectionService();

  @override
  Future<List<Product>> fetchProducts() async {
    if (connectivityService.isConnected) {
      var response = await provider.get(Env.baseUrl + UrlEndpoint.product);
      return (response as List).map((data) => Product.fromJson(data)).toList();
    } else {

      return [];
    }
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
