import '../app/env.dart';
import '../http/http_provider.dart';

class BaseRepository {
  HttpProvider provider = HttpProvider();
  final String baseUrl = Env.baseUrl;
}
