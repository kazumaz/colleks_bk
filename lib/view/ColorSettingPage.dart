import 'package:colleks/model/RewardModel.dart';
import 'package:colleks/parts/ColorPicker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ColorSettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<RewordModel>(builder: (context, rewardModel, child) {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: Theme.of(context).primaryColor,
          elevation: 0.0,
          title: const Text("テーマカラーを選択"), //TODO タイトルを正しくする
        ),
        body: SelectionScreen(),
      );
    });
  }
}
