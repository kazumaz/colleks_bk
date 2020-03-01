import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharePrefs {
  //ここで文字列の型を作成します。あとはパーケージが保存してくれます。
  static final rewardList = "rewardList";
  static final laborList = "laborList";
  static final historyList = "historyList";
  static final color = "color";
  static final totalPoint = "totalPoint";
  static final totalPointEver = "totalPointEver";
  static final totalLaborEver = "totalLaborEver";
  static final totalRewardEver = "totalRewardEver";
  static final password = "password";
  static final pointChangePageRockState = "pointChangePageRockState";
  static final laborGetRockState = "laborGetRockState";

  static SharedPreferences _sharedPreferences;

  static Future setInstance() async {
    if (null != _sharedPreferences) return;
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  //setStringList()によって変更されたデータを更新し、新しいデータが方に保存されます。
  //getStringList()はinitState()(そのページに切り替わったとき)、Shared Preferenceから保存されたデータを呼び出す役割をします。


//Reward
  static Future<bool> setRewardList(List<String> value) =>
      _sharedPreferences.setStringList(rewardList, value);

  static List<String> getRewardList() =>
      _sharedPreferences.getStringList(rewardList) ?? [];

  static void deleteRewardList() => _sharedPreferences.remove(rewardList);


//Labor
  static Future<bool> setLaborList(List<String> value) =>
      _sharedPreferences.setStringList(laborList, value);

  static List<String> getLaborList() =>
      _sharedPreferences.getStringList(laborList) ?? [];

  static void deleteLaborList() => _sharedPreferences.remove(laborList);

//History
  static Future<bool> setHistoryList(List<String> value) =>
      _sharedPreferences.setStringList(historyList, value);

  static List<String> getHistoryList() =>
      _sharedPreferences.getStringList(historyList) ?? [];

  static void deleteHistoryList() => _sharedPreferences.remove(historyList);

//Color
  static Future<bool> setColor(String value) =>
      _sharedPreferences.setString(color, value);

  static String getColor() =>
      _sharedPreferences.getString(color) ?? "green";

  static void deleterColor() => _sharedPreferences.remove(color);

//point
  //total point
  static Future<bool> setTotalPoint(int value) =>
      _sharedPreferences.setInt(totalPoint, value);

  static int getTotalPoint() =>
      _sharedPreferences.getInt(totalPoint) ?? 3;

  static void deleteTotalPoint() => _sharedPreferences.remove(totalPoint);

  //total pointever 
  static Future<bool> setTotalPointEver(int value) =>
      _sharedPreferences.setInt(totalPointEver, value);

  static int getTotalPointEver() =>
      _sharedPreferences.getInt(totalPointEver) ?? 3;

  static void deleteTotalPointEver() => _sharedPreferences.remove(totalPointEver);

 //total labor ever
  static Future<bool> setTotalLaborEver(int value) =>
      _sharedPreferences.setInt(totalLaborEver, value);

  static int getTotalLaborEver() =>
      _sharedPreferences.getInt(totalLaborEver) ?? 0;

  static void deleteTotalLaborEver() => _sharedPreferences.remove(totalLaborEver);

//total reward ever
  static Future<bool> setTotalRewardEver(int value) =>
      _sharedPreferences.setInt(totalRewardEver, value);

  static int getTotalRewardEver() =>
      _sharedPreferences.getInt(totalRewardEver) ?? 0;

  static void deleteTotalRewardEver() => _sharedPreferences.remove(totalRewardEver);

//password
  static Future<bool> setPassword(String value) =>
      _sharedPreferences.setString(password, value);

  static String getPassword() =>
      _sharedPreferences.getString(password) ?? null;

  static void deletePassword() => _sharedPreferences.remove(color);

//rock model
  static Future<bool> setPointChangePageRockState(bool value) =>
      _sharedPreferences.setBool(pointChangePageRockState, value);

  static bool getPointChangePageRockState() =>
      _sharedPreferences.getBool(pointChangePageRockState) ?? false;


  static Future<bool> setLaborGetRockState(bool value) =>
      _sharedPreferences.setBool(laborGetRockState, value);

  static bool getLaborGetRockState() =>
      _sharedPreferences.getBool(laborGetRockState) ?? false;

}