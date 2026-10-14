import 'package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart';
import 'package:shared_preferences_platform_interface/types.dart';

final class MockSharedPreferencesAsyncPlatform
    extends SharedPreferencesAsyncPlatform {
  final Map<String, Object> _values = {};

  @override
  Future<void> setStringList(
      String key,
      List<String> value,
      SharedPreferencesOptions options,
      ) async {
    _values[key] = List<String>.from(value);
  }

  @override
  Future<List<String>?> getStringList(
      String key,
      SharedPreferencesOptions options,
      ) async {
    final value = _values[key];
    return value is List<String> ? List<String>.from(value) : null;
  }

  @override
  Future<void> clear(
      ClearPreferencesParameters parameters,
      SharedPreferencesOptions options,
      ) async {
    _values.clear();
  }

  @override
  Future<Map<String, Object>> getPreferences(
      GetPreferencesParameters parameters,
      SharedPreferencesOptions options,
      ) async {
    return Map<String, Object>.from(_values);
  }

  @override
  Future<Set<String>> getKeys(
      GetPreferencesParameters parameters,
      SharedPreferencesOptions options,
      ) async {
    return _values.keys.toSet();
  }

  @override
  Future<String?> getString(
      String key,
      SharedPreferencesOptions options,
      ) async => _values[key] as String?;

  @override
  Future<bool?> getBool(
      String key,
      SharedPreferencesOptions options,
      ) async => _values[key] as bool?;

  @override
  Future<double?> getDouble(
      String key,
      SharedPreferencesOptions options,
      ) async => _values[key] as double?;

  @override
  Future<int?> getInt(
      String key,
      SharedPreferencesOptions options,
      ) async => _values[key] as int?;

  @override
  Future<void> setString(
      String key,
      String value,
      SharedPreferencesOptions options,
      ) async {
    _values[key] = value;
  }

  @override
  Future<void> setBool(
      String key,
      bool value,
      SharedPreferencesOptions options,
      ) async {
    _values[key] = value;
  }

  @override
  Future<void> setDouble(
      String key,
      double value,
      SharedPreferencesOptions options,
      ) async {
    _values[key] = value;
  }

  @override
  Future<void> setInt(
      String key,
      int value,
      SharedPreferencesOptions options,
      ) async {
    _values[key] = value;
  }
}
