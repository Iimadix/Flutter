import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: PainterPage(),
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: Colors.deepPurple,
      appBarTheme: AppBarTheme(
        elevation: 0,
        centerTitle: true,
      ),
    ),
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
        title: Text('Холст для рисовалки', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.deepPurple[50],
        foregroundColor: Colors.deepPurple,
        actions: [
          Tooltip(
            message: 'Очистить холст',
            child: IconButton(
              icon: Icon(Icons.delete_outline, size: 28),
              onPressed: () {
                setState(() {
                  points.clear();
                  colors.clear();
                  paints.clear();
                });
              },
            ),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.deepPurple[50]!, Colors.white],
          ),
        ),
        child: GestureDetector(
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
      ),
      bottomNavigationBar: Container(
        height: 80,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, -2),
            )
          ],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildColorButton(Colors.red, Icons.brush),
            _buildColorButton(Colors.blue, Icons.brush),
            _buildColorButton(Colors.green, Icons.brush),
            _buildColorButton(Colors.black, Icons.brush),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Толщина', style: TextStyle(fontSize: 12)),
                Container(
                  width: 120,
                  child: Slider(
                    value: strokeWidth,
                    min: 1.0,
                    max: 20.0,
                    activeColor: Colors.deepPurple,
                    inactiveColor: Colors.deepPurple[100],
                    onChanged: (newValue) {
                      setState(() {
                        strokeWidth = newValue;
                      });
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildColorButton(Color color, IconData icon) {
    return Tooltip(
      message: color.toString().split('(')[1].split(')')[0],
      child: InkWell(
        onTap: () {
          setState(() {
            currentColor = color;
          });
        },
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: currentColor == color ? color.withOpacity(0.3) : Colors.transparent,
          ),
          child: Center(
            child: Icon(icon, color: color, size: 24),
          ),
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
