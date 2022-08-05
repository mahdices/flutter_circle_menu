import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:vector_math/vector_math.dart' as vm;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int count = 6;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 300,
              height: 300,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CustomPaint(
                    size: Size(300, 300),
                    painter: CircleCustomPainer(count),
                  ),
                  Center(child: getWidgets(count, Size(300, 300)))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CircleCustomPainer extends CustomPainter {
  final int count;
  CircleCustomPainer(this.count);
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    paint.color = Colors.red;
    Paint paint1 = Paint();
    paint1.color = Colors.white;
    paint1.strokeWidth = 4;
    paint1.style = PaintingStyle.stroke;
    canvas.drawCircle(
        Offset(size.width / 2, size.height / 2), size.height / 2, paint);
    // vm.degrees(radians);
    // vm.radians(degrees);
    // vm.
    Path path = Path();
    path.moveTo(size.width / 2, size.height / 2);
    for (var i = 0; i < count; i++) {
      var o = (2 * i * math.pi) / count;
      var x = 150 * math.cos(o) + (size.width / 2);
      var y = 150 * math.sin(o) + (size.height / 2);
      path.lineTo(x, y);
      path.moveTo(size.width / 2, size.height / 2);
    }

    // for (var i = 0; i < 6; i++) {
    //   var o = ((2 * math.pi) / 6) * i + (math.pi / 2);
    //   var x =
    // }

    canvas.drawPath(path, paint1);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

Widget getWidgets(int count, Size size) {
  List<Widget> list = [];

  for (var i = 0; i < count; i++) {
    var o = (2 * i * math.pi) / count;
    o = o + ((360 / count) / 57.2958) / 2;
    var x = (size.width / 3) * math.cos(o) + (size.width / 2);
    var y = (size.width / 3) * math.sin(o) + (size.height / 2);

    list.add(Positioned.fromRect(
      rect: Rect.fromCenter(center: Offset(x, y), height: 60, width: 60),
      child: Column(
        children: [
          Container(
            color: Colors.black,
            width: 60,
            height: 60,
          ),
        ],
      ),
    ));
  }

  return Container(
    width: 300,
    height: 300,
    alignment: Alignment.center,
    child: Stack(
      children: list,
    ),
  );
}
