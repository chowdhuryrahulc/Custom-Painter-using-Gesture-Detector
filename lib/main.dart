// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

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
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Offset>? points = <Offset>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: GestureDetector(
          // onPanUpdate is when we start moving pointer on the screen
          onPanUpdate: (DragUpdateDetails details) {
            setState(() {
              RenderBox object = context.findRenderObject()
                  as RenderBox; // Here RenderObject gives the Whole Container
              // We need position
              // detais will give position
              // We will get Global position and then convert to Local position
              Offset localPosition =
                  object.globalToLocal(details.globalPosition);
              // Here we get local Position
              // We can draw something with Local Position
              // now we add these Local position to points
              points = List.from(points!)..add(localPosition);
              // pass points to Signature class
            });
          },
          onPanEnd: (DragEndDetails details) {
            points!.add(Offset.infinite); //! when Drawing stops
          },
          child: CustomPaint(
            painter: Signature(points: points!),
            size: Size.infinite,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.clear),
        onPressed: () {
          points!.clear();
        },
      ),
    );
  }
}

// We will paint only if something changes
class Signature extends CustomPainter {
  List<Offset>? points = []; // Offset is x,y axis point
  Signature({this.points}); // we are sending  points from above

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint

    Paint paint = Paint()
      ..color = Colors.black
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5.0;

    // See what points we are getting
    for (int i = 0; i < points!.length - 1; i++) {
      // points[i] represents starting point where we start to draw
      // points[i+1] represents where we stop drawing
      //? if (points[i]!= null && points[i+1]!= null)
      // if point in i position != null
      //? {}
      canvas.drawLine(points![i], points![i + 1], paint);
    }
  }

  @override
  bool shouldRepaint(Signature oldDelegate) {
    // TODO: implement shouldRepaint
    return oldDelegate.points !=
        points; // if oldClipper.points != points => repaint it
    // throw UnimplementedError();
  }
}
