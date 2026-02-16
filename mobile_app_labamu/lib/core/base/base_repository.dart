import 'package:mobile_app_labamu/core/app/env.dart';
import 'package:mobile_app_labamu/core/http/http_provider.dart';

class BaseRepository {
  HttpProvider provider = HttpProvider();
  final String baseUrl = Env.baseUrl;
}
