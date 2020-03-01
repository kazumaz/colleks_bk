import 'package:flutter/material.dart';
import 'package:colleks/parts/shared_prefs.dart';

class ColorModel extends ChangeNotifier {
  Color themaColor;
  String stringThemaColor;

  void initializeApp() async {
    //インスタンスを取得
    await SharePrefs.setInstance();
    String stringThemaColor = SharePrefs.getColor();
    print(stringThemaColor);
    themaColor = getColorClassFromString(stringThemaColor);
    print(themaColor.toString());
    notifyListeners();    
  }

  void saveColor(String color) {
    // 永続化
    SharePrefs.setColor(color);
  }

  void setBlue() {
    themaColor = Colors.blue;
    saveColor("blue");
    notifyListeners();
  }

  void setRed() {
    themaColor = Colors.red;
    saveColor("red");
    notifyListeners();
  }

  void setPurple() {
    themaColor = Colors.purple;
    saveColor("purple");
    notifyListeners();
  }

  void setPink() {
    themaColor = Colors.pink;
    saveColor("pink");
    notifyListeners();
  }

  void setOrange() {
    themaColor = Colors.orange;
    saveColor("orange");
    notifyListeners();
  }

  void setCyan() {
    themaColor = Colors.cyan;
    saveColor("cyan");
    notifyListeners();
  }

  void setTeal() {
    themaColor = Colors.teal;
    saveColor("teal");
    notifyListeners();
  }

  void setIndigo() {
    themaColor = Colors.indigo;
    saveColor("indigo");
    notifyListeners();
  }

  void setBrown() {
    themaColor = Colors.brown;
    saveColor("brown");
    notifyListeners();
  }

  void setYellow() {
    themaColor = Colors.yellow;
    saveColor("yellow");
    notifyListeners();
  }

  void setBlueGray() {
    themaColor = Colors.blueGrey;
    saveColor("blueGrey");
    notifyListeners();
  }

  void setDeepOrange() {
    themaColor = Colors.deepOrange;
    saveColor("deepOrange");
    notifyListeners();
  }

  void setDeepPurple() {
    themaColor = Colors.deepPurple;
    saveColor("deepPurple");
    notifyListeners();
  }

  void setGrey() {
    themaColor = Colors.grey;
    saveColor("grey");
    notifyListeners();
  }

  void setLightGreen() {
    themaColor = Colors.lightGreen;
    saveColor("lightGreen");
    notifyListeners();
  }

  Color getColorClassFromString(String stringColor) {
    Color color;
    switch (stringColor) {
      case 'blue':
        color = Colors.blue;
        break;
      case 'red':
        color = Colors.red;
        break;
      case 'purple':
        color = Colors.purple;
        break;
      case 'pink':
        color = Colors.pink;
        break;
      case 'orange':
        color = Colors.orange;
        break;
      case 'cyan':
        color = Colors.cyan;
        break;
      case 'teal':
        color = Colors.teal;
        break;
      case 'indigo':
        color = Colors.indigo;
        break;
      case 'brown':
        color = Colors.brown;
        break;
      case 'yellow':
        color = Colors.yellow;
        break;
      case 'blueGrey':
        color = Colors.blueGrey;
        break;
      case 'deepOrange':
        color = Colors.deepOrange;
        break;
      case 'deepPurple':
        color = Colors.deepPurple;
        break;
      case 'grey':
        color = Colors.grey;
        break;
      case 'lightGreen':
        color = Colors.lightGreen;
        break;
    }

    return color;
  }
}
