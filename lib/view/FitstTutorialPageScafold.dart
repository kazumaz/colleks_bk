import 'package:colleks/view/FirstTutorialPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sliding_tutorial/flutter_sliding_tutorial.dart';
import 'package:flutter_svg/flutter_svg.dart';


class FirstTutorialPageScafold extends StatefulWidget {
  FirstTutorialPageScafold({Key key}) : super(key: key);

  @override
  _FirstTutorialPageScafoldState createState() => _FirstTutorialPageScafoldState();
}

class _FirstTutorialPageScafoldState extends State<FirstTutorialPageScafold> {
  final ValueNotifier<double> notifier = ValueNotifier(0);
  int pageCount = 4;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Stack(
        children: <Widget>[
          FirstTutorialPage(
            pageCount: pageCount,
            notifier: notifier,
          ),
          Align(
            alignment: Alignment(0, 0.85),
            child: Container(
              width: double.infinity,
              height: 0.5,
              color: Colors.white,
            ),
          ),
          Align(
            alignment: Alignment(0, 0.94),
            child: SlidingIndicator(
              indicatorCount: pageCount,
              notifier: notifier,
              activeIndicator: Icon(
                Icons.check_circle,
                size: 10,
                color: Colors.white,
              ),
              inActiveIndicator: SvgPicture.asset(
                "images/hollow_circle.svg",
              ),
              margin: 8,
              sizeIndicator: 10,
            ),
          )
        ],
      )),
    );
  }
}