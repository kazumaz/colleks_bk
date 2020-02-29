import 'package:flutter/material.dart';

class PointModel extends ChangeNotifier {
  int totalPoint = 22; //ToDo ここを永続化先から取得するようにする
  int totalPointEver = 22; //ToDo ここを永続化先から取得するようにする
  int totalLaborEver = 7; //ToDo ここを永続化先から取得するようにする
  int totalRewardEver = 2; //ToDo ここを永続化先から取得するようにする
  
  
//お手伝いを実施し、ポイントを付与する時に使う。
  void addTotalPoint({@required int point}) {
    totalPoint += point;
    totalPointEver += point;
    totalLaborEver ++;
    notifyListeners();
  }

//ご褒美をもらい、ポイントを減算する時に使う。
  void decreaseTotalPoint({@required int point}) {
    totalPoint -= point;    
    totalRewardEver++;
    notifyListeners();
  }

  //ポイントを追加する時に使う
  void addTotalPointWithoutLabor({@required int point}) {
    totalPoint += point;
    totalPointEver += point;    
    notifyListeners();
  }

  //ご褒美をもらい、ポイントを減算する時に使う。
  void decreaseTotalPointWithoutReward({@required int point}) {
    totalPoint -= point;        
    notifyListeners();
  }

//履歴削除の時に使う。今までの履歴も戻す。
  void decreaseTotalPointWithEver({@required int point}) {
    totalPoint -= point;
    totalPointEver -= point;
    totalLaborEver --;
    notifyListeners();
  }

  void increaseTotalPointWithEver({@required int point}) {
    totalPoint += point;    
    notifyListeners();
    totalRewardEver--;
  }
}