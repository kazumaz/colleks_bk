import 'package:flutter/material.dart';
import 'package:flutter_sliding_tutorial/flutter_sliding_tutorial.dart';

class TutorialFirstPage extends StatelessWidget {
  final int page;
  final ValueNotifier<double> notifier;

  TutorialFirstPage(this.page, this.notifier);

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
                        "ありがとうを集めて、ご褒美をもらう",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          decoration: TextDecoration.none,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        
                      ),
                    ),
                    Text(""),
                    SlidingContainer(
                      offset: 300,
                      child: Text(
                        "ポイント管理",
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
                      offset: 200,
                      child: Text(
                        "お手伝い管理",
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
                      offset: 100,
                      child: Text(
                        "ご褒美管理",
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
                      "images/first_cut.png",
                    ),
                    offset: 50),
              ),
            ),
            // Center(
            //   child: FractionallySizedBox(
            //     widthFactor: 0.55,
            //     heightFactor: 0.18,
            //     child: SlidingContainer(
            //         child: Image.asset(
            //           "images/jump.png",
            //         ),
            //         offset: 100),
            //   ),
            // ),
            // Opacity(
            //   opacity: 0.5,
            //   child: Align(
            //     alignment: Alignment(0.3, -0.35),
            //     child: FractionallySizedBox(
            //       widthFactor: 0.75,
            //       heightFactor: 0.20,
            //       child: SlidingContainer(
            //           child: Image.asset(
            //             "images/jump.png",
            //           ),
            //           offset: 170),
            //     ),
            //   ),
            // ),
            // Align(
            //   alignment: Alignment(-0.2, -0.27),
            //   child: FractionallySizedBox(
            //     widthFactor: 0.16,
            //     heightFactor: 0.07,
            //     child: SlidingContainer(
            //         child: Image.asset(
            //           "images/jump.png",
            //         ),
            //         offset: 50),
            //   ),
            // ),
            // Align(
            //   alignment: Alignment(0.3, -0.35),
            //   child: FractionallySizedBox(
            //     widthFactor: 0.14,
            //     heightFactor: 0.07,
            //     child: SlidingContainer(
            //         child: Image.asset(
            //           "images/jump.png",
            //         ),
            //         offset: 150),
            //   ),
            // ),
            // Align(
            //   alignment: Alignment(0.8, -0.3),
            //   child: FractionallySizedBox(
            //     widthFactor: 0.15,
            //     heightFactor: 0.10,
            //     child: SlidingContainer(
            //         child: Image.asset(
            //           "images/jump.png",
            //         ),
            //         offset: 50),
            //   ),
            // ),
            // Align(
            //   alignment: Alignment(0.7, 0.1),
            //   child: FractionallySizedBox(
            //     widthFactor: 0.25,
            //     heightFactor: 0.15,
            //     child: SlidingContainer(
            //         child: Image.asset(
            //           "images/jump.png",
            //         ),
            //         offset: 200),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
