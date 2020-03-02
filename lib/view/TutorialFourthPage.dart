import 'package:flutter/material.dart';
import 'package:flutter_sliding_tutorial/flutter_sliding_tutorial.dart';

class TutorialFourthPage extends StatelessWidget {
  final int page;
  final ValueNotifier<double> notifier;

  TutorialFourthPage(this.page, this.notifier);

  @override
  Widget build(BuildContext context) {
    return 
    
      SlidingPage(
      notifier: notifier,
      page: page,
      child: Container(
        alignment: Alignment.center,
        child: 
        
        
        InkWell(
          onTap: () {
             Navigator.of(context).pushNamed("/home");
          },
          child: Text(
                        "はじめる",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          decoration: TextDecoration.none,
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        
                      ),)
        
      ),
    );
  }
}

