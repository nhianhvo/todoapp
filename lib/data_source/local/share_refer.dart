import 'package:get_storage/get_storage.dart';
import 'package:injectable/injectable.dart';

class BaseSharedPreferencesRepo {
  final box = GetStorage();

  Future<void> saveData(String key, dynamic value) {
    return box.write(key, value);
  }

  T readData<T>(String key) {
    return box.read(key);
  }
}

@singleton
class SharedPreferencesRepo extends BaseSharedPreferencesRepo {
  final EMAIL_KEY = 'EMAIL_KEY';
  final TOKEN_KEY = 'TOKEN_KEY';

  Future<void> saveEmail(String email) {
    return saveData(EMAIL_KEY, email);
  }

  String getEmail() {
    return readData(EMAIL_KEY);
  }

  Future<void> saveToken(String? token) {
    return saveData(TOKEN_KEY, token);
  }

  String? getToken() {
    return readData(TOKEN_KEY);
  }
}
