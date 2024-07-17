import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesData {

  static Future<List<String>> getCurrencies() async {
    final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    return sharedPrefs.getStringList("currency_list") ?? [];
  }

  static setCurrencies(List<String> value) async {
    final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    sharedPrefs.setStringList("currency_list", value);
  }
}
