import 'package:shared_preferences/shared_preferences.dart';

class SharePrefs {
  //ここで文字列の型を作成します。あとはパーケージが保存してくれます。
  static final rewardList = "rewardList";
  static final laborList = "laborList";
  // static final counter = "counter";
  static SharedPreferences _sharedPreferences;

  static Future setInstance() async {
    if (null != _sharedPreferences) return;
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  //setStringList()によって変更されたデータを更新し、新しいデータが方に保存されます。
  //getStringList()はinitState()(そのページに切り替わったとき)、Shared Preferenceから保存されたデータを呼び出す役割をします。

  static Future<bool> setRewardList(List<String> value) =>
      _sharedPreferences.setStringList(rewardList, value);

  static List<String> getRewardList() =>
      _sharedPreferences.getStringList(rewardList) ?? [];

  static void deleteRewardList() => _sharedPreferences.remove(rewardList);

  static Future<bool> setLaborList(List<String> value) =>
      _sharedPreferences.setStringList(laborList, value);

  static List<String> getLaborList() =>
      _sharedPreferences.getStringList(laborList) ?? [];

  static void deleteLaborList() => _sharedPreferences.remove(laborList);

  // static Future<bool> setCounter(int value) =>
  //     _sharedPreferences.setInt(counter, value);

  // static int getCounter() =>
  //     _sharedPreferences.getInt(counter) ?? 0;
  // static void deleteCounter() => _sharedPreferences.remove(counter);
}