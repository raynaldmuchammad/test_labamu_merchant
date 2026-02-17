import 'package:hive/hive.dart';
import 'package:mobile_app_labamu/core/constant/db_constant.dart';

class DatabaseHelper {
  //
  void initDatabase(params) async {
    final collection = await BoxCollection.open(
      DbConstant.databaseName,
      {DbConstant.collectionProduct},
      path: './',
    );

    await collection.openBox<Map>(DbConstant.collectionProduct);
  }

  void storeData(params) async {
    final collection = await BoxCollection.open(
      DbConstant.databaseName,
      {params["collectionName"]},
      path: './',
    );

    final boxCollection = await collection.openBox<Map>(
      params['collectionName'],
    );

    await boxCollection.put(params['product'].id, params['product']);
  }

  dynamic fetchData(params) async {
    final collection = await BoxCollection.open(
      DbConstant.databaseName,
      {params["collectionName"]},
      path: './',
    );

    final boxCollection = await collection.openBox<Map>(
      params['collectionName'],
    );

    var data = await boxCollection.get(params['product'].id);
    return data;
  }
}
