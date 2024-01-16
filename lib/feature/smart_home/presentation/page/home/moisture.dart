import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/power/power_bloc.dart';

class MoistureDropWidget extends StatefulWidget {
  const MoistureDropWidget({
    super.key,
  });

  @override
  State<MoistureDropWidget> createState() => _MoistureDropWidgetState();
}

class _MoistureDropWidgetState extends State<MoistureDropWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _animation = Tween<double>(
            begin: 0, end: context.read<PowerBloc>().state.power.moisture * 100)
        .animate(_controller)
      ..addListener(() {
        setState(() {});
      });

    _controller.forward();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _animation = Tween<double>(
      begin: 0,
      end: context.watch<PowerBloc>().state.power.moisture * 100,
    ).animate(_controller)
      ..addListener(() {
        setState(() {});
      });

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Image.asset(
              'assets/battery_bg.png',
              fit: BoxFit.cover,
            ),
          ),
          SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.arrow_back,
                            color: Colors.white.withOpacity(0.6),
                            size: 40,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.electric_moped,
                                color: const Color.fromRGBO(255, 176, 57, 1)
                                    .withOpacity(0.6),
                                size: 25,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                'Reserve Electricity',
                                softWrap: true,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'JosefinSans',
                                  fontWeight: FontWeight.w300,
                                  color: const Color.fromRGBO(255, 176, 57, 1)
                                      .withOpacity(0.6),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Text(
                            'Plants moisture level',
                            softWrap: true,
                            style: TextStyle(
                              fontSize: 30,
                              fontFamily: 'JosefinSans',
                              fontWeight: FontWeight.bold,
                              color: const Color.fromARGB(255, 255, 255, 255)
                                  .withOpacity(0.6),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.1),
                      ),
                    ),
                    child: Text(
                      context.watch<PowerBloc>().state.power.moisture == 1
                          ? 'full charged'
                          : '${((1 - context.watch<PowerBloc>().state.power.moisture) * 100).toInt()}%  until full  normal level.',
                      softWrap: true,
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'JosefinSans',
                        fontWeight: FontWeight.w600,
                        color: const Color.fromARGB(255, 255, 255, 255)
                            .withOpacity(0.6),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Transform.rotate(
                    angle: 180 * 3.1415926535 / 180,
                    child: SizedBox(
                      height: MediaQuery.of(context).size.width * 0.9,
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: CustomPaint(
                        painter:
                            MoistureDropPainter(percentage: _animation.value),
                        size: Size(MediaQuery.of(context).size.width,
                            MediaQuery.of(context).size.width * 0.3),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    '${(context.watch<PowerBloc>().state.power.moisture * 100).toInt()} %',
                    softWrap: true,
                    style: TextStyle(
                      fontSize: 30,
                      fontFamily: 'JosefinSans',
                      fontWeight: FontWeight.w500,
                      color: const Color.fromARGB(255, 255, 255, 255)
                          .withOpacity(0.6),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      context.read<PowerBloc>().add(const SetPumpEvent('2'));
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: const Color.fromRGBO(1, 127, 97, 1),
                      ),
                      child: Icon(
                        !context.watch<PowerBloc>().state.pump.pump2
                            ? Icons.on_device_training
                            : Icons.offline_bolt_outlined,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class MoistureDropPainter extends CustomPainter {
  final double percentage;

  MoistureDropPainter({required this.percentage});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;

    Paint borderPaint = Paint()
      ..color = const Color.fromARGB(255, 240, 233, 233)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    double baseWidth = size.width + 125;
    double dropHeight = size.height * 0.04;

    Path path = Path()
      ..moveTo(size.width / 2, 0)
      ..quadraticBezierTo(size.width / 2 + baseWidth / 2, dropHeight,
          size.width / 2, size.height)
      ..quadraticBezierTo(
          size.width / 2 - baseWidth / 2, dropHeight, size.width / 2, 0)
      ..close();

    canvas.drawPath(path, borderPaint);

    double clipHeight = size.height * (percentage / 100);

    canvas.clipRect(
        Rect.fromPoints(const Offset(0, 0), Offset(size.width, clipHeight)));

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
