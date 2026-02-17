import 'dart:developer';

import 'package:mobile_app_labamu/core/app/env.dart';
import 'package:mobile_app_labamu/core/constant/db_constant.dart';
import 'package:mobile_app_labamu/core/helper/database_helper.dart';
import 'package:mobile_app_labamu/data/model/product.dart';
import 'package:mobile_app_labamu/core/constant/url_endpoint.dart';
import 'package:mobile_app_labamu/domain/repository/product_repository.dart';
import 'package:mobile_app_labamu/core/helper/connectivity/connection_service.dart';

class ProductRepositoryImpl extends ProductRepository {
  ConnectionService connectivityService = ConnectionService();
  DatabaseHelper databaseHelper = DatabaseHelper();

  @override
  Future<List<Product>> fetchProducts() async {
    try {
      await connectivityService.initialize();
      databaseHelper.initDatabase();
      var productsLocal = await databaseHelper.fetchAllData({
        "collectionName": DbConstant.collectionProduct,
      });

      if (productsLocal == null || connectivityService.isConnected) {
        var response = await provider.get(Env.baseUrl + UrlEndpoint.product);

        if (productsLocal == null) {
          // Simpan data ke local database jika belum ada
          for (var data in response) {
            var product = Product.fromJson(data);
            databaseHelper.storeData({
              "collectionName": DbConstant.collectionProduct,
              "product": product,
            });
          }
        }
        log("Fetched products from API: $response");
        return (response as List)
            .map((data) => Product.fromJson(data))
            .toList();
      } else {
        log("Fetched products from local database: $productsLocal");
        return productsLocal;
      }
    } catch (e) {
      log("Error fetching products: $e");
      return [];
    }
  }

  @override
  Future<Product> fetchProduct({required String id}) async {
    return Product(
      id: 10,
      name: "Product $id",
      description: "Description for product $id",
      price: 100,
    );
  }

  @override
  Future<Product> updateProduct({required Product product}) async {
    return Product(
      id: product.id,
      name: "Updated ${product.name}",
      description: "Updated description for product ${product.id}",
      price: product.price,
    );
  }
}
