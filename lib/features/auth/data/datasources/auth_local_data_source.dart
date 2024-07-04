import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

@injectable
class AuthLocalDataSource {
  AuthLocalDataSource(
    this.secureStorage,
  );

  final FlutterSecureStorage secureStorage;

  Future<void> saveCookie(String cookie) {
    return secureStorage.write(key: 'cookie', value: cookie);
  }

  Future<void> saveUsername(String username) {
    return secureStorage.write(key: 'username', value: username);
  }

  Future<String?> getCookie() {
    return secureStorage.read(key: 'cookie');
  }

  Future<String?> getUsername() {
    return secureStorage.read(key: 'username');
  }

  Future<void> clearCookie() {
    return secureStorage.delete(key: 'cookie');
  }

  Future<void> clearUsername() {
    return secureStorage.delete(key: 'username');
  }
}
