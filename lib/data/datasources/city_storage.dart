import 'package:shared_preferences/shared_preferences.dart';

class CityStorage {
  static const _key = 'last_city';

  Future<void> saveCity(String city) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, city);
  }

  Future<String> loadCity() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_key) ?? 'Delhi'; 
  }
}
