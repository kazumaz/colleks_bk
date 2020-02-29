import 'package:flutter/material.dart';
import 'package:colleks/model/PasswordModel.dart';
import 'package:colleks/model/LockModel.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share/share.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:provider/provider.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import 'package:tutorial_coach_mark/animated_focus_light.dart';

class SettingsPage extends StatelessWidget {
    List<TargetFocus> targets = List();
  GlobalKey keyButton1 = GlobalKey();
  GlobalKey keyButton2 = GlobalKey();
  GlobalKey keyButton3 = GlobalKey();
  GlobalKey keyButton4 = GlobalKey();
  
  final passwordInputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer2<PasswordModel, LockModel>(
        builder: (context, passwordModel, lockModel, child) {
      return Scaffold(
          appBar: AppBar(title: Text("設定"), actions: <Widget>[
                        IconButton(
                icon: Icon(Icons.help_outline),
                onPressed: () {
                  initTargets();
                  showTutorial(context);
                })
          ]),
          backgroundColor: Colors.grey[100],
          body: Column(
            mainAxisSize: MainAxisSize.max,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Flexible(
                  child: ListView(children: [
                Text(""),
                Text("　設定"),
                _passwordSetting("　パスワード設定", Icon(Ionicons.ios_lock), context),
                _rockSetting("　ポイント追加時のパスワード要否設定", Icon(Ionicons.ios_contact), context,
                    passwordModel),
                _colorSetting("　テーマカラーの変更", Icon(Ionicons.ios_color_palette), context),
                _pointChange("　ポイントの追加・削除", Icon(MaterialCommunityIcons.coins), context,
                    passwordModel, lockModel),                
                Text(""),
                Text("　アプリについて"),
                _opinionPage("　ご意見・ご要望など", Icon(Entypo.pencil), context),
                _twitterPage("　開発者のツート", Icon(FontAwesome.twitter), context),
                _appShare("　このアプリを紹介", Icon(Ionicons.ios_rocket), context),
                _appReview("　このアプリを評価", Icon(Icons.star), context),
                _donate("　アプリのサポートページ", Icon(MaterialCommunityIcons.web), context),
              ])),
            ],
          ));
    });
  }

  Widget _rockSetting(String title, Icon icon, BuildContext context,
      PasswordModel passwordModel) {
    return GestureDetector(
      child: Container(
        key: keyButton2,
          padding: EdgeInsets.all(8.0),
          decoration: new BoxDecoration(
              color: Colors.white,
              border: new Border(
                  bottom: BorderSide(width: 1.0, color: Colors.grey))),
          child: Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(5.0),
                child: icon,
              ),
              Text(
                title,
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ],
          )),
      onTap: () {
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
                  'パスワードを入力してください。',
                  style: TextStyle(fontStyle: FontStyle.italic),
                )),
                Container(
                    width: 200.0,
                    child: TextField(
                        controller: passwordInputController, autofocus: true
                        // decoration: InputDecoration(
                        //   // labelText: "編集する場合は入力してください",

                        ))
              ]),
            ),
            tittle: 'This is Ignored',
            desc: 'This is also Ignored',
            btnOkOnPress: () {
              if (passwordModel.isValidPassword(
                  checkPassword: passwordInputController.text.toString())) {
                Navigator.of(context).pushNamed("/rockSetting");
                passwordInputController.clear();
              } else {
                AwesomeDialog(
                  context: context,
                  animType: AnimType.SCALE,
                  dialogType: DialogType.ERROR,
                  body: Center(
                    child: const Text(
                      'パスワードエラーです。入力し直してください。',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                  tittle: 'This is Ignored',
                  desc: 'This is also Ignored',
                  btnOkOnPress: () {},
                ).show();
                passwordInputController.clear();
              }
            },
          ).show();
        } else {
          AwesomeDialog(
            context: context,
            animType: AnimType.SCALE,
            dialogType: DialogType.ERROR,
            body: Center(
              child: const Text(
                'ロック機能を使う際は、先に「パスワード設定画面」にて、パスワードの設定を行ってください。',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
            tittle: 'This is Ignored',
            desc: 'This is also Ignored',
            btnCancelText: "やめとく",
            btnOkText: "設定する",
            btnCancelOnPress: () {},
            btnOkOnPress: () {
              Navigator.of(context).pushNamed("/passwordSetting");
            },
          ).show();
        }
      },
    );
  }

  Widget _colorSetting(String title, Icon icon, BuildContext context) {
    return GestureDetector(
      child: Container(
        key: keyButton3,
          padding: EdgeInsets.all(8.0),
          decoration: new BoxDecoration(
              color: Colors.white,
              border: new Border(
                  bottom: BorderSide(width: 1.0, color: Colors.grey))),
          child: Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(5.0),
                child: icon,
              ),
              Text(
                title,
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ],
          )),
      onTap: () {
        Navigator.of(context).pushNamed("/colorSettings");
        print("onTap called.");
      },
    );
  }

  Widget _passwordSetting(String title, Icon icon, BuildContext context) {
    return GestureDetector(
      child: Container(
        key: keyButton1,
          padding: EdgeInsets.all(8.0),
          decoration: new BoxDecoration(
              color: Colors.white,
              border: new Border(
                  bottom: BorderSide(width: 1.0, color: Colors.grey))),
          child: Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(5.0),
                child: icon,
              ),
              Text(
                title,
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ],
          )),
      onTap: () {
        Navigator.of(context).pushNamed("/passwordSetting");
        print("onTap called.");
      },
    );
  }

  Widget _pointChange(String title, Icon icon, BuildContext context,
      PasswordModel passwordModel, LockModel lockModel) {
    return GestureDetector(
      child: Container(key: keyButton4,

          padding: EdgeInsets.all(8.0),
          decoration: new BoxDecoration(
              color: Colors.white,
              border: new Border(
                  bottom: BorderSide(width: 1.0, color: Colors.grey))),
          child: Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(5.0),
                child: icon,
              ),
              Text(
                title,
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ],
          )),
      onTap: () {
        if (lockModel.pointChangePageState) {
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
                  style: TextStyle(fontStyle: FontStyle.italic),
                )),
                Container(
                    width: 200.0,
                    child: TextField(
                        controller: passwordInputController, autofocus: true
                        // decoration: InputDecoration(
                        //   // labelText: "編集する場合は入力してください",

                        ))
              ]),
            ),
            tittle: 'This is Ignored',
            desc: 'This is also Ignored',
            btnOkOnPress: () {
              if (passwordModel.isValidPassword(
                  checkPassword: passwordInputController.text.toString())) {
                Navigator.of(context).pushNamed("/pointChange");
              } else {
                AwesomeDialog(
                  context: context,
                  animType: AnimType.SCALE,
                  dialogType: DialogType.ERROR,
                  body: Center(
                    child: const Text(
                      'パスワードエラーです。入力し直してください。',
                      style: TextStyle(fontStyle: FontStyle.italic),
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
          Navigator.of(context).pushNamed("/pointChange");
          passwordInputController.clear();
        }
      },
    );
  }

  Widget _twitterPage(String title, Icon icon, BuildContext context) {
    return GestureDetector(
      child: Container(
          padding: EdgeInsets.all(8.0),
          decoration: new BoxDecoration(
              color: Colors.white,
              border: new Border(
                  bottom: BorderSide(width: 1.0, color: Colors.grey))),
          child: Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(5.0),
                child: icon,
              ),
              Text(
                title,
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ],
          )),
      onTap: () {
        AwesomeDialog(
          context: context,
          animType: AnimType.SCALE,
          dialogType: DialogType.INFO,
          body: Center(
            child: const Text(
              '平和なツイートをしています。\nよろしければ、フォローしてください。',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
          tittle: 'This is Ignored',
          desc: 'This is also Ignored',
          btnCancelText: "やめておく",
          btnOkText: "見てみる",
          btnCancelOnPress: () {},
          btnOkOnPress: () {
            launchURL("https://twitter.com/kzmat2");
          },
        ).show();
      },
    );
  }

  Widget _opinionPage(String title, Icon icon, BuildContext context) {
    return GestureDetector(
      child: Container(        
          padding: EdgeInsets.all(8.0),
          decoration: new BoxDecoration(
              color: Colors.white,
              border: new Border(
                  bottom: BorderSide(width: 1.0, color: Colors.grey))),
          child: Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(5.0),
                child: icon,
              ),
              Text(
                title,
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ],
          )),
      onTap: () {
        AwesomeDialog(
          context: context,
          animType: AnimType.SCALE,
          dialogType: DialogType.INFO,
          body: Center(
            child: const Text(
              'いただいたご意見・ご要望を参考にアプリを改良していきます。',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
          tittle: 'This is Ignored',
          desc: 'This is also Ignored',
          btnCancelText: "やめておく",
          btnOkText: "する",
          btnCancelOnPress: () {},
          btnOkOnPress: () {
            var email = 'kzm2235@yahoo.co.jp';
            var subject = Uri.encodeComponent('【Dama】アプリに関するご意見・ご要望');
            var body = Uri.encodeComponent('ご意見・ご要望をこちらにご記入ください。');
            var url = 'mailto:$email?subject=$subject&body=$body';
            print(url);
            launchURL(url);
          },
        ).show();
      },
    );
  }

  launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget _appShare(String title, Icon icon, BuildContext context) {
    return GestureDetector(
      child: Container(
          padding: EdgeInsets.all(8.0),
          decoration: new BoxDecoration(
              color: Colors.white,
              border: new Border(
                  bottom: BorderSide(width: 1.0, color: Colors.grey))),
          child: Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(5.0),
                child: icon,
              ),
              Text(
                title,
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ],
          )),
      onTap: () {
        AwesomeDialog(
          context: context,
          animType: AnimType.SCALE,
          dialogType: DialogType.INFO,
          body: Center(
            child: const Text(
              'このアプリが役立ちそうな人を知っていましたら、ご紹介いただけると嬉しいです。',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
          tittle: 'This is Ignored',
          desc: 'This is also Ignored',
          btnCancelText: "やめておく",
          btnOkText: "してあげる",
          btnCancelOnPress: () {},
          btnOkOnPress: () {
            Share.share(
                'check out my app https://kazumaz.github.io/dama_app_pages/');
          },
        ).show();
      },
    );
  }

  Widget _appReview(String title, Icon icon, BuildContext context) {
    return GestureDetector(
      child: Container(
          padding: EdgeInsets.all(8.0),
          decoration: new BoxDecoration(
              color: Colors.white,
              border: new Border(
                  bottom: BorderSide(width: 1.0, color: Colors.grey))),
          child: Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(5.0),
                child: icon,
              ),
              Text(
                title,
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ],
          )),
      onTap: () {
        AwesomeDialog(
          context: context,
          animType: AnimType.SCALE,
          dialogType: DialogType.INFO,
          body: Center(
            child: const Text(
              'レビューをいただけますと、\nとても嬉しいです。',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
          tittle: 'This is Ignored',
          desc: 'This is also Ignored',
          btnCancelText: "やめておく",
          btnOkText: "してあげる",
          btnCancelOnPress: () {},
          btnOkOnPress: () {
            launchURL("https://github.com/kazumaz");
          },
        ).show();
      },
    );
  }

  Widget _donate(String title, Icon icon, BuildContext context) {
    return GestureDetector(
      child: Container(
          padding: EdgeInsets.all(8.0),
          decoration: new BoxDecoration(
              color: Colors.white,
              border: new Border(
                  bottom: BorderSide(width: 1.0, color: Colors.grey))),
          child: Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(5.0),
                child: icon,
              ),
              Text(
                title,
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ],
          )),
      onTap: () {
        AwesomeDialog(
          context: context,
          animType: AnimType.SCALE,
          dialogType: DialogType.INFO,
          body: Center(
            child: Text(
              'APLのサポートページを作ったので、時間があれば見てみてください。',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
          tittle: 'This is Ignored',
          desc: 'This is also Ignored',
          btnCancelText: "やめておく",
          btnOkText: "見てみる",
          btnCancelOnPress: () {},
          btnOkOnPress: () {
            launchURL("https://kazumaz.github.io/dama_app_pages/");
          },
        ).show();
      },
    );
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
                  const Text(
                    "パスワード設定",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20.0),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      "本アプリで使う、パスワードを設定する！パスワードは、再発行ができないので注意が必要！",
                      style: TextStyle(color: Colors.white),
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
            align: AlignContent.bottom,
            child: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "一部機能をパスワード入力必須とする",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20.0),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: const Text(
                      "一部機能を、パスワードを入力しないと、使用不可能にすることが出来るよ！現状、ポイント数を指定してのポイント追加機能や、お手伝いを実施した時のポイント追加が、パスワード入力を必要とすることが出来るよ！",
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            ))
      ],
      shape: ShapeLightFocus.RRect,
    ));
    targets.add(TargetFocus(
      identify: "Target 3",
      keyTarget: keyButton3,
      contents: [
        ContentTarget(
            align: AlignContent.bottom,
            child: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    "テーマカラーの選択",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20.0),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: const Text(
                      "本アプリのテーマカラーを設定可能！選べる、全15色！自分好みのテーマカラーを見つけよう！",
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            ))
      ],
      shape: ShapeLightFocus.RRect,
    ));
    targets.add(TargetFocus(
      identify: "Target 4",
      keyTarget: keyButton4,
      contents: [
        ContentTarget(
            align: AlignContent.bottom,
            child: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "ポイントの追加・削減",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20.0),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: const Text(
                      "この画面で、ポイントの追加と削除が可能！",
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


