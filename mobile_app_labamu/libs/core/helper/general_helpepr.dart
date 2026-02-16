import 'package:mobile_app_labamu/core/constant/app_constant.dart';
import 'package:encrypt_shared_preferences/provider.dart';

class GeneralHelper {
  Future<void> store(String key, dynamic value) async {
    await EncryptedSharedPreferences.initialize(AppConstant.secureStorage);
    var preferences = EncryptedSharedPreferences.getInstance();
    await preferences.setString(key, value);
  }

  Future<dynamic> read(String key) async {
    await EncryptedSharedPreferences.initialize(AppConstant.secureStorage);
    var preferences = EncryptedSharedPreferences.getInstance();
    dynamic value = preferences.getString(key);
    return value;
  }

  Future<dynamic> remove(String key) async {
    await EncryptedSharedPreferences.initialize(AppConstant.secureStorage);
    var preferences = EncryptedSharedPreferences.getInstance();
    dynamic value = preferences.remove(key);
    return value;
  }
}
