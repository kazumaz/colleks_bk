import 'package:flutter/material.dart';

class HistoryModel extends ChangeNotifier {
  List<History> historyList = [
    // History(dateTime: DateTime.now(), name: "掃除", point: 3, sign: true),
    // History(dateTime: DateTime.now(), name: "おやつ", point: 3, sign: false),
    // History(dateTime: DateTime.now(), name: "料理", point: 4, sign: true),
  ];

  void addHistory(
      {@required DateTime dateTime,
      @required String name,
      @required int point,
      @required bool sign}) {
    historyList
        .add(History(dateTime: dateTime, name: name, point: point, sign: sign));
    notifyListeners();
  }

  void addHistoryModel({@required History history}) {
    historyList.add(history);
    notifyListeners();
  }

  void removeHistory(@required int index) {
    historyList.removeAt(index);
    notifyListeners();
  }

  void removeAllHistory() {
    historyList = [];
    notifyListeners();
  }
}

class History {
  DateTime dateTime;
  String name;
  int point;
  bool sign;

  History(
      {@required this.dateTime,
      @required this.name,
      @required this.point,
      @required this.sign});

  History.fromJson(Map<String, dynamic> json)
      : dateTime = json['dateTime'],
        name = json['name'],
        point = json['point'],
        sign = json['sign'];

  Map<String, dynamic> toJson() => {
        'dateTime': dateTime,
        'name': name,
        'point': point,
        'sign': sign,
      };
}
