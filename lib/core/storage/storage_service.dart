
import 'local/local_storage.dart';
import 'secure/secure_storage.dart';

class StorageService {
  StorageService(this._local, this._secure);

  final LocalStorage _local;
  final SecureStorage _secure;

  // Local (sync)
  T? localRead<T>(String key) => _local.read<T>(key);
  Future<void> localWrite<T>(String key, T value) => _local.write(key, value);
  Future<void> localDelete(String key) => _local.delete(key);
  Future<void> localClear() => _local.clear();
  bool localContains(String key) => _local.containsKey(key);

  // Secure (async)
  Future<String?> secureRead(String key) => _secure.read(key);
  Future<void> secureWrite(String key, String value) => _secure.write(key, value);
  Future<void> secureDelete(String key) => _secure.delete(key);
  Future<Map<String, String>> secureReadAll() => _secure.readAll();

  // Combined delete (logout)
  Future<void> deleteAll() async {
    await Future.wait([_secure.deleteAll(), _local.clear()]);
  }
}
