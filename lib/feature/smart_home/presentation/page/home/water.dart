import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_home/feature/smart_home/presentation/bloc/power/power_bloc.dart';

class WaterDropWidget extends StatefulWidget {
  const WaterDropWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<WaterDropWidget> createState() => _WaterDropWidgetState();
}

class _WaterDropWidgetState extends State<WaterDropWidget>
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
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _animation = Tween<double>(
      begin: 0,
      end: context.watch<PowerBloc>().state.power.water * 100,
    ).animate(_controller)
      ..addListener(() {
        setState(() {});
      });

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<PowerBloc, PowerState>(
        builder: (context, state) {
          return Stack(
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 10),
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
                                      color:
                                          const Color.fromRGBO(255, 176, 57, 1)
                                              .withOpacity(0.6),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 5),
                              Text(
                                'How much water do you have?',
                                softWrap: true,
                                style: TextStyle(
                                  fontSize: 30,
                                  fontFamily: 'JosefinSans',
                                  fontWeight: FontWeight.bold,
                                  color:
                                      const Color.fromARGB(255, 255, 255, 255)
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
                          context.watch<PowerBloc>().state.power.water == 1
                              ? 'full charged'
                              : '${((1 - context.watch<PowerBloc>().state.power.water) * 100).toInt()}%  until full tanker.',
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(width: 20),
                          Container(
                            height: 40,
                            width: 100,
                            margin: const EdgeInsets.only(right: 8),
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                              ),
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                          ),
                        ],
                      ),
                      Transform.rotate(
                        angle: 180 * 3.1415926535 / 180,
                        child: SizedBox(
                          height: MediaQuery.of(context).size.width * 0.9,
                          width: MediaQuery.of(context).size.width * 0.65,
                          child: CustomPaint(
                            painter: WaterTankerPainter(
                                percentage: _animation.value),
                            size: Size(MediaQuery.of(context).size.width,
                                MediaQuery.of(context).size.width * 0.3),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        '${(context.watch<PowerBloc>().state.power.water * 100).toInt()} %',
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
                          context
                              .read<PowerBloc>()
                              .add(const SetPumpEvent('1'));
                        },
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: const Color.fromRGBO(1, 127, 97, 1),
                          ),
                          child: Icon(
                            !context.watch<PowerBloc>().state.pump.pump1
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
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class WaterTankerPainter extends CustomPainter {
  final double percentage;
  final double borderRadius = 10.0;

  WaterTankerPainter({required this.percentage});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..shader = LinearGradient(
        colors: [Colors.blue.shade600, Colors.blue],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(
          Rect.fromPoints(const Offset(0, 0), Offset(size.width, size.height)))
      ..style = PaintingStyle.fill;

    Paint borderPaint = Paint()
      ..color = const Color.fromARGB(255, 240, 233, 233)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    double clipHeight = size.height * (percentage / 100);

    RRect filledRRect = RRect.fromRectAndRadius(
      Rect.fromPoints(const Offset(0, 0), Offset(size.width, clipHeight)),
      const Radius.circular(10),
    );
    canvas.drawRRect(filledRRect, paint);

    RRect borderRRect = RRect.fromRectAndRadius(
      Rect.fromPoints(const Offset(0, 0), Offset(size.width, size.height)),
      Radius.circular(borderRadius),
    );
    canvas.drawCircle(Offset(size.width / 2, clipHeight - 10), 5, paint);
    canvas.drawCircle(Offset(size.width / 3, clipHeight - 20), 4, paint);
    canvas.drawCircle(Offset(size.width * 2 / 3, clipHeight - 15), 6, paint);
    canvas.drawRRect(borderRRect, borderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
