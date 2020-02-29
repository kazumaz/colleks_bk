import 'package:flutter/material.dart';

class PasswordModel extends ChangeNotifier {
  String password = null; //ToDo ここを永続化先から取得するようにする

  void setPassword({@required String newPassword}) {
    password = newPassword;    
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

