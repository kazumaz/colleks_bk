import 'package:colleks/model/LaborModel.dart';
import 'package:colleks/model/PointModel.dart';
import 'package:colleks/model/HistoryModel.dart';
import 'package:colleks/model/LockModel.dart';
import 'package:colleks/model/PasswordModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import 'package:tutorial_coach_mark/animated_focus_light.dart';
import 'package:intl/intl.dart';

class LaborPage extends StatelessWidget {
  List<TargetFocus> targets = List();
  GlobalKey keyButton1 = GlobalKey();
  GlobalKey keyButton2 = GlobalKey();

  final myLaborNameController = TextEditingController();
  final myLaborPointController = TextEditingController();
  final passwordInputController = TextEditingController();
  bool datePicked = false;
  DateTime selectedDate;
  DateFormat dateFormat_YYYY_MM_DD = DateFormat("yyyy-MM-dd");

  @override
  Widget build(BuildContext context) {
    return Consumer5<LaborModel, PointModel, HistoryModel, LockModel,
            PasswordModel>(
        builder: (context, laborModel, pointModel, historyModel, lockModel,
            passwordModel, child) {
      return Scaffold(
          appBar: AppBar(title: Text("ありがとうを集める"), actions: <Widget>[
            IconButton(
                icon: Icon(Icons.help_outline),
                onPressed: () {
                  initTargets();
                  showTutorial(context);
                })
          ]),
          body: Column(
            children: <Widget>[
              const Text(""),
              Row(
                children: <Widget>[
                  SizedBox(
                    child: RaisedButton(
                      child: Text(
                        "+P",
                        // style: TextStyle(fontSize: 7),
                      ),
                      color: Colors.white,
                      shape: CircleBorder(
                        side: BorderSide(
                          color: Colors.black,
                          width: 0.5,
                          style: BorderStyle.solid,
                        ),
                      ),
                      onPressed: () {},
                    ),
                    // width: 35
                    // ,height: 35,
                  ),
                  Flexible(
                    child: Text("ボタンを押して、ポイントゲット！\nスワイプして、削除・編集も可能！",
                        key: keyButton1),
                  ),
                ],
              ),
              Text(""),
              Expanded(
                // key: keyButton1,
                child: ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                        child: Slidable(
                            actionPane: SlidableDrawerActionPane(),
                            actionExtentRatio: 0.25,
                            secondaryActions: <Widget>[
                              IconSlideAction(
                                caption: '削除',
                                color: Colors.red,
                                icon: Icons.delete,
                                onTap: () {
                                  AwesomeDialog(
                                    context: context,
                                    animType: AnimType.SCALE,
                                    dialogType: DialogType.WARNING,
                                    body: Center(
                                      child: const Text(
                                        '本当に削除してよろしいでしょうか？',
                                        style: TextStyle(
                                            fontStyle: FontStyle.italic),
                                      ),
                                    ),
                                    tittle: 'This is Ignored',
                                    desc: 'This is also Ignored',
                                    btnCancelOnPress: () {},
                                    btnOkOnPress: () {
                                      laborModel.removeLabor(index);

                                      AwesomeDialog(
                                        context: context,
                                        animType: AnimType.SCALE,
                                        dialogType: DialogType.SUCCES,
                                        body: Center(
                                          child: const Text(
                                            '削除が完了しました！',
                                            style: TextStyle(
                                                fontStyle: FontStyle.italic),
                                          ),
                                        ),
                                        tittle: 'This is Ignored',
                                        desc: 'This is also Ignored',
                                        btnOkOnPress: () {},
                                      ).show();
                                    },
                                  ).show();
                                },
                              ),
                              IconSlideAction(
                                caption: "編集",
                                color: Colors.indigo,
                                icon: Icons.edit,
                                onTap: () {
                                  //元々設定されていた値を初期値として設定する。
                                  final myLaborNameControllerWithInitialText =
                                      TextEditingController(
                                          text:
                                              laborModel.laborList[index].name);
                                  final myLaborPointControllerWithInitialText =
                                      TextEditingController(
                                          text: laborModel
                                              .laborList[index].point
                                              .toString());

                                  AwesomeDialog(
                                    context: context,
                                    animType: AnimType.SCALE,
                                    dialogType: DialogType.INFO,
                                    body: Center(
                                        child: Column(
                                      children: <Widget>[
                                        const Text(
                                          '編集する場合は入力してください。',
                                          style: TextStyle(
                                              fontStyle: FontStyle.italic),
                                        ),

                                        Container(
                                            width: 200.0,
                                            child: TextField(
                                              controller:
                                                  myLaborNameControllerWithInitialText,
                                              autofocus: true,
                                              decoration: InputDecoration(
                                                // labelText: "編集する場合は入力してください",
                                                hintText: laborModel
                                                    .laborList[index].name
                                                    .toString(),
                                              ),
                                              maxLength: 10,
                                            )),
                                        // Flexible(
                                        // child:
                                        Container(
                                            width: 200.0,
                                            child: TextField(
                                                controller:
                                                    myLaborPointControllerWithInitialText,
                                                autofocus: true,
                                                decoration: InputDecoration(
                                                  // labelText: "編集する場合は入力してください",
                                                  hintText: laborModel
                                                      .laborList[index].point
                                                      .toString(),
                                                ),
                                                maxLength: 5,
                                                keyboardType: TextInputType.number,
                                                inputFormatters: <TextInputFormatter>[
                                                  WhitelistingTextInputFormatter
                                                      .digitsOnly
                                                ])),
                                      ],
                                    )),
                                    tittle: 'This is Ignored',
                                    desc: 'This is also Ignored',
                                    aligment: Alignment.topCenter,
                                    btnCancelOnPress: () {
                                      myLaborNameControllerWithInitialText
                                          .clear();
                                      myLaborPointControllerWithInitialText
                                          .clear();
                                    },
                                    btnOkOnPress: () {
                                      Labor tmpReward = Labor(
                                          name:
                                              myLaborNameControllerWithInitialText
                                                  .text
                                                  .toString(),
                                          point: int.parse(
                                              myLaborPointControllerWithInitialText
                                                  .text));
                                      laborModel.replaceLabor(index, tmpReward);
                                      myLaborNameControllerWithInitialText
                                          .clear();
                                      myLaborPointControllerWithInitialText
                                          .clear();
                                    },
                                  ).show();

                                  //通常ダイアログ
                                  // //編集画面
                                  // showDialog<String>(
                                  //     context: context,
                                  //     barrierDismissible: false,
                                  //     builder: (BuildContext context) {
                                  //       // String result = '';
                                  //       return AlertDialog(
                                  //         title: Text('編集する、名前とポイントを入力'),
                                  //         content: Column(
                                  //           children: <Widget>[
                                  //             Flexible(
                                  //                 child: TextField(
                                  //               controller:
                                  //                   myLaborNameController,
                                  //               autofocus: true,
                                  //               decoration: InputDecoration(
                                  //                 // labelText: "編集する場合は入力してください",
                                  //                 hintText: laborModel
                                  //                     .laborList[index].name
                                  //                     .toString(),
                                  //               ),
                                  //               maxLength: 10,
                                  //             )),
                                  //             Flexible(
                                  //                 child: TextField(
                                  //                     controller:
                                  //                         myLaborPointController,
                                  //                     autofocus: true,
                                  //                     decoration: InputDecoration(
                                  //                       // labelText: "編集する場合は入力してください",
                                  //                       hintText: laborModel
                                  //                           .laborList[index]
                                  //                           .point
                                  //                           .toString(),
                                  //                     ),
                                  //                     maxLength: 5,
                                  //                     keyboardType: TextInputType.number,
                                  //                     inputFormatters: <TextInputFormatter>[
                                  //                   WhitelistingTextInputFormatter
                                  //                       .digitsOnly
                                  //                 ])),
                                  //           ],
                                  //         ),
                                  //         actions: <Widget>[
                                  //           FlatButton(
                                  //             child: Text('Cancel'),
                                  //             onPressed: () {
                                  //               myLaborNameController.clear();
                                  //               myLaborPointController.clear();
                                  //               Navigator.of(context).pop();
                                  //             },
                                  //           ),
                                  //           FlatButton(
                                  //             child: Text('Ok'),
                                  //             onPressed: () {
                                  //               Labor tmpReward = Labor(
                                  //                   name: myLaborNameController
                                  //                       .text
                                  //                       .toString(),
                                  //                   point: int.parse(
                                  //                       myLaborPointController
                                  //                           .text));
                                  //               laborModel.replaceLabor(
                                  //                   index, tmpReward);
                                  //               myLaborNameController.clear();
                                  //               myLaborPointController.clear();
                                  //               Navigator.of(context).pop();
                                  //             },
                                  //           ),
                                  //         ],
                                  //       );
                                  //     });
                                },
                              ),
                            ],
                            child: Row(
                              children: <Widget>[
                                const Text("　"),
                                SizedBox(
                                  width: 35.0,
                                  height: 35.0,
                                  child: Image.asset('images/icon.png'),
                                ),

                                // Icon(
                                //   MaterialCommunityIcons.run,
                                //   color: Colors.indigo,
                                // ),
                                Expanded(
                                  child: Padding(
                                    child: Text(
                                      laborModel.laborList[index].point
                                              .toString() +
                                          " Point:　" +
                                          laborModel.laborList[index].name,
                                    ),
                                    padding: EdgeInsets.all(20.0),
                                  ),
                                ),
                                RaisedButton(
                                  child: const Text("+P"),
                                  color: Colors.white,
                                  shape: CircleBorder(
                                    side: BorderSide(
                                      color: Colors.black,
                                      width: 1.0,
                                      style: BorderStyle.solid,
                                    ),
                                  ),
                                  onPressed: () {
                                    if (lockModel.laborGetState) {
                                      AwesomeDialog(
                                        context: context,
                                        animType: AnimType.SCALE,
                                        dialogType: DialogType.INFO,
                                        aligment: Alignment.topCenter,
                                        body: Center(
                                          child: Column(children: <Widget>[
                                            Container(
                                                child: const Text(
                                              'パスワードを入力してください。',
                                              style: TextStyle(
                                                  fontStyle: FontStyle.italic),
                                            )),
                                            Container(
                                                width: 200.0,
                                                child: TextField(
                                                    controller:
                                                        passwordInputController,
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
                                              checkPassword:
                                                  passwordInputController.text
                                                      .toString())) {
                                            AwesomeDialog(
                                                context: context,
                                                animType: AnimType.SCALE,
                                                dialogType: DialogType.INFO,
                                                body: Center(
                                                  child: Text(
                                                    "日付けを選んでポイントゲット!\n" +
                                                        pointModel.totalPoint
                                                            .toString() +
                                                        "+" +
                                                        laborModel
                                                            .laborList[index]
                                                            .point
                                                            .toString() +
                                                        "=" +
                                                        (pointModel.totalPoint +
                                                                laborModel
                                                                    .laborList[
                                                                        index]
                                                                    .point)
                                                            .toString() +
                                                        "point になります!",
                                                    style: TextStyle(
                                                        fontStyle:
                                                            FontStyle.italic),
                                                  ),
                                                ),
                                                tittle: 'This is Ignored',
                                                desc: 'This is also Ignored',
                                                btnCancelOnPress: () {},
                                                btnOkOnPress: () {
                                                  _selectDate(
                                                      context,
                                                      laborModel,
                                                      pointModel,
                                                      historyModel,
                                                      index);
                                                }).show();

                                            passwordInputController.clear();
                                          } else {
                                            AwesomeDialog(
                                              context: context,
                                              animType: AnimType.SCALE,
                                              dialogType: DialogType.ERROR,
                                              body: Center(
                                                child: const Text(
                                                  'パスワードエラーです。入力し直してください。',
                                                  style: TextStyle(
                                                      fontStyle:
                                                          FontStyle.italic),
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
                                          dialogType: DialogType.INFO,
                                          body: Center(
                                            child: Text(
                                              "日付けを選んでポイントゲット!\n" +
                                                  pointModel.totalPoint
                                                      .toString() +
                                                  "+" +
                                                  laborModel
                                                      .laborList[index].point
                                                      .toString() +
                                                  "=" +
                                                  (pointModel.totalPoint +
                                                          laborModel
                                                              .laborList[index]
                                                              .point)
                                                      .toString() +
                                                  "point になります!",
                                              style: TextStyle(
                                                  fontStyle: FontStyle.italic),
                                            ),
                                          ),
                                          tittle: 'This is Ignored',
                                          desc: 'This is also Ignored',
                                          btnCancelOnPress: () {},
                                          btnOkOnPress: () {
                                            _selectDate(
                                                context,
                                                laborModel,
                                                pointModel,
                                                historyModel,
                                                index);
                                          }).show();

                                      passwordInputController.clear();
                                    }
                                  },
                                ),
                              ],
                            )));
                  },
                  itemCount: laborModel.laborList.length,
                ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
              key: keyButton2,
              child: Icon(Ionicons.ios_add),
              onPressed: () {
                AwesomeDialog(
                  context: context,
                  animType: AnimType.SCALE,
                  dialogType: DialogType.INFO,
                  body: Center(
                      child: Column(
                    children: <Widget>[
                      const Text(
                        '追加する場合は入力してください。',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),

                      // Flexible(
                      // child:
                      Container(
                          width: 200.0,
                          child: TextField(
                            controller: myLaborNameController,
                            autofocus: true,
                            decoration: InputDecoration(
                              labelText: "名前",
                              // hintText: "test"
                            ),
                            maxLength: 10,
                            onChanged: (value) {
                              // nothing to do
                            },
                          )),
                      // Flexible(
                      // child:
                      Container(
                          width: 200.0,
                          child: TextField(
                              controller: myLaborPointController,
                              decoration: InputDecoration(labelText: "ポイント"),
                              maxLength: 5,
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                WhitelistingTextInputFormatter.digitsOnly
                              ])),
                    ],
                  )),
                  tittle: 'This is Ignored',
                  desc: 'This is also Ignored',
                  aligment: Alignment.topCenter,
                  btnCancelOnPress: () {
                    myLaborNameController.clear();
                    myLaborPointController.clear();
                  },
                  btnOkOnPress: () {
                    Labor tmpLabor = Labor(
                        name: myLaborNameController.text,
                        point: int.parse(myLaborPointController.text));

                    if (myLaborNameController.text == null ||
                        myLaborPointController.text == null ||
                        myLaborNameController.text == "" ||
                        myLaborPointController.text == "null") {
                      myLaborNameController.clear();
                      myLaborPointController.clear();
                      Navigator.of(context).pop();
                    }
                    print(myLaborNameController.text);
                    print(myLaborPointController.text);

                    laborModel.addLaborModel(labor: tmpLabor);
                    myLaborNameController.clear();
                    myLaborPointController.clear();
                  },
                ).show();

                // showDialog<String>(
                //     context: context,
                //     barrierDismissible: false,
                //     builder: (BuildContext context) {
                //       // String result = '';
                //       return AlertDialog(
                //         title: Text('新規追加しますか？'),
                //         content: Column(children: <Widget>[
                //           Row(
                //             children: <Widget>[
                //               Expanded(
                //                   child: TextField(
                //                 controller: myLaborNameController,
                //                 autofocus: true,
                //                 decoration: InputDecoration(
                //                   labelText: "名前",
                //                   // hintText: "test"
                //                 ),
                //                 maxLength: 10,
                //                 onChanged: (value) {
                //                   // nothing to do
                //                 },
                //               )),
                //             ],
                //           ),
                //           Expanded(
                //               child: TextField(
                //                   controller: myLaborPointController,
                //                   decoration:
                //                       InputDecoration(labelText: "ポイント"),
                //                   maxLength: 5,
                //                   keyboardType: TextInputType.number,
                //                   inputFormatters: <TextInputFormatter>[
                //                 WhitelistingTextInputFormatter.digitsOnly
                //               ]))
                //         ]),
                //         actions: <Widget>[
                //           FlatButton(
                //             child: Text('Cancel'),
                //             onPressed: () {
                //               myLaborNameController.clear();
                //               myLaborPointController.clear();
                //               Navigator.of(context).pop();
                //             },
                //           ),
                //           FlatButton(
                //             child: Text('Ok'),
                //             onPressed: () {
                //               Labor tmpLabor = Labor(
                //                   name: myLaborNameController.text,
                //                   point:
                //                       int.parse(myLaborPointController.text));

                //               if (myLaborNameController.text == null ||
                //                   myLaborPointController.text == null ||
                //                   myLaborNameController.text == "" ||
                //                   myLaborPointController.text == "null") {
                //                 myLaborNameController.clear();
                //                 myLaborPointController.clear();
                //                 Navigator.of(context).pop();
                //               }
                //               print(myLaborNameController.text);
                //               print(myLaborPointController.text);

                //               laborModel.addLaborModel(labor: tmpLabor);
                //               myLaborNameController.clear();
                //               myLaborPointController.clear();
                //               Navigator.of(context).pop();
                //             },
                //           ),
                //         ],
                //       );
                //     });
              }));
    });
  }

  Future<void> _selectDate(BuildContext context, LaborModel laborModel,
      PointModel pointModel, HistoryModel historyModel, int index) async {
    selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime(2030),
    );
    if (selectedDate != null) {
      pointModel.addTotalPoint(point: laborModel.laborList[index].point);
      historyModel.addHistoryModel(
          history: History(
              dateTime: dateFormat_YYYY_MM_DD.format(selectedDate),
              name: laborModel.laborList[index].name,
              point: laborModel.laborList[index].point,
              sign: true));
      // Navigator.pop(context);
      AwesomeDialog(
        context: context,
        animType: AnimType.SCALE,
        dialogType: DialogType.SUCCES,
        body: Center(
          child: Text(
            laborModel.laborList[index].name +
                "　ありがとう！　"
                    'ポイントを取得しました！間違って交換した場合は、履歴画面から削除してください。',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
        tittle: 'This is Ignored',
        desc: 'This is also Ignored',
        btnOkOnPress: () {
          // Navigator.pop(context);
        },
      ).show();
    }
  }

  void showTutorial(context) {
    TutorialCoachMark(context,
        targets: targets,
        colorShadow: Theme.of(context).primaryColor.withAlpha(200),
        textSkip: "スキップ",
        paddingFocus: 10,
        textStyleSkip: TextStyle(fontSize: 25, color: Colors.white),
        opacityShadow: 0.8, finish: () {
      print("finish");
    }, clickTarget: (target) {
      print(target);
    }, clickSkip: () {
      print("skip");
    })
      ..show();
  }

  void initTargets() {
    targets.add(TargetFocus(
      identify: "Target 1",
      keyTarget: keyButton1,
      contents: [
        ContentTarget(
            align: AlignContent.bottom,
            child: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "お手伝いリスト",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20.0),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Column(
                      children: <Widget>[
                        Card(
                            child: Row(children: <Widget>[
                          Text("　"),
                          Icon(
                            MaterialCommunityIcons.run,
                            color: Colors.indigo,
                          ),
                          Expanded(
                            child: Padding(
                              child: Text(
                                3.toString() + " Point:　" + "お掃除",
                              ),
                              padding: EdgeInsets.all(20.0),
                            ),
                          ),
                          RaisedButton(
                              child: const Text("+P"),
                              color: Colors.white,
                              shape: CircleBorder(
                                side: BorderSide(
                                  color: Colors.black,
                                  width: 1.0,
                                  style: BorderStyle.solid,
                                ),
                              ),
                              onPressed: () {})
                        ])),
                        const Text(
                          "お手伝いをしたら、(+P)ボタンを押して、ポイントをもらおう！お手伝いを修正・削除したい場合は、右から左にスワイプしよう！",
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ))
      ],
      shape: ShapeLightFocus.RRect,
    ));
    targets.add(TargetFocus(
      identify: "Target 2",
      keyTarget: keyButton2,
      contents: [
        ContentTarget(
            align: AlignContent.top,
            child: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    "お手伝い追加ボタン",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20.0),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: const Text(
                      "ここをクリックして、お手伝いを追加しよう！",
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            ))
      ],
      shape: ShapeLightFocus.RRect,
    ));
  }
}

bool isInputValid(String name, String point) {
  if (name != null && point != null && name != "" && point != "") {
    return false;
  } else {
    return true;
  }
}
