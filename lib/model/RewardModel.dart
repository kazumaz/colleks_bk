import 'package:flutter/material.dart';

class RewordModel extends ChangeNotifier {

  List<Reward> rewardList = [ 
    Reward(name: "お菓子", point: 3),
    Reward(name: "遊園地", point: 40),
    Reward(name: "ディズニー", point: 10000),
    Reward(name: "おもちゃ", point: 10),
    Reward(name: "うまい棒", point: 1),
  ];

  // List<Reward> rewardList = []; //Todo 永続化先から読み込めるようにする。  

  void addReward({@required String name, @required int point}) {
    rewardList.add(Reward(name: name, point: point));    
    notifyListeners();
  }

  void addRewardModel({@required Reward reward}) {
    rewardList.add(reward);    
    notifyListeners();
  }

  void removeReward(@required int index) {
    rewardList.removeAt(index);
    notifyListeners();
  }

  void replaceReward(@required int index, @required Reward reward) {
    rewardList[index] = reward;
    notifyListeners();
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


