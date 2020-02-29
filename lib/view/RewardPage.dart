import 'package:colleks/model/RewardModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import 'package:tutorial_coach_mark/animated_focus_light.dart';

class RewardPage extends StatelessWidget {
  //チュートリアルを実施した時の、チュートリアル対象のwidgetを指定するためのグローバルキー
  List<TargetFocus> targets = List();
  GlobalKey keyButton1 = GlobalKey();
  GlobalKey keyButton2 = GlobalKey();

  final myRewardNameController = TextEditingController();
  final myRewardPointController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<RewordModel>(builder: (context, rewardModel, child) {
      return Scaffold(
          appBar: AppBar(title: Text("ご褒美"), actions: <Widget>[
            IconButton(
                icon: Icon(Icons.help_outline),
                onPressed: () {
                  initTargets();
                  showTutorial(context);
                })
            // IconButton(icon: Icon(Icons.help_outline), onPressed: () {})
          ]),
          body: Column(children: <Widget>[
            const Text(""),
            Text("ここからご褒美追加！\nスワイプして削除・編集も可能！", key: keyButton1),
            const Text(""),
            Expanded(
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
                                  '本当に削除してよろしいでしょうか',
                                  style: TextStyle(fontStyle: FontStyle.italic),
                                ),
                              ),
                              tittle: 'This is Ignored',
                              desc: 'This is also Ignored',
                              btnCancelOnPress: () {},
                              btnOkOnPress: () {
                                rewardModel.removeReward(index);

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
                            final myRewardNameControllerWithInitialText =  TextEditingController(text: rewardModel.rewardList[index].name);
                            final myRewardPointControllerWithInitialText =  TextEditingController(text: rewardModel.rewardList[index].point.toString());
                            AwesomeDialog(
                              context: context,
                              animType: AnimType.SCALE,
                              dialogType: DialogType.INFO,
                              body: Center(
                                  child: Column(
                                children: <Widget>[
                                  const Text(
                                    '編集する場合は入力してください。',
                                    style:
                                        TextStyle(fontStyle: FontStyle.italic),
                                  ),

                                  // Flexible(
                                  // child:
                                  Container(
                                      width: 200.0,
                                      child: TextField(
                                        controller: myRewardNameControllerWithInitialText,
                                        autofocus: true,
                                        decoration: InputDecoration(
                                          hintText: rewardModel
                                              .rewardList[index].name
                                              .toString(),
                                        ),
                                        maxLength: 10,
                                        // )
                                      )),
                                  // Flexible(
                                  // child:
                                  Container(
                                      width: 200.0,
                                      child: TextField(
                                          controller: myRewardPointControllerWithInitialText,
                                          autofocus: true,
                                          decoration: InputDecoration(
                                            hintText: rewardModel
                                                .rewardList[index].point
                                                .toString(),
                                          ),
                                          maxLength: 5,
                                          keyboardType: TextInputType.number,
                                          inputFormatters: <TextInputFormatter>[
                                            WhitelistingTextInputFormatter
                                                .digitsOnly
                                          ]

                                          // )
                                          )),
                                ],
                              )),
                              tittle: 'This is Ignored',
                              desc: 'This is also Ignored',
                              aligment: Alignment.topCenter,
                              btnCancelOnPress: () {
                                myRewardNameControllerWithInitialText.clear();
                                myRewardPointControllerWithInitialText.clear();
                              },
                              btnOkOnPress: () {
                                Reward tmpReward = Reward(
                                    name:
                                        myRewardNameControllerWithInitialText.text.toString(),
                                    point: int.parse(
                                        myRewardPointControllerWithInitialText.text));
                                rewardModel.replaceReward(index, tmpReward);
                                myRewardNameControllerWithInitialText.clear();
                                myRewardPointControllerWithInitialText.clear();
                              },
                            ).show();

//以下は通常のダ���アログ
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
                            //               controller: myRewardNameController,
                            //               autofocus: true,
                            //               decoration: InputDecoration(
                            //                 hintText: rewardModel
                            //                     .rewardList[index].name
                            //                     .toString(),
                            //               ),
                            //               maxLength: 10,
                            //             )),
                            //             Flexible(
                            //                 child: TextField(
                            //                     controller:
                            //                         myRewardPointController,
                            //                     autofocus: true,
                            //                     decoration: InputDecoration(
                            //                       hintText: rewardModel
                            //                           .rewardList[index].point
                            //                           .toString(),
                            //                     ),
                            //                     maxLength: 5,
                            //                     keyboardType:
                            //                         TextInputType.number,
                            //                     inputFormatters: <
                            //                         TextInputFormatter>[
                            //                   WhitelistingTextInputFormatter
                            //                       .digitsOnly
                            //                 ])),
                            //           ],
                            //         ),
                            //         actions: <Widget>[
                            //           FlatButton(
                            //             child: Text('Cancel'),
                            //             onPressed: () {
                            //               myRewardNameController.clear();
                            //               myRewardPointController.clear();
                            //               Navigator.of(context).pop();
                            //             },
                            //           ),
                            //           FlatButton(
                            //             child: Text('Ok'),
                            //             onPressed: () {
                            //               Reward tmpReward = Reward(
                            //                   name: myRewardNameController.text
                            //                       .toString(),
                            //                   point: int.parse(
                            //                       myRewardPointController
                            //                           .text));
                            //               rewardModel.replaceReward(
                            //                   index, tmpReward);
                            //               myRewardNameController.clear();
                            //               myRewardPointController.clear();
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
                          Text("　"),
                          Icon(
                            MaterialCommunityIcons.gift,
                            color: Colors.pink,
                          ),
                          Padding(
                            child: Text(
                              rewardModel.rewardList[index].point.toString() +
                                  " Point:　　" +
                                  rewardModel.rewardList[index].name,
                            ),
                            padding: EdgeInsets.all(20.0),
                          )
                        ],
                      )),
                );
              },
              itemCount: rewardModel.rewardList.length,
            ))
          ]),
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
                            controller: myRewardNameController,
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
                              controller: myRewardPointController,
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
                    myRewardNameController.clear();
                    myRewardPointController.clear();
                  },
                  btnOkOnPress: () {
                    Reward tmpLabor = Reward(
                        name: myRewardNameController.text,
                        point: int.parse(myRewardPointController.text));

                    if (myRewardNameController.text == null ||
                        myRewardPointController.text == null ||
                        myRewardNameController.text == "" ||
                        myRewardPointController.text == "null") {
                      myRewardNameController.clear();
                      myRewardPointController.clear();
                      Navigator.of(context).pop();
                    }
                    print(myRewardNameController.text);
                    print(myRewardPointController.text);

                    rewardModel.addRewardModel(reward: tmpLabor);
                    myRewardNameController.clear();
                    myRewardPointController.clear();
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
                //                 controller: myRewardNameController,
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
                //                   controller: myRewardPointController,
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
                //               myRewardNameController.clear();
                //               myRewardPointController.clear();
                //               Navigator.of(context).pop();
                //             },
                //           ),
                //           FlatButton(
                //             child: Text('Ok'),
                //             onPressed: () {
                //               Reward tmpLabor = Reward(
                //                   name: myRewardNameController.text,
                //                   point:
                //                       int.parse(myRewardPointController.text));

                //               if (myRewardNameController.text == null ||
                //                   myRewardPointController.text == null ||
                //                   myRewardNameController.text == "" ||
                //                   myRewardPointController.text == "null") {
                //                 myRewardNameController.clear();
                //                 myRewardPointController.clear();
                //                 Navigator.of(context).pop();
                //               }
                //               print(myRewardNameController.text);
                //               print(myRewardPointController.text);

                //               rewardModel.addRewardModel(reward: tmpLabor);
                //               myRewardNameController.clear();
                //               myRewardPointController.clear();
                //               Navigator.of(context).pop();
                //             },
                //           ),
                //         ],
                //       );
                //     });
              }));
    });
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
                    "ご褒美リスト",
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
                            MaterialCommunityIcons.gift,
                            color: Colors.pink,
                          ),
                          Expanded(
                            child: Padding(
                              child: Text(
                                100.toString() + " Point:　" + "遊園地",
                              ),
                              padding: EdgeInsets.all(20.0),
                            ),
                          ),
                        ])),
                        const Text(
                          "ご褒美を修正・削除したい場合は、右から左にスワイプしよう！",
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
                    "ご褒美追加ボタン",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20.0),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: const Text(
                      "ここをクリックして、ご褒美を追加しよう！",
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
