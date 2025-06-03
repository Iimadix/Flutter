import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: PainterPage(),
    debugShowCheckedModeBanner: false,
  ));
}

class PainterPage extends StatefulWidget {
  const PainterPage({Key? key}) : super(key: key);

  @override
  _PainterPageState createState() => _PainterPageState();
}

class _PainterPageState extends State<PainterPage> {
  List<Offset?> points = [];
  List<Color> colors = [];
  Color currentColor = Colors.black;
  double strokeWidth = 3.0;
  List<Paint> paints = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Рисовалка'),
        actions: [
          IconButton(
            icon: Icon(Icons.clear),
            onPressed: () {
              setState(() {
                points.clear();
                colors.clear();
                paints.clear();
              });
            },
          ),
        ],
      ),
      body: GestureDetector(
        onPanStart: (details) {
          setState(() {
            points.add(details.localPosition);
            colors.add(currentColor);
            paints.add(Paint()
              ..color = currentColor
              ..strokeWidth = strokeWidth
              ..strokeCap = StrokeCap.round
              ..style = PaintingStyle.stroke);
          });
        },
        onPanUpdate: (details) {
          setState(() {
            points.add(details.localPosition);
            colors.add(currentColor);
            paints.add(Paint()
              ..color = currentColor
              ..strokeWidth = strokeWidth
              ..strokeCap = StrokeCap.round
              ..style = PaintingStyle.stroke);
          });
        },
        onPanEnd: (details) {
          setState(() {
            points.add(null);
            colors.add(Colors.transparent);
            paints.add(Paint());
          });
        },
        child: CustomPaint(
          painter: SketchPainter(points: points, colors: colors, paints: paints),
          child: Container(
            width: double.infinity,
            height: double.infinity,
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.color_lens, color: Colors.red),
              onPressed: () {
                setState(() {
                  currentColor = Colors.red;
                });
              },
            ),
            IconButton(
              icon: Icon(Icons.color_lens, color: Colors.blue),
              onPressed: () {
                setState(() {
                  currentColor = Colors.blue;
                });
              },
            ),
            IconButton(
              icon: Icon(Icons.color_lens, color: Colors.green),
              onPressed: () {
                setState(() {
                  currentColor = Colors.green;
                });
              },
            ),
            Slider(
              value: strokeWidth,
              min: 1.0,
              max: 10.0,
              onChanged: (newValue) {
                setState(() {
                  strokeWidth = newValue;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SketchPainter extends CustomPainter {
  final List<Offset?> points;
  final List<Color> colors;
  final List<Paint> paints; 

  SketchPainter({required this.points, required this.colors, required this.paints});

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i]!, points[i + 1]!, paints[i]);
      }
    }
  }

  @override
  bool shouldRepaint(covariant SketchPainter oldDelegate) {
    return true;
  }
}