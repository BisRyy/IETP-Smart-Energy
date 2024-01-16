import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_home/feature/smart_home/presentation/bloc/power/power_bloc.dart';
import 'package:smart_home/feature/smart_home/presentation/bloc/user/user_bloc.dart';
import 'package:smart_home/feature/smart_home/presentation/page/onboarding/layout.dart';
import 'package:smart_home/injection_container.dart';

import 'injection_container.dart' as di;
import 'simple_bloc_observer.dart';

void main() async {
  Bloc.observer = const SimpleBlocObserver();

  WidgetsFlutterBinding.ensureInitialized();

  await di.init();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<UserBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<PowerBloc>(),
        ),
      ],
      child: const MaterialApp(
        home: OnboardingLayout(),
        debugShowCheckedModeBanner: false,
      ),
    ),
  );
}
