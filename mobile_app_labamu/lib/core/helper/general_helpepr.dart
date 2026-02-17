import '../constant/app_constant.dart';
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

  String formatIdr(dynamic value) {
    if (value == null) return '';
    final numVal = value is num ? value : num.tryParse(value.toString()) ?? 0;
    final intPart = numVal.truncate();
    final intPartStr = intPart.toString().replaceAllMapped(
          RegExp(r'\B(?=(\d{3})+(?!\d))'),
          (m) => '.',
        );
    return 'Rp $intPartStr';
  }
}
