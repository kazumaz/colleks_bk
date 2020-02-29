import 'package:colleks/model/HistoryModel.dart';
import 'package:colleks/model/PointModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import 'package:tutorial_coach_mark/animated_focus_light.dart';

class HistoryPage extends StatelessWidget {
  List<TargetFocus> targets = List();
  GlobalKey keyButton1 = GlobalKey();
  GlobalKey keyButton2 = GlobalKey();

  final myLaborNameController = TextEditingController();
  final myLaborPointController = TextEditingController();
  bool datePicked = false;
  DateTime selectedDate;
  DateFormat dateFormat_YYYY_MM_DD = DateFormat("yyyy-MM-dd");

  @override
  Widget build(BuildContext context) {
    return Consumer2<HistoryModel, PointModel>(
        builder: (context, historyModel, pointModel, child) {
      return Scaffold(
          appBar: AppBar(title: Text("履歴"), actions: <Widget>[
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
              Text("間違えて登録したものはここから削除！\nスワイプして削除実施！", key: keyButton1),
              const Text(""),
              // 履歴が0件の場合は、「履歴がありません」の表示をできるようにする。
              historyModel.historyList.length == 0
                  ? Center(
                      child: Column(
                      children: <Widget>[
                        const Text(""),
                        const Text(""),
                        SizedBox(
                          width: 150.0,
                          height: 150.0,
                          child: Image.asset('images/step.png'),
                        ),
                        const Text(""),
                        const Text("履歴がまだ登録されていません！"),
                        const Text("どんどんお手伝いして「ありがとう」をためよう！"),
                      ],
                    ))
                  // ここまで履歴0件の表示
                  : Expanded(
                      child: ListView.builder(
                        // reverse: true,
                        itemBuilder: (BuildContext context, int index) {
                          //historyModel.historyList　をそのまま使うと、リストビューで最後に追加されたものが、画面上下に来てしまう。
                          //履歴画面では、最後に追加されたものが、画面上上に来る方が見やすいため、反転リストを作成する。
                          List<History> reversedHistoryList =
                              historyModel.historyList.reversed.toList();
                          return Card(
                              // color: historyModel.historyList[index].sign ? Colors.blue[50] : Colors.red[50],
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
                                            child: Text(
                                              '本当に削除してよろしいでしょうか？「お手伝い」を削除した場合はポイントがなくなります。「ご褒美」を削除した場合は、ポイントが復活します。',
                                              style: TextStyle(
                                                  fontStyle: FontStyle.italic),
                                            ),
                                          ),
                                          tittle: 'This is Ignored',
                                          desc: 'This is also Ignored',
                                          btnCancelOnPress: () {},
                                          btnOkOnPress: () {
                                            if (reversedHistoryList[index]
                                                .sign) {
                                              pointModel
                                                  .decreaseTotalPointWithEver(
                                                      point:
                                                          reversedHistoryList[
                                                                  index]
                                                              .point);
                                            } else {
                                              pointModel
                                                  .increaseTotalPointWithEver(
                                                      point:
                                                          reversedHistoryList[
                                                                  index]
                                                              .point);
                                            }
                                            //reversedHistoryListのインデックスをそのままモデルから削除すると、間違ったindexのものを削除してしまうから
                                            //計算して正しいものを削除するようにする
                                            historyModel.removeHistory(
                                                historyModel
                                                        .historyList.length -
                                                    1 -
                                                    index);

                                            AwesomeDialog(
                                              context: context,
                                              animType: AnimType.SCALE,
                                              dialogType: DialogType.SUCCES,
                                              body: Center(
                                                child: const Text(
                                                  '削除が成功しました！',
                                                  style: TextStyle(
                                                      fontStyle:
                                                          FontStyle.italic),
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
                                  ],
                                  child: Column(
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Text(
                                            dateFormat_YYYY_MM_DD
                                                .format(
                                                    reversedHistoryList[index]
                                                        .dateTime)
                                                .toString(),
                                            style: TextStyle(
                                              fontSize: 10.0,
                                            ),
                                          ),
                                          Text(""),
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          const Text("　"),
                                          reversedHistoryList[index].sign
                                              ? SizedBox(
                                                  width: 35.0,
                                                  height: 35.0,
                                                  child: Image.asset(
                                                      'images/icon.png'),
                                                )
                                              : Icon(
                                                  MaterialCommunityIcons.gift,
                                                  color: Colors.pink,
                                                ),
                                          const Text("  "),
                                          Expanded(
                                            // child: Padding(
                                            child: Text(
                                              reversedHistoryList[index]
                                                      .point
                                                      .toString() +
                                                  " Point:　" +
                                                  reversedHistoryList[index]
                                                      .name +
                                                  (reversedHistoryList[index]
                                                          .sign
                                                      ? "　ありがとう！"
                                                      : "　もらったよ！"),
                                            ),
                                            // padding: EdgeInsets.all(20.0),
                                            // ),
                                          ),
                                        ],
                                      ),
                                      Text("",
                                          style: TextStyle(
                                            fontSize: 10.0,
                                          )),
                                    ],
                                  )));
                        },
                        itemCount: historyModel.historyList.length,
                      ),
                    ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
              key: keyButton2,
              child: Icon(MaterialCommunityIcons.delete_forever),
              onPressed: () {
                AwesomeDialog(
                  context: context,
                  animType: AnimType.SCALE,
                  dialogType: DialogType.ERROR,
                  body: Center(
                    child: const Text(
                      '全ての履歴を非表示にしますか？履歴を復活させることはできなくなります。ポイントの変更はありません。',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                  tittle: 'This is Ignored',
                  desc: 'This is also Ignored',
                  btnCancelOnPress: () {},
                  btnOkOnPress: () {
                    historyModel.removeAllHistory();
                  },
                ).show();
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
                    "履歴リスト",
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
                            child: Column(children: <Widget>[
                          Row(
                            children: <Widget>[
                              const Text(
                                '2019-04-07',
                                style: TextStyle(
                                  fontSize: 10.0,
                                ),
                              ),
                              const Text(""),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              const Text("　"),
                              SizedBox(
                                width: 35.0,
                                height: 35.0,
                                child: Image.asset('images/icon.png'),
                              ),
                              const Text("  "),
                              Expanded(
                                // child: Padding(
                                child: Text(3.toString() +
                                    " Point:　" +
                                    "お掃除" +
                                    "　ありがとう！"),
                                // padding: EdgeInsets.all(20.0),
                                // ),
                              ),
                            ],
                          ),
                        ])),
                        Card(
                            child: Column(children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text(
                                '2019-04-07',
                                style: TextStyle(
                                  fontSize: 10.0,
                                ),
                              ),
                              const Text(""),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Text("　"),
                              Icon(
                                MaterialCommunityIcons.gift,
                                color: Colors.pink,
                              ),
                              const Text("  "),
                              Expanded(
                                // child: Padding(
                                child: Text(3.toString() +
                                    " Point:　" +
                                    "お掃除" +
                                    "　もらったよ！"),
                                // padding: EdgeInsets.all(20.0),
                                // ),
                              ),
                            ],
                          ),
                        ])),
                        const Text(
                          "お手伝いをしたり、ご褒美をもらったら、ここに履歴として表示されるよ！誤って登録してしまったものは、右から左にスワイプして削除しよう！削除したら、ポイントにも反映されるよ！",
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
                    "履歴非表示ボタン",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20.0),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: const Text(
                      "履歴が増えすぎた場合は、ここをクリックして非表示にしよう！ただし、一度非表示にすると、再度表示することはできないので注意！履歴を非表示にしてもポイントの変動はありません。",
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
