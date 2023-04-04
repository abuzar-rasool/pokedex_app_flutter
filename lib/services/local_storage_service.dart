import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  SharedPreferences? _preferences;

  Future<void> init() async {
    _preferences ??= await SharedPreferences.getInstance();
  }

  Future<void> addStringListItem(String key, String value) async {
    await init();
    List<String> items = _preferences!.getStringList(key) ?? [];
    items.add(value);
    await _preferences!.setStringList(key, items);
  }

  Future<void> removeStringListItem(String key, String value) async {
    await init();
    List<String> items = _preferences!.getStringList(key) ?? [];
    items.remove(value);
    await _preferences!.setStringList(key, items);
  }

  Future<List<String>> getStringList(String key) async {
    await init();
    return _preferences!.getStringList(key) ?? [];
  }
}
