import 'package:hive_flutter/hive_flutter.dart';
import 'local_storage.dart';

class HiveStorage implements LocalStorage {
  HiveStorage(this._box);

  final Box _box;

  @override
  Future<void> write<T>(String key, T value) => _box.put(key, value);

  @override
  T? read<T>(String key) {
    final value = _box.get(key);
    if (value is T) return value;
    return null;
  }

  @override
  Future<void> delete(String key) => _box.delete(key);

  @override
  Future<void> clear() => _box.clear();

  @override
  bool containsKey(String key) => _box.containsKey(key);
}