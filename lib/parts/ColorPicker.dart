import 'package:flutter/material.dart';
import 'package:colleks/model/ColorModel.dart';
import 'package:provider/provider.dart';

class SelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: GridView.count(
            crossAxisCount: 5, // 1行に表示する数
            crossAxisSpacing: 8.0, // 縦スペース
            mainAxisSpacing: 8.0, // 横スペース
            shrinkWrap: true,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.lens, color: Colors.blue),
                iconSize: 60.0,
                onPressed: () {
                  Provider.of<ColorModel>(context, listen: false).setBlue();
                },
              ),
              IconButton(
                icon: Icon(Icons.lens, color: Colors.red),
                iconSize: 65.0,
                onPressed: () {
                  Provider.of<ColorModel>(context, listen: false).setRed();
                },
              ),
              IconButton(
                icon: Icon(Icons.lens, color: Colors.purple),
                iconSize: 65.0,
                onPressed: () {
                  Provider.of<ColorModel>(context, listen: false).setPurple();
                },
              ),
              IconButton(
                icon: Icon(Icons.lens, color: Colors.pink),
                iconSize: 65.0,
                onPressed: () {
                  Provider.of<ColorModel>(context, listen: false).setPink();
                },
              ),
              IconButton(
                icon: Icon(Icons.lens, color: Colors.orange),
                iconSize: 65.0,
                onPressed: () {
                  Provider.of<ColorModel>(context, listen: false).setOrange();
                },
              ),
              IconButton(
                icon: Icon(Icons.lens, color: Colors.cyan),
                iconSize: 65.0,
                onPressed: () {
                  Provider.of<ColorModel>(context, listen: false).setCyan();
                },
              ),
              IconButton(
                icon: Icon(Icons.lens, color: Colors.teal),
                iconSize: 65.0,
                onPressed: () {
                  Provider.of<ColorModel>(context, listen: false).setTeal();
                },
              ),
              IconButton(
                icon: Icon(Icons.lens, color: Colors.indigo),
                iconSize: 65.0,
                onPressed: () {
                  Provider.of<ColorModel>(context, listen: false).setIndigo();
                },
              ),
              IconButton(
                icon: Icon(Icons.lens, color: Colors.brown),
                iconSize: 65.0,
                onPressed: () {
                  Provider.of<ColorModel>(context, listen: false).setBrown();
                },
              ),
              IconButton(
                icon: Icon(Icons.lens, color: Colors.yellow),
                iconSize: 65.0,
                onPressed: () {
                  Provider.of<ColorModel>(context, listen: false).setYellow();
                },
              ),
              IconButton(
                icon: Icon(Icons.lens, color: Colors.lightGreen),
                iconSize: 65.0,
                onPressed: () {
                  Provider.of<ColorModel>(context, listen: false).setLightGreen();
                },
              ),
              IconButton(
                icon: Icon(Icons.lens, color: Colors.grey),
                iconSize: 65.0,
                onPressed: () {
                  Provider.of<ColorModel>(context, listen: false).setGrey();
                },
              ),
              IconButton(
                icon: Icon(Icons.lens, color: Colors.deepPurple),
                iconSize: 65.0,
                onPressed: () {
                  Provider.of<ColorModel>(context, listen: false).setDeepPurple();
                },
              ),
              IconButton(
                icon: Icon(Icons.lens, color: Colors.deepOrange),
                iconSize: 65.0,
                onPressed: () {
                  Provider.of<ColorModel>(context, listen: false).setDeepOrange();
                },
              ),
              IconButton(
                icon: Icon(Icons.lens, color: Colors.blueGrey),
                iconSize: 65.0,
                onPressed: () {
                  Provider.of<ColorModel>(context, listen: false).setBlueGray();
                },
              ),
            ]),
      );
}
