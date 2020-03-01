import 'package:colleks/model/PasswordModel.dart';
import 'package:colleks/model/LockModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_sliding_tutorial/flutter_sliding_tutorial.dart';

class FirstTutorialPage extends StatefulWidget {
   final ValueNotifier<double> notifier;
  final int pageCount;

    const FirstTutorialPage(
      {Key key, @required this.notifier, @required this.pageCount})
      : super(key: key);

  @override
  _FirstTutorialPageState createState() => _FirstTutorialPageState();
}

class _FirstTutorialPageState extends State<FirstTutorialPage> {

  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
     return Scaffold(
          appBar: AppBar(title: Text("履歴"), actions: <Widget>[
            IconButton(
                icon: Icon(Icons.help_outline),
                onPressed: () {
                   Navigator.of(context).pushNamed("/home");
                  // initTargets();
                  // showTutorial(context);
                })
          ]),
          // body: Text("test")
          body:
          PageView(
      controller: _pageController,
      children: List<Widget>.generate(
        widget.pageCount,
        /// SlidingPage must be the parent for the SlidingContainer
        (index) => SlidingPage(
            page: index,
            notifier: widget.notifier,
            /// create UI as you need
            child: Stack(overflow: Overflow.visible, children: [
              /// wrap the desired widget in the SlidingContainer
              SlidingContainer(
                /// set your own widget
                child: Center(child: Text("Title: $index")), 
                /// set the necessary offset for the widget
                offset: 200,
              ),
              SlidingContainer(
                child: Container(
                    margin: EdgeInsets.only(top: 50),
                    child: Center(child: Text("Description: $index"))),
                offset: 350,
              )
            ])),
      )) 

     );
}
}



