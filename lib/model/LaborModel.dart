
import 'package:colleks/Model/LaborModel.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:colleks/parts/shared_prefs.dart';

class LaborModel extends ChangeNotifier {
  List<Labor> laborList = [];
  List<String> stringRewardList = [];

   void initializeApp() async {
    //インスタンスを取得
    await SharePrefs.setInstance();
    //Listにデータを取得させる
    List<String> stringRewardList = SharePrefs.getLaborList();
    stringRewardList.forEach((String stringReward) {
      // String -> Map -> ToDo　の順でcastし、ロードする。
      laborList.add(new Labor.fromJson(json.decode(stringReward)));
    });

    if (laborList.length == 0) {
      laborList = [
    Labor(name: "部屋掃除", point: 3),
    Labor(name: "洗濯", point: 3),
    Labor(name: "ゴミ出し", point: 1),
    Labor(name: "皿洗い", point: 3),
    Labor(name: "料理", point: 5),
    Labor(name: "風呂掃除", point: 3),
    Labor(name: "トイレ掃除", point: 3)
      ];
    }
    notifyListeners();
  }

  void addLabor({@required String name, @required int point}) {
    laborList.add(Labor(name: name, point: point));
    saveLaborList(laborList);
    notifyListeners();
  }

  void addLaborModel({@required Labor labor}) {
    laborList.add(labor);
    saveLaborList(laborList); 
    notifyListeners();
  }

    void removeLabor(@required int index) {
    laborList.removeAt(index);
    saveLaborList(laborList);
    notifyListeners();
  }

  void replaceLabor(@required int index, @required Labor labor) {
    laborList[index] = labor;
    saveLaborList(laborList);
    notifyListeners();
  }
  
    void saveLaborList(List<Labor> rewardList) {
    stringRewardList.clear();
    rewardList.forEach((Labor reward) {
      // Todoオブジェクト -> Map -> String の順でエンコード
      var encoded = json.encode(reward.toJson());
      stringRewardList.add(encoded);
    });
    // 一度、sharedpreference上に永続化されているリストをクリアする。
    SharePrefs.deleteLaborList();
    // 永続化
    SharePrefs.setLaborList(stringRewardList);
  }
}

class Labor {  
  String name;
  int point;

  Labor({@required this.name, @required this.point});

  Labor.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        point = json['point'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'point': point,
      };
}
