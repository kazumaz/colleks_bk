import 'package:flutter/material.dart';
import 'package:flutter_sliding_tutorial/flutter_sliding_tutorial.dart';

class TutorialThirdPage extends StatelessWidget {
  final int page;
  final ValueNotifier<double> notifier;

  TutorialThirdPage(this.page, this.notifier);

  @override
  Widget build(BuildContext context) {
    return SlidingPage(
      notifier: notifier,
      page: page,
      child: Container(
        child: Stack(
          overflow: Overflow.visible,
          children: [
            Align(
                // alignment: Alignment(0, 0.78),
                alignment: Alignment.topCenter,
                child: Column(
                  children: <Widget>[
                    Text(
                      "",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        decoration: TextDecoration.none,
                        fontSize: 30,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        decoration: TextDecoration.none,
                        fontSize: 30,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        decoration: TextDecoration.none,
                        fontSize: 30,
                        color: Colors.white,
                      ),
                    ),
                    SlidingContainer(
                      offset: 500,
                      child: Text(
                        "操作がわからなければ",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          decoration: TextDecoration.none,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SlidingContainer(
                      offset: 300,
                      child: Text(
                        "画面右上の(？)をクリック",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          decoration: TextDecoration.none,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                )),
            Container(
              alignment: Alignment.bottomCenter,
              child: FractionallySizedBox(
                widthFactor: 0.8,
                heightFactor: 0.8,
                child: SlidingContainer(
                    child: Image.asset(
                      "images/third_cut.png",
                    ),
                    offset: 50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
