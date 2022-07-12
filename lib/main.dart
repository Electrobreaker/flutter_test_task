import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const Main());
}
///Main class with main widget
class Main extends StatelessWidget {
  ///constructor
  const Main({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: const MyHomePage(title: 'Test App'),
    );
  }
}
///Main Page
class MyHomePage extends StatefulWidget {
  ///AppBar title
  final String title;
  ///constructor
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Random randomGenerator = Random();
  int R = 0;
  int G = 0;
  int B = 0;
  int maxRGBValue = 256;
  double fontSize = 20;
  int maxFontSize = 20;
  double turns = 0;
  int duration = 0;
  int maxTurnsOrDurationValue = 3;
  int textColorId = 0;
  double verticalPosition = 0.0;
  double prevPosition = 0;
  double moveStep = 0.02;

  List <Color> textColors = [
    Colors.deepOrangeAccent,
    Colors.orange,
    Colors.blue,
    Colors.red,
    Colors.purple,
    Colors.green,
    Colors.white,
    Colors.black
  ];

  int getRandomRGBValue() {
    return randomGenerator.nextInt(maxRGBValue);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(R, G, B, 1),
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: GestureDetector(
        onTap: () {
          setState(() {
            R = getRandomRGBValue();
            G = getRandomRGBValue();
            B = getRandomRGBValue();
          });
        },
        onLongPressEnd: (LongPressEndDetails details) {
          setState(() {
            fontSize = maxFontSize.toDouble() +
                randomGenerator.nextInt(maxFontSize);
          });
        },
        onVerticalDragUpdate: (DragUpdateDetails details) {
          final double currentDirection = details.localPosition.direction;

          if (prevPosition > currentDirection && verticalPosition <= 1.0) {
            verticalPosition += moveStep;
          } else if (prevPosition < currentDirection && verticalPosition >= -1.0) {
            verticalPosition -= moveStep;
          }

          if (prevPosition != currentDirection) {
            setState(() {
              prevPosition = currentDirection;
            });
          }
        },
        onVerticalDragEnd: (DragEndDetails details) {
          setState(() {
            duration = 1 + randomGenerator.nextInt(maxTurnsOrDurationValue);
            turns = 1.0 + randomGenerator.nextInt(maxTurnsOrDurationValue);
          });
        },
        onDoubleTap: () {
          var newColorId = randomGenerator.nextInt(textColors.length - 1);
          while (textColorId == newColorId) {
            newColorId = randomGenerator.nextInt(textColors.length - 1);
          }
          setState(() {
            textColorId = newColorId;
          });
        },
        behavior: HitTestBehavior.translucent,
        child: Align(
          alignment: Alignment(0, verticalPosition),
          child:
            AnimatedRotation(
              turns: turns,
              duration: Duration(seconds: duration),
              child: Text('Hey there',
                style: TextStyle(
                  fontSize: fontSize,
                  color: textColors[textColorId],
                ),
              ),
            ),
        ),
      ),
    );
  }
}
