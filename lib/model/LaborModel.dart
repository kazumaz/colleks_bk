
import 'package:colleks/Model/LaborModel.dart';
import 'package:flutter/material.dart';

class LaborModel extends ChangeNotifier {  

  List<Labor> laborList = [
    Labor(name: "掃除", point: 3),
    Labor(name: "洗濯", point: 3),
    Labor(name: "お皿洗い", point: 3),
    Labor(name: "料理", point: 3),
    Labor(name: "風呂掃除", point: 3),
    Labor(name: "トイレ掃除", point: 3)
  ];

  void addLabor({@required String name, @required int point}) {
    laborList.add(Labor(name: name, point: point));        
    notifyListeners();
  }

  void addLaborModel({@required Labor labor}) {
    laborList.add(labor);    
    notifyListeners();
  }

    void removeLabor(@required int index) {
    laborList.removeAt(index);
    notifyListeners();
  }

  void replaceLabor(@required int index, @required Labor labor) {
    laborList[index] = labor;
    notifyListeners();
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
