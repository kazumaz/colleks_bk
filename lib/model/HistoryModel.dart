import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:colleks/parts/shared_prefs.dart';
import "package:intl/intl.dart";
import 'package:intl/date_symbol_data_local.dart';

class HistoryModel extends ChangeNotifier {
  List<History> historyList = [
  ];   
  List<String> stringHistoryList = [];

     void initializeApp() async {
    //インスタンスを取得
    await SharePrefs.setInstance();
    //Listにデータを取得させる
    List<String> stringHistoryList = SharePrefs.getHistoryList();
    stringHistoryList.forEach((String stringHistory) {
      // String -> Map -> ToDo　の順でcastし、ロードする。
      historyList.add(new History.fromJson(json.decode(stringHistory)));
    });

    if (historyList.length == 0) {
      // nothing todo
    }
    notifyListeners();
  }

  void addHistory(
      {@required String dateTime,
      @required String name,
      @required int point,
      @required bool sign}) {
    historyList
        .add(History(dateTime: dateTime, name: name, point: point, sign: sign));
    saveHistoryList(historyList);
    notifyListeners();
  }

  void addHistoryModel({@required History history}) {
    historyList.add(history);
    saveHistoryList(historyList);
    notifyListeners();
  }

  void removeHistory(@required int index) {
    historyList.removeAt(index);
    saveHistoryList(historyList);
    notifyListeners();
  }

  void removeAllHistory() {
    historyList = [];
    saveHistoryList(historyList);
    notifyListeners();
  }

    void saveHistoryList(List<History> rewardList) {
    stringHistoryList.clear();
    historyList.forEach((History history) {
      // Todoオブジェクト -> Map -> String の順でエンコード
      var encoded = json.encode(history.toJson());
      stringHistoryList.add(encoded);
    });
    // 一度、sharedpreference上に永続化されているリストをクリアする。
    SharePrefs.deleteHistoryList();
    // 永続化
    SharePrefs.setHistoryList(stringHistoryList);
  }
}

class History {
  String dateTime;
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
