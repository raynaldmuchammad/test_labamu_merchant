import 'package:mobile_app_labamu/core/base/base_repository.dart';
import 'package:mobile_app_labamu/core/constant/url_endpoint.dart';

class MainRepository extends BaseRepository {
  Future<Map<String, dynamic>> loadbook(dynamic body) async {
    try {
      var params = UrlEndpoint.bookUrl;
      if (body['keywords'] != null) {
        params = "$params?search=${body['keywords']}";
      }

      var response = await provider.get("$baseUrl/$params");
      return response;
    } on Error catch (e) {
      throw Exception("Failed to get user approval: $e");
    }
  }
}
