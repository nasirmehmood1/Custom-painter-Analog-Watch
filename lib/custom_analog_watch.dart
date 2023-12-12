import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class CustomAnalogWatch extends CustomPainter {
  final DateTime now;

  CustomAnalogWatch({required this.now});
  @override
  void paint(Canvas canvas, Size size) {
    final width = size.width;
    final height = size.height;
    final radius = min(height, width) / 2;
    final hoursTickWidth = radius * 0.03;
    final hoursTickHeight = radius * 0.15;
    final hoursNeedleBaseRadius = radius * 0.05;
    final minutesNeedleBaseRadius = radius * 0.025;
    final minutesTickWidth = radius * 0.015;
    final minutesTickHeight = radius * 0.08;
    final hoursNeedleWidth = radius * 0.05;
    final minutesNeedleWidth = radius * 0.03;
    final hoursNeedleGap = radius * 0.4;
    final minutesNeedleGap = radius * 0.5;
    final seconsNeedleGap = radius * 0.3;
    const totalNumberOfTicks = 60;
    const angle = 2 * pi / totalNumberOfTicks;
    final centreOffSet = Offset(width / 2, height / 2);

    final dialPaint = Paint()
      ..shader =  RadialGradient(
          colors: [Colors.blueGrey.shade100,Colors.amber.shade400,],
          ).createShader(Rect.fromLTWH(0, 0, width, height));
    final hoursPaint = Paint()
      ..color = Colors.blueAccent.shade200
      ..strokeWidth = hoursTickWidth;
    final minutesPaint = Paint()
      ..color = Colors.blueGrey.shade100
      ..strokeWidth = minutesTickWidth;
    final hoursNeedlePaint = Paint()
      ..color = Colors.white
      ..strokeWidth = hoursNeedleWidth
      ..strokeCap = StrokeCap.round;
    final MinutesNeedlePaint = Paint()
      ..color = Colors.white
      ..strokeWidth = minutesNeedleWidth
      ..strokeCap = StrokeCap.round;
    final seconsNeedlePaint = Paint()
      ..color = Colors.black
      ..strokeWidth = minutesNeedleWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(centreOffSet, radius, dialPaint);
    canvas.drawCircle(centreOffSet, hoursNeedleBaseRadius, hoursNeedlePaint);
    canvas.drawCircle(
        centreOffSet, minutesNeedleBaseRadius, MinutesNeedlePaint);
    canvas.save();
    canvas.translate(centreOffSet.dx, radius);
    for (var i = 0; i < totalNumberOfTicks; i++) {
      bool isHour = i % 5 == 0;
      double tickLength;
      Paint tickPaint;
      var hour = now.hour <= 12 ? now.hour : now.hour - 12;
      if (i / 5 == hour) {
        canvas.drawLine(Offset(0, -hoursNeedleBaseRadius),
            Offset(0, -radius + hoursNeedleGap), hoursNeedlePaint);
      }
      if (i == now.minute) {
        canvas.drawLine(Offset(0, -minutesNeedleBaseRadius),
            Offset(0, -radius + minutesNeedleGap), MinutesNeedlePaint);
      }
      if (i == now.second) {
        canvas.drawLine(Offset(0, -minutesNeedleBaseRadius),
            Offset(0, -radius + seconsNeedleGap), seconsNeedlePaint);
      }
      if (isHour) {
        tickLength = hoursTickHeight;
        tickPaint = hoursPaint;
      } else {
        tickLength = minutesTickHeight;
        tickPaint = minutesPaint;
      }
      canvas.drawLine(
          Offset(0, -radius), Offset(0, -radius + tickLength), tickPaint);
      canvas.rotate(angle);
    }
    canvas.restore();
    var textDate=(now.day).toString();
      TextPainter textDatePainter=TextPainter();
      textDatePainter.textDirection=TextDirection.ltr;
      textDatePainter.text=TextSpan(style: const TextStyle(fontSize: 16,color: Colors.white,fontWeight: FontWeight.w500,shadows: [Shadow(
        color: Colors.blue,blurRadius: 1,offset: Offset(-1, -1)
      )]),
        text:textDate, 
      );
      textDatePainter.layout();
      textDatePainter.paint(canvas, Offset(centreOffSet.dx+25,centreOffSet.dy-10));
      var textMonth=(now.month).toString();
      TextPainter textMonthPainter=TextPainter();
      textMonthPainter.textDirection=TextDirection.ltr;
      textMonthPainter.text=TextSpan(style: const TextStyle(fontSize: 16,color: Colors.white,fontWeight: FontWeight.w500,shadows: [Shadow(
        color: Colors.blue,blurRadius: 1,offset: Offset(-1, -1)
      )]),
        text:textMonth, 
      );
      textMonthPainter.layout();
      textMonthPainter.paint(canvas, Offset(centreOffSet.dx-10,centreOffSet.dy+30));
  }

  @override
  bool shouldRepaint(CustomAnalogWatch oldDelegate) => true;
  @override
  bool shouldRebuildSemantics(CustomAnalogWatch oldDelegate) => true;
}
