import 'package:hive/hive.dart';
import 'package:mobile_app_labamu/core/constant/db_constant.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  void initDatabase() async {
    final dir = await getApplicationDocumentsDirectory();
    final collection = await BoxCollection.open(
      DbConstant.databaseName,
      {DbConstant.collectionProduct},
      path: dir.path,
    );

    await collection.openBox<Map>(DbConstant.collectionProduct);
  }

  void storeData(params) async {
    final dir = await getApplicationDocumentsDirectory();
    final collection = await BoxCollection.open(
      DbConstant.databaseName,
      {params["collectionName"]},
      path: dir.path,
    );

    final boxCollection = await collection.openBox<Map>(
      params['collectionName'],
    );

    await boxCollection.put(
      params['product'].id.toString(),
      params['product'].toJson(),
    );
  }

  dynamic fetchData(params) async {
    final dir = await getApplicationDocumentsDirectory();
    final collection = await BoxCollection.open(
      DbConstant.databaseName,
      {params["collectionName"]},
      path: dir.path,
    );

    final boxCollection = await collection.openBox<Map>(
      params['collectionName'],
    );

    var data = await boxCollection.get(params['product'].id);
    return data;
  }

  dynamic fetchAllData(params) async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final collection = await BoxCollection.open(
        DbConstant.databaseName,
        {params["collectionName"]},
        path: dir.path,
      );

      final boxCollection = await collection.openBox<Map>(
        params['collectionName'],
      );

      var data = await boxCollection.getAll(params['product']);
      return data;
    } catch (e) {
      return null;
    }
  }
}
