import 'package:shared_preferences/shared_preferences.dart';

class Savedata {
  final Future<SharedPreferences> prefs = SharedPreferences.getInstance();
  String? vollue;
  void save(String key, String value) async {
    final SharedPreferences myprefs = await prefs;
    await myprefs.setString(key, value);
  }

  Future lode(String key) async {
    final SharedPreferences myprefs = await prefs;
    var value = myprefs.getString(key);
    return value;
  }

  String getvalue(String key) {
    lode(key);
    return vollue.toString();
  }
}
