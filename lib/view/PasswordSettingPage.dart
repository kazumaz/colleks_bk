import 'package:colleks/model/PasswordModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class PassWordSettingPage extends StatelessWidget {
  final passwordInputController = TextEditingController();
  final passwordInputConfirmController = TextEditingController();
  final beforePasswordInputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<PasswordModel>(builder: (context, passwordModel, child) {
      return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () => Navigator.of(context).pop(),
            ),
            backgroundColor: Theme.of(context).primaryColor,
            elevation: 0.0,
            title: const Text("パスワード管理画面"),
          ),
          body: Column(
            children: <Widget>[
              Center(
                  child: Container(
                      width: 300.0,
                      child: TextFormField(
                        controller: passwordInputController,
                        autocorrect: false,
                        decoration: new InputDecoration(
                          border: const UnderlineInputBorder(),
                          labelText: '確認用',
                        ),
                        obscureText: true,
                      ))),
              Center(
                  child: Container(
                      width: 300.0,
                      child: TextFormField(
                        controller: passwordInputConfirmController,
                        autocorrect: false,
                        decoration: new InputDecoration(
                          border: const UnderlineInputBorder(),
                          labelText: 'パスワード',
                        ),
                        obscureText: true,
                      ))),
              Text(""),
              Container(
                  width: 300,
                  child: const Text(
                    "セキュリティ強化のため、パスワードの再発行はできないようにしてあります。",
                    style: TextStyle(
                        color: Colors.red, fontStyle: FontStyle.italic),
                  )),
              const Text(""),
              RaisedButton(
                child: const Text("登録"),
                shape: UnderlineInputBorder(),
                onPressed: () {
                  if (passwordInputController.text.length > 0) {
                    if (checkPasswordConfirmed(
                        passwordInputController.text.toString(),
                        passwordInputConfirmController.text.toString())) {
                      if (passwordModel.checkPassworIsAlreadyExist()) {
                        AwesomeDialog(
                          context: context,
                          animType: AnimType.SCALE,
                          dialogType: DialogType.INFO,
                          aligment: Alignment.topCenter,
                          body: Center(
                            child: Column(children: <Widget>[
                              Container(
                                  child: const Text(
                                '既存のパスワードを入力してください。',
                                style: TextStyle(fontStyle: FontStyle.italic),
                              )),
                              Container(
                                  width: 200.0,
                                  child: TextField(
                                      controller: beforePasswordInputController,
                                      autofocus: true
                                      // decoration: InputDecoration(
                                      //   // labelText: "編集する場合は入力してください",

                                      ))
                            ]),
                          ),
                          tittle: 'This is Ignored',
                          desc: 'This is also Ignored',
                          btnOkOnPress: () {
                            if (passwordModel.isValidPassword(
                                checkPassword: beforePasswordInputController
                                    .text
                                    .toString())) {
                              AwesomeDialog(
                                context: context,
                                animType: AnimType.SCALE,
                                dialogType: DialogType.SUCCES,
                                body: Center(
                                  child: const Text(
                                    'パスワードの登録が完了しました！',
                                    style:
                                        TextStyle(fontStyle: FontStyle.italic),
                                  ),
                                ),
                                tittle: 'This is Ignored',
                                desc: 'This is also Ignored',
                                btnOkOnPress: () {
                                  passwordModel.setPassword(
                                      newPassword: passwordInputController.text
                                          .toString());
                                  passwordInputController.clear();
                                  passwordInputConfirmController.clear();
                                  beforePasswordInputController.clear();
                                },
                              ).show();

                              passwordModel.setPassword(
                                  newPassword:
                                      passwordInputController.text.toString());
                            } else {
                              AwesomeDialog(
                                context: context,
                                animType: AnimType.SCALE,
                                dialogType: DialogType.ERROR,
                                body: Center(
                                  child: const Text(
                                    'パスワードエラーです。入力し直してください。',
                                    style:
                                        TextStyle(fontStyle: FontStyle.italic),
                                  ),
                                ),
                                tittle: 'This is Ignored',
                                desc: 'This is also Ignored',
                                btnOkOnPress: () {},
                              ).show();
                            }
                          },
                        ).show();
                      } else {
                        AwesomeDialog(
                          context: context,
                          animType: AnimType.SCALE,
                          dialogType: DialogType.SUCCES,
                          body: Center(
                            child: Text(
                              'パスワードの登録が完了しました！',
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ),
                          ),
                          tittle: 'This is Ignored',
                          desc: 'This is also Ignored',
                          btnOkOnPress: () {
                            passwordModel.setPassword(
                                newPassword:
                                    passwordInputController.text.toString());
                            passwordInputController.clear();
                            passwordInputConfirmController.clear();
                            beforePasswordInputController.clear();
                          },
                        ).show();
                      }
                    } else {
                      AwesomeDialog(
                        context: context,
                        animType: AnimType.SCALE,
                        dialogType: DialogType.ERROR,
                        body: Center(
                          child: const Text(
                            '入力した2つのパスワードが一致しません。',
                            style: TextStyle(fontStyle: FontStyle.italic),
                          ),
                        ),
                        tittle: 'This is Ignored',
                        desc: 'This is also Ignored',
                        btnOkOnPress: () {},
                      ).show();
                    }
                  } else {}
                },
              ),
              const Text(""),
              const Text(""),

//               ToggleSwitch(
//                   minWidth: 90.0,
//                   cornerRadius: 20,
//                   activeBgColor: Colors.green,
//                   activeTextColor: Colors.white,
//                   inactiveBgColor: Colors.grey,
//                   inactiveTextColor: Colors.white,
//                   labels: ['ロック', '解除'],
//                   icons: [FontAwesome.lock, FontAwesome.unlock],
//                   activeColors: [Colors.blue, Colors.pink],
//                   initialLabelIndex: 1,
//                   onToggle: (index) {
//                     print('switched to: $index');
//                     index = 0;
//                   })
//                   ,

// LiteRollingSwitch(
//     //initial value
//     value: true,
//     textOn: '解除',
//     textOff: 'ロック',
//     colorOn: Colors.greenAccent[700],
//     colorOff: Colors.redAccent[700],
//     iconOn: Icons.done,
//     iconOff: Icons.remove_circle_outline,
//     textSize: 16.0,
//     onChanged: (bool state) {
//       state = false;
//       //Use it to manage the different states
//       print('Current State of SWITCH IS: $state');
//     },
// ),
            ],
          ));
      // ],
      // ));
    });
  }

  // Widget _passwordForm() {
  //   return Center(
  //       child: Container(
  //           width: 300.0,
  //           child: TextFormField(
  //             controller: passwordInputConfirmController,
  //             autocorrect: false,
  //             decoration: new InputDecoration(
  //               border: const UnderlineInputBorder(),
  //               labelText: 'パスワード',
  //             ),
  //             obscureText: true,
  //           )));
  // }

  Widget _passwordConfirmForm() {
    return Center(
        child: Container(
            width: 300.0,
            child: TextFormField(
              controller: passwordInputController,
              autocorrect: false,
              decoration: new InputDecoration(
                border: const UnderlineInputBorder(),
                labelText: '確認用',
              ),
              obscureText: true,
            )));
  }
}

bool checkPasswordConfirmed(String password, String confirmPassword) {
  if (password == confirmPassword) {
    return true;
  } else {
    return false;
  }
}
