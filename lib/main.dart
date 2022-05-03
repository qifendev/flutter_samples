import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DragDownDetails? _down;
  DragEndDetails? _end;
  DragUpdateDetails? _update;

  @override
  Widget build(BuildContext context) {
    double size =
        MediaQuery.of(context).size.width < MediaQuery.of(context).size.height
            ? MediaQuery.of(context).size.width
            : MediaQuery.of(context).size.height;

    return Scaffold(
      body: Center(
          child: GestureDetector(
        child: CustomPaint(
          painter: Cp(_down, _end, _update),
          size: Size(size, size),
        ),
        onPanDown: (c) {
          print('down');
          setState(() {
            _down = c;
          });
        },
        onPanEnd: (c) {
          print('end');

          setState(() {
            _end = c;
          });
        },
        onPanUpdate: (c) {
          print('update');

          setState(() {
            _update = c;
          });
        },
      )),
    );
  }
}

class Cp extends CustomPainter {
  Paint _paint = new Paint()
    ..color = Colors.red //画笔颜色
    ..strokeCap = StrokeCap.round //画笔笔触类型
    ..isAntiAlias = true //是否启动抗锯齿
    ..style = PaintingStyle.stroke //绘画风格，默认为填充
    ..filterQuality = FilterQuality.high //颜色渲染模式的质量
    ..strokeWidth = 2; //画笔的宽度

  DragDownDetails? _down;
  DragEndDetails? _end;
  DragUpdateDetails? _update;

  Cp(this._down, this._end, this._update);

  // ..blendMode = BlendMode.exclusion //颜色混合模式
  // ..colorFilter = ColorFilter.mode(Colors.red,
  // BlendMode.exclusion) //颜色渲染模式，一般是矩阵效果来改变的，但   是flutter中只能使用颜色混合模式

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawCircle(Offset(size.width / 2, size.height / 2),
        (size.width < size.height ? size.width : size.height) / 2, _paint);




  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
