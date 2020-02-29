import 'package:colleks/model/PasswordModel.dart';
import 'package:colleks/model/PointModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

class PointChangePage extends StatelessWidget {
  final pointPlusController = TextEditingController();
  final pointMinusController = TextEditingController();
  final passwordInputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer2<PasswordModel, PointModel>(
        builder: (context, passwordModel, pointModel, child) {
      return Scaffold(
          appBar: AppBar(
            leading: IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () => Navigator.of(context).pop()),
            backgroundColor: Theme.of(context).primaryColor,
            elevation: 0.0,
            title: const Text("ポイント変更"),
          ),
          body: Column(children: <Widget>[
            Center(
                child: Container(
                    width: 300.0,
                    child: TextFormField(
                        controller: pointPlusController,
                        autocorrect: false,
                        decoration: new InputDecoration(
                          border: const UnderlineInputBorder(),
                          labelText: '追加ポイント',
                        ),
                        obscureText: true,
                        maxLength: 5,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          WhitelistingTextInputFormatter.digitsOnly
                        ]))),
            RaisedButton(
              child: Text("追加"),
              shape: UnderlineInputBorder(),
              onPressed: () {
                AwesomeDialog(
                    context: context,
                    animType: AnimType.SCALE,
                    dialogType: DialogType.INFO,
                    body: Center(
                      child: Text(
                        pointModel.totalPoint.toString() +
                            " +" +
                            pointPlusController.text.toString() +
                            " = " +
                            (pointModel.totalPoint +
                                    int.parse(pointPlusController.text))
                                .toString() +
                            " point になります！ \追加しますか?",
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                    tittle: 'This is Ignored',
                    desc: 'This is also Ignored',
                    btnCancelOnPress: () {},
                    btnOkOnPress: () {
                      pointModel.addTotalPointWithoutLabor(
                          point: int.parse(pointPlusController.text));

                      AwesomeDialog(
                        context: context,
                        animType: AnimType.SCALE,
                        dialogType: DialogType.SUCCES,
                        body: Center(
                          child: Text(
                            'ポイントの追加が完了しました！',
                            style: TextStyle(fontStyle: FontStyle.italic),
                          ),
                        ),
                        tittle: 'This is Ignored',
                        desc: 'This is also Ignored',
                        btnOkOnPress: () {
                          // Navigator.pop(context);
                        },
                      ).show();
                      pointPlusController.clear();
                    }).show();
              },
            ),
            Center(
                child: Container(
                    width: 300.0,
                    child: TextFormField(
                        controller: pointMinusController,
                        autocorrect: false,
                        decoration: new InputDecoration(
                          border: const UnderlineInputBorder(),
                          labelText: '削除',
                        ),
                        obscureText: true,
                        maxLength: 5,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          WhitelistingTextInputFormatter.digitsOnly
                        ]))),
            RaisedButton(
              child: const Text("削除"),
              shape: UnderlineInputBorder(),
              onPressed: () {
                if ((pointModel.totalPoint -
                        int.parse(pointMinusController.text)) <
                    0) {
                  AwesomeDialog(
                    context: context,
                    animType: AnimType.SCALE,
                    dialogType: DialogType.ERROR,
                    body: Center(
                      child: Text(
                        'ポイントがマイナスになります。最大' +
                            pointModel.totalPoint.toString() +
                            'の削減が可能です！',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                    tittle: 'This is Ignored',
                    desc: 'This is also Ignored',
                    btnOkOnPress: () {},
                  ).show();
                } else {
                  AwesomeDialog(
                      context: context,
                      animType: AnimType.SCALE,
                      dialogType: DialogType.INFO,
                      body: Center(
                        child: Text(
                          pointModel.totalPoint.toString() +
                              " -" +
                              pointMinusController.text.toString() +
                              " = " +
                              (pointModel.totalPoint -
                                      int.parse(pointMinusController.text))
                                  .toString() +
                              " point になります！ \削減しますか?",
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ),
                      tittle: 'This is Ignored',
                      desc: 'This is also Ignored',
                      btnCancelOnPress: () {},
                      btnOkOnPress: () {
                        pointModel.decreaseTotalPointWithoutReward(
                            point: int.parse(pointMinusController.text));

                        AwesomeDialog(
                          context: context,
                          animType: AnimType.SCALE,
                          dialogType: DialogType.SUCCES,
                          body: Center(
                            child: const Text(
                              'ポイントの追加が完了しました！',
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ),
                          ),
                          tittle: 'This is Ignored',
                          desc: 'This is also Ignored',
                          btnOkOnPress: () {
                            // Navigator.pop(context);
                          },
                        ).show();
                        pointMinusController.clear();
                      }).show();
                }
              },
            ),
            Text(""),
            Container(
                width: 300,
                child: const Text(
                  "ここで追加・削減されたポイントは履歴画面には表示されません。",
                  style:
                      TextStyle(color: Colors.red, fontStyle: FontStyle.italic),
                )),
          ]));
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
