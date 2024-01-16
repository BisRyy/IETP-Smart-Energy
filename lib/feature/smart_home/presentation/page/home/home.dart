import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_home/feature/smart_home/presentation/bloc/power/power_bloc.dart';
import 'package:smart_home/feature/smart_home/presentation/page/home/circular.dart';
import 'package:smart_home/feature/smart_home/presentation/page/home/electric.dart';
import 'package:smart_home/feature/smart_home/presentation/page/home/moisture.dart';
import 'package:smart_home/feature/smart_home/presentation/page/home/water.dart';
import 'package:smart_home/feature/smart_home/presentation/page/onboarding/bubble.dart';
import 'package:smart_home/feature/smart_home/presentation/page/onboarding/layout.dart';

import '../../bloc/user/user_bloc.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

Random random = Random();

class _HomeState extends State<Home> {
  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

  String getFullName() {
    final String firstName = context.read<UserBloc>().state.user!.firstName;
    final String lastName = context.read<UserBloc>().state.user!.lastName;
    return '${capitalize(firstName)} ${capitalize(lastName)}';
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ));
    myRecursiveFunction();
  }

  void myRecursiveFunction() {
    context.read<PowerBloc>().add(const GetPowerEvent());
    Future.delayed(const Duration(seconds: 2), myRecursiveFunction);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ));
    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        if (state.loginStatus == LoginStatus.success) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const OnboardingLayout()),
              (route) => false);
        }
      },
      child: Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.white, Color.fromRGBO(1, 127, 97, 0.1)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Stack(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Image.asset(
                  'assets/battery_bg.png',
                  fit: BoxFit.cover,
                ),
              ),
              const BubbleScreen(
                  color: Color.fromARGB(31, 78, 161, 110),
                  numberOfBubbles: 5,
                  maxBubbleSize: 90),
              SingleChildScrollView(
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Image(
                                image: AssetImage('assets/logo.png'),
                                width: 70,
                                height: 70,
                              ),
                              const SizedBox(width: 15),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Hey,',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white.withOpacity(0.7)),
                                  ),
                                  Text(
                                    getFullName(),
                                    style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w800,
                                        color: Colors.white.withOpacity(0.8)),
                                  )
                                ],
                              ),
                              const Spacer(),
                              GestureDetector(
                                onTap: () {
                                  context
                                      .read<UserBloc>()
                                      .add(const LogoutUserEvent());
                                },
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: const Color.fromRGBO(1, 127, 97, 1),
                                  ),
                                  child: const Icon(
                                    Icons.logout_outlined,
                                    size: 30,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Stack(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 30),
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.18,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: const Color.fromRGBO(1, 127, 97, 1),
                              ),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                width: MediaQuery.of(context).size.width * 0.5,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Welcome to',
                                      style: TextStyle(
                                        color: Colors.white.withOpacity(0.8),
                                        fontSize: 20,
                                        fontFamily: 'JosefinSans',
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    const Text(
                                      'Smart Home',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 32,
                                        fontFamily: 'JosefinSans',
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    Expanded(
                                      child: Text(
                                        'We are here to help you keep your environment clean.',
                                        softWrap: true,
                                        style: TextStyle(
                                          color: Colors.white.withOpacity(0.8),
                                          fontSize: 14,
                                          fontFamily: 'JosefinSans',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 15, right: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Image.asset(
                                    'assets/home_logo.png',
                                    width:
                                        MediaQuery.of(context).size.width * 0.2,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Progress',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: 'JosefinSans',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white.withOpacity(0.7)),
                              ),
                            ],
                          ),
                        ),
                        TripleCircularTimerWidget(
                          moistureProgress:
                              context.watch<PowerBloc>().state.power.moisture,
                          electricityProgress:
                              context.watch<PowerBloc>().state.power.power,
                          waterProgress:
                              context.watch<PowerBloc>().state.power.water,
                        ),
                        const SizedBox(height: 30),
                        CardPercentage(
                          type: 'electricity',
                          color: const Color.fromRGBO(1, 127, 97, 1),
                          icon: Icons.battery_1_bar,
                          text: 'Battery Power',
                          percent: context.watch<PowerBloc>().state.power.power,
                        ),
                        const SizedBox(height: 12),
                        CardPercentage(
                          type: 'moisture',
                          color: const Color.fromRGBO(47, 121, 129, 1),
                          icon: Icons.water,
                          text: 'Moisture',
                          percent:
                              context.watch<PowerBloc>().state.power.moisture,
                        ),
                        const SizedBox(height: 12),
                        CardPercentage(
                          type: 'water',
                          color: const Color.fromRGBO(97, 197, 212, 1),
                          icon: Icons.water_drop_outlined,
                          text: 'Water',
                          percent: context.watch<PowerBloc>().state.power.water,
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CardPercentage extends StatelessWidget {
  const CardPercentage(
      {super.key,
      required this.type,
      required this.color,
      required this.text,
      required this.icon,
      required this.percent});
  final Color color;
  final String text;
  final IconData icon;
  final double percent;
  final String type;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white.withOpacity(0.1),
      ),
      clipBehavior: Clip.hardEdge,
      child: ListTile(
        onTap: () {
          if (type == 'water') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const WaterDropWidget()),
            );
          } else if (type == 'moisture') {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const MoistureDropWidget()),
            );
          } else if (type == 'electricity') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Electric()),
            );
          }
        },
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: color,
          ),
          child: Icon(
            icon,
            size: 25,
            color: Colors.white,
          ),
        ),
        title: Text(
          text,
          style: TextStyle(
              fontSize: 16,
              fontFamily: 'JosefinSans',
              fontWeight: FontWeight.w500,
              color: Colors.white.withOpacity(0.7)),
        ),
        subtitle: Container(
          width: double.infinity,
          height: 10,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6), color: color),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width:
                    MediaQuery.of(context).size.width * 0.685 * (1 - percent),
                margin: const EdgeInsets.all(0.5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  color: const Color.fromARGB(255, 255, 255, 255),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
