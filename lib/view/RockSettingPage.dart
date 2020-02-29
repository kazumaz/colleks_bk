import 'package:colleks/model/PasswordModel.dart';
import 'package:colleks/model/LockModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:toggle_switch/toggle_switch.dart';

class RockSettingPage extends StatelessWidget {
  final passwordInputController = TextEditingController();
  final passwordInputConfirmController = TextEditingController();
  final beforePasswordInputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer2<PasswordModel, LockModel>(
        builder: (context, passwordModel, lockModel, child) {
      return Scaffold(
          appBar: AppBar(
            leading: IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () => Navigator.of(context).pop()),
            backgroundColor: Theme.of(context).primaryColor,
            elevation: 0.0,
            title: Text("ロック設定"),
          ),
          body: Column(
            children: <Widget>[
              Text(""),
              Padding(
                  padding: EdgeInsets.all(20.0),
                  child: const Text(
                      "機能を使う時にパスワードを必要にする場合は、\n対象の機能をロック! \n子供が自由にポイントを増やせないようにする場合は、ここでロックをかけます！")),
              const Text(""),
              const Text(""),
              const Text(""),
              const Text("ポイント強制変更"),
              Center(
                child: ToggleSwitch(
                    minWidth: 90.0,
                    cornerRadius: 20,
                    activeBgColor: Colors.green,
                    activeTextColor: Colors.white,
                    inactiveBgColor: Colors.grey,
                    inactiveTextColor: Colors.white,
                    labels: ['ロック', '解除'],
                    icons: [FontAwesome.lock, FontAwesome.unlock],
                    activeColors: [Colors.blue, Colors.pink],
                    initialLabelIndex: lockModel.pointChangePageState ? 0 : 1,
                    onToggle: (index) {
                      print('switched to: $index');
                      lockModel.changeLockStateOfPointChangePageState();
                    }),
              ),
              const Text(""),
              const Text(""),
              const Text("お手伝いポイントの取得"),
              Center(
                child: ToggleSwitch(
                    minWidth: 90.0,
                    cornerRadius: 20,
                    activeBgColor: Colors.green,
                    activeTextColor: Colors.white,
                    inactiveBgColor: Colors.grey,
                    inactiveTextColor: Colors.white,
                    labels: ['ロック', '解除'],
                    icons: [FontAwesome.lock, FontAwesome.unlock],
                    activeColors: [Colors.blue, Colors.pink],
                    initialLabelIndex: lockModel.laborGetState ? 0 : 1,
                    onToggle: (index) {
                      print('switched to: $index');
                      lockModel.changeLockStateOfLaborGetState();
                    }),
              )
            ],
          ));
    });
  }
}
