import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_home/feature/smart_home/presentation/bloc/power/power_bloc.dart';

class Electric extends StatefulWidget {
  const Electric({
    Key? key,
  }) : super(key: key);

  @override
  State<Electric> createState() => _ElectricState();
}

Random random = Random();

class _ElectricState extends State<Electric>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _animation = Tween<double>(
            begin: 0, end: context.read<PowerBloc>().state.power.power)
        .animate(_animationController);

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
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
                                color: Color.fromRGBO(255, 176, 57, 1)
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
                                  color: Color.fromRGBO(255, 176, 57, 1)
                                      .withOpacity(0.6),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Text(
                            'How much energy do you have?',
                            softWrap: true,
                            style: TextStyle(
                              fontSize: 30,
                              fontFamily: 'JosefinSans',
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 255, 255, 255)
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
                      horizontal: 40,
                      vertical: 20,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.1),
                      ),
                    ),
                    child: Text(
                      '${((1 - context.watch<PowerBloc>().state.power.power) * 100).toInt()}%  until full charge.',
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
                  BatteryPercentage(animation: _animation),
                  const SizedBox(height: 20),
                  Text(
                    '${(context.watch<PowerBloc>().state.power.power * 100).toInt()} %',
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
                      context.read<PowerBloc>().add(const SetPumpEvent('3'));
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: const Color.fromRGBO(1, 127, 97, 1),
                      ),
                      child: Icon(
                        !context.watch<PowerBloc>().state.pump.pump3
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
}

class BatteryPercentage extends StatelessWidget {
  const BatteryPercentage({Key? key, required this.animation})
      : super(key: key);

  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (BuildContext context, Widget? child) {
        return Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 5),
              height: (MediaQuery.of(context).size.height * 0.03),
              width: MediaQuery.of(context).size.height * 0.1,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: CustomPaint(
                painter: BatteryPainter(percentage: animation.value),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height * 0.39,
              width: MediaQuery.of(context).size.height * 0.25,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20)),
              child: ListView.builder(
                itemCount: 6,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    height: (MediaQuery.of(context).size.height * 0.5) / 6 - 30,
                    decoration: BoxDecoration(
                      color: BatteryPainter.getBatteryColor(
                          animation.value, index),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

class BatteryPainter extends CustomPainter {
  final double percentage;

  BatteryPainter({required this.percentage});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = getBatteryColor(percentage, 0)
      ..style = PaintingStyle.fill;

    canvas.drawRect(
      Rect.fromPoints(const Offset(0, 0), Offset(size.width, size.height)),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  static Color getBatteryColor(double percentage, int index) {
    double threshold = 0.86 - (index * 0.14);
    return percentage >= threshold
        ? const Color.fromRGBO(53, 193, 107, 1)
        : const Color.fromRGBO(51, 51, 51, 1);
  }
}
