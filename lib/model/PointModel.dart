import 'package:flutter/material.dart';
import 'package:colleks/parts/shared_prefs.dart';

class PointModel extends ChangeNotifier {
  int totalPoint; 
  int totalPointEver;
  int totalLaborEver;
  int totalRewardEver;

   void initializeApp() async {
    //インスタンスを取得
    await SharePrefs.setInstance();

    totalPoint = SharePrefs.getTotalPoint();
    totalPointEver = SharePrefs.getTotalPointEver();
    totalLaborEver = SharePrefs.getTotalLaborEver();
    totalRewardEver = SharePrefs.getTotalRewardEver();

    notifyListeners();    
  }

  void savePointModel() {
    // 永続化
    SharePrefs.setTotalPoint(totalPoint);
    SharePrefs.setTotalPointEver(totalPointEver);
    SharePrefs.setTotalRewardEver(totalRewardEver);
    SharePrefs.setTotalLaborEver(totalLaborEver);
  }
  
  
//お手伝いを実施し、ポイントを付与する時に使う。
  void addTotalPoint({@required int point}) {
    totalPoint += point;
    totalPointEver += point;
    totalLaborEver ++;
    savePointModel();
    notifyListeners();
  }

//ご褒美をもらい、ポイントを減算する時に使う。
  void decreaseTotalPoint({@required int point}) {
    totalPoint -= point;    
    totalRewardEver++;
    savePointModel();
    notifyListeners();
  }

  //ポイントを追加する時に使う
  void addTotalPointWithoutLabor({@required int point}) {
    totalPoint += point;
    totalPointEver += point;   
    savePointModel(); 
    notifyListeners();
  }

  //ご褒美をもらい、ポイントを減算する時に使う。
  void decreaseTotalPointWithoutReward({@required int point}) {
    totalPoint -= point; 
    savePointModel();       
    notifyListeners();
  }

//履歴削除の時に使う。今までの履歴も戻す。
  void decreaseTotalPointWithEver({@required int point}) {
    totalPoint -= point;
    totalPointEver -= point;
    totalLaborEver --;
    savePointModel();
    notifyListeners();
  }

  void increaseTotalPointWithEver({@required int point}) {
    totalPoint += point;    
    notifyListeners();
    savePointModel();
    totalRewardEver--;
  }
}