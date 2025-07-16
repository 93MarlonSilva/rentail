import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentail/injection_container.dart';
import 'package:rentail/presentation/bloc/car_bloc.dart';
import 'package:rentail/presentation/bloc/car_event.dart';
import 'package:rentail/presentation/pages/car_list_screen.dart';
import 'package:rentail/presentation/pages/onboarding_page.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  initInjection();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<CarBloc>()..add(LoadCars()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Rentail Cars',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.black54),
          useMaterial3: true,
        ),
        home: const OnboardingPage(),
        routes: {
          '/onboarding': (context) => const OnboardingPage(),
          '/listcard': (context) => CarListScreen(),
        },

      ),
    );
  }
}