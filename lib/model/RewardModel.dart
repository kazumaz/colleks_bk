import 'package:flutter/material.dart';
import 'package:colleks/parts/shared_prefs.dart';
import 'dart:convert';
import 'package:colleks/parts/shared_prefs.dart';

class RewordModel extends ChangeNotifier {
  List<Reward> rewardList = [];
  List<String> stringRewardList = [];

  void initializeApp() async {
    //インスタンスを取得
    await SharePrefs.setInstance();
    //Listにデータを取得させる
    List<String> stringRewardList = SharePrefs.getRewardList();
    stringRewardList.forEach((String stringReward) {
      // String -> Map -> ToDo　の順でcastし、ロードする。
      rewardList.add(new Reward.fromJson(json.decode(stringReward)));
    });

    if (rewardList.length == 0) {
      rewardList = [
        Reward(name: "お菓子", point: 30),
        Reward(name: "お寿司", point: 100),
        Reward(name: "おもちゃ", point: 100),
        Reward(name: "ゲーム", point: 200),
        Reward(name: "遊園地", point: 300),
      ];
    }
    notifyListeners();
  }

  // List<Reward> rewardList = []; //Todo 永続化先から読み込めるようにする。

  void addReward({@required String name, @required int point}) {
    rewardList.add(Reward(name: name, point: point));
    saveRewardList(rewardList);
    notifyListeners();
  }

  void addRewardModel({@required Reward reward}) {
    rewardList.add(reward);
    saveRewardList(rewardList);
    notifyListeners();
  }

  void removeReward(@required int index) {
    rewardList.removeAt(index);
    saveRewardList(rewardList);
    notifyListeners();
  }

  void replaceReward(@required int index, @required Reward reward) {
    rewardList[index] = reward;
    saveRewardList(rewardList);
    notifyListeners();
  }

  void saveRewardList(List<Reward> rewardList) {
    stringRewardList.clear();
    rewardList.forEach((Reward reward) {
      // Todoオブジェクト -> Map -> String の順でエンコード
      var encoded = json.encode(reward.toJson());
      stringRewardList.add(encoded);
    });
    // 一度、sharedpreference上に永続化されているリストをクリアする。
    SharePrefs.deleteRewardList();
    // 永続化
    SharePrefs.setRewardList(stringRewardList);
  }
}

class Reward {
  String name;
  int point;

  Reward({@required this.name, @required this.point});

  Reward.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        point = json['point'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'point': point,
      };
}
