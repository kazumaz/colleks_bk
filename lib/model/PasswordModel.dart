import 'package:flutter/material.dart';
import 'package:colleks/parts/shared_prefs.dart';

class PasswordModel extends ChangeNotifier {
  String password = null; //ToDo ここを永続化先から取得するようにする

    void initializeApp() async {
    //インスタンスを取得
    await SharePrefs.setInstance();
    password = SharePrefs.getPassword();    
    notifyListeners();
  }

  void savePassword(String password) {
    // 永続化
    SharePrefs.setPassword(password);
  }

  void setPassword({@required String newPassword}) {
    password = newPassword;    
    savePassword(password);
    notifyListeners();
  }

  bool isValidPassword({@required String checkPassword}) {
    return (password == checkPassword);
  }

  bool checkPassworIsAlreadyExist() {
    if (password == null) {
      return false;
    }
    else {
      return true;
    }

  }
}

