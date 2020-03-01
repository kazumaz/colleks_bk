import 'package:flutter/material.dart';
import 'package:colleks/parts/shared_prefs.dart';

class LockModel extends ChangeNotifier {
  bool pointChangePageState = false;
  bool laborGetState = false;

  void initializeApp() async {
    //インスタンスを取得
    await SharePrefs.setInstance();
    pointChangePageState = SharePrefs.getPointChangePageRockState();
    laborGetState = SharePrefs.getLaborGetRockState();
    notifyListeners();
  }

  void saveRockState() {
    // 永続化
    SharePrefs.setPointChangePageRockState(pointChangePageState);
    SharePrefs.setLaborGetRockState(laborGetState);
  }

  void changeLockStateOfPointChangePageState() {
    pointChangePageState = !pointChangePageState;
    saveRockState();
    notifyListeners();
  }

  void changeLockStateOfLaborGetState() {
    laborGetState = !laborGetState;
    saveRockState();
    notifyListeners();
  }
}
