import 'dart:convert';
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
  Future<List<Product>> fetchProducts(dynamic params) async {
    try {
      await connectivityService.initialize();
      databaseHelper.initDatabase();
      var productsLocal = await databaseHelper.fetchAllData({
        "collectionName": DbConstant.collectionProduct,
      });

      if (productsLocal == null || connectivityService.isConnected) {
        // build request URL with optional params
        var requestUrl = Env.baseUrl + UrlEndpoint.product;
        if (params != null) {
          final base = Uri.parse(Env.baseUrl + UrlEndpoint.product);
          if (params is Map<String, dynamic> && params.isNotEmpty) {
            final qp = params
                .map((k, v) => MapEntry(k.toString(), v?.toString() ?? ''));
            requestUrl = base.replace(
                queryParameters: {...base.queryParameters, ...qp}).toString();
          } else {
            requestUrl =
                '${Env.baseUrl}${UrlEndpoint.product}/${Uri.encodeComponent(params.toString())}';
          }
        }

        var response = await provider.get(requestUrl);

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

        return (response as List)
            .map((data) => Product.fromJson(data))
            .toList();
      } else {
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

  @override
  Future<Product> addProduct({required Product product}) async {
    try {
      await connectivityService.initialize();
      databaseHelper.initDatabase();
      var response = await provider.post(
        Env.baseUrl + UrlEndpoint.product,
        jsonEncode(product.toJson()),
      );
      var newProduct = Product.fromJson(response);
      databaseHelper.storeData({
        "collectionName": DbConstant.collectionProduct,
        "product": newProduct,
      });
      return newProduct;
    } catch (e) {
      log("Error adding product: $e");
      throw Exception("Failed to add product");
    }
  }
}
