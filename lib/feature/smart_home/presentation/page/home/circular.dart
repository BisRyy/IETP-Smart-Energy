import 'dart:math' as math;

import 'package:flutter/material.dart';

class TripleCircularTimerWidget extends StatefulWidget {
  const TripleCircularTimerWidget({
    required this.waterProgress,
    required this.moistureProgress,
    required this.electricityProgress,
    Key? key,
  }) : super(key: key);

  final double waterProgress;
  final double moistureProgress;
  final double electricityProgress;

  @override
  State<TripleCircularTimerWidget> createState() =>
      _TripleCircularTimerWidgetState();
}

class _TripleCircularTimerWidgetState extends State<TripleCircularTimerWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              height: MediaQuery.of(context).size.width * 0.7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.7,
                    height: MediaQuery.of(context).size.width * 0.7,
                    child: CircularTimer(
                      type: 'electricity',
                      progress: widget.electricityProgress,
                      gradient: const LinearGradient(
                        colors: [
                          Color.fromRGBO(148, 223, 205, 1),
                          Color.fromRGBO(1, 127, 97, 1),
                        ],
                        stops: [0.0, 1.0],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      progressColor: const Color.fromRGBO(1, 127, 97, 1),
                      strokeWidth: 30.0,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              height: MediaQuery.of(context).size.width * 0.7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.555,
                    height: MediaQuery.of(context).size.width * 0.555,
                    child: CircularTimer(
                      type: 'moisture',
                      progress: widget.moistureProgress,
                      gradient: const LinearGradient(
                        colors: [
                          Color.fromRGBO(204, 221, 223, 1),
                          Color.fromRGBO(41, 117, 126, 1),
                        ],
                        stops: [0.0, 1.0],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      progressColor: const Color.fromRGBO(67, 57, 126, 1),
                      strokeWidth: 30.0,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.7,
          height: MediaQuery.of(context).size.width * 0.7,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.422,
                height: MediaQuery.of(context).size.width * 0.422,
                child: CircularTimer(
                  type: 'water',
                  progress: widget.waterProgress,
                  gradient: const LinearGradient(
                    colors: [
                      Color.fromRGBO(192, 222, 226, 1),
                      Color.fromRGBO(97, 197, 212, 1),
                    ],
                    stops: [0.0, 1.0],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  progressColor: const Color.fromRGBO(1, 127, 97, 1),
                  strokeWidth: 25.0,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class CircularTimer extends StatelessWidget {
  final double progress;
  final Gradient gradient;
  final Color progressColor;
  final double strokeWidth;
  final String type;

  const CircularTimer({
    super.key,
    required this.type,
    required this.progress,
    required this.gradient,
    required this.progressColor,
    required this.strokeWidth,
  });

  @override
  Widget build(BuildContext context) {
    final String progressString = (progress * 100).toStringAsFixed(0);
    return CustomPaint(
      painter: CircularTimerPainter(
        type: type,
        progress: progress,
        gradient: gradient,
        progressColor: progressColor,
        strokeWidth: strokeWidth,
      ),
      child: Center(
        child: type == 'water'
            ? Padding(
                padding: const EdgeInsets.only(bottom: 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Water:',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color.fromRGBO(97, 197, 212, 1),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      '$progressString%',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color.fromRGBO(97, 197, 212, 1),
                      ),
                    ),
                  ],
                ),
              )
            : type == 'moisture'
                ? Padding(
                    padding: const EdgeInsets.only(top: 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Moisture:',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color.fromRGBO(47, 121, 129, 1),
                          ),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          '$progressString%',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color.fromRGBO(47, 121, 129, 1),
                          ),
                        ),
                      ],
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Electricity:',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color.fromRGBO(1, 127, 97, 1),
                          ),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          '$progressString%',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color.fromRGBO(1, 127, 97, 1),
                          ),
                        ),
                      ],
                    ),
                  ),
      ),
    );
  }
}

class CircularTimerPainter extends CustomPainter {
  final String type;
  final double progress;
  final Gradient gradient;
  final Color progressColor;
  final double strokeWidth;

  CircularTimerPainter({
    required this.type,
    required this.progress,
    required this.gradient,
    required this.progressColor,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = size.width / 2.0;

    final Paint backgroundPaint = Paint()
      ..color = type == 'biogas'
          ? const Color.fromARGB(255, 139, 140, 168).withOpacity(0.2)
          : const Color.fromARGB(255, 169, 169, 185).withOpacity(0.2)
      ..strokeCap = StrokeCap.round
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(center, radius, backgroundPaint);

    final Paint fillPaint = Paint()
      ..shader =
          gradient.createShader(Rect.fromCircle(center: center, radius: radius))
      ..strokeCap = StrokeCap.round
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      2 * math.pi * progress,
      false,
      fillPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
