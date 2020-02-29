import 'package:flutter/material.dart';

class ColorModel extends ChangeNotifier {
  Color themaColor = Colors.purple;
  void setBlue() {
    themaColor = Colors.blue;
    notifyListeners();
  }

  void setRed() {
    themaColor = Colors.red;
    notifyListeners();
  }

  void setPurple() {
    themaColor = Colors.purple;
    notifyListeners();
  }

  void setPink() {
    themaColor = Colors.pink;
    notifyListeners();
  }

  void setOrange() {
    themaColor = Colors.orange;
    notifyListeners();
  }

  void setCyan() {
    themaColor = Colors.cyan;
    notifyListeners();
  }

  void setTeal() {
    themaColor = Colors.teal;
    notifyListeners();
  }

  void setIndigo() {
    themaColor = Colors.indigo;
    notifyListeners();
  }

  void setBrown() {
    themaColor = Colors.brown;
    notifyListeners();
  }

  void setYellow() {
    themaColor = Colors.yellow;
    notifyListeners();
  }

    void setBlueGray() {
    themaColor = Colors.blueGrey;
    notifyListeners();
  }

    void setDeepOrange() {
    themaColor = Colors.deepOrange;
    notifyListeners();
  }

    void setDeepPurple() {
    themaColor = Colors.deepPurple;
    notifyListeners();
  }

    void setGrey() {
    themaColor = Colors.grey;
    notifyListeners();
  }

    void setLightGreen() {
    themaColor = Colors.lightGreen;
    notifyListeners();
  }
}