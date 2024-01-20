import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../home/home_screen.dart';

class SplashScreen extends StatefulWidget {
  static const name = 'splash_screen';
  static const path = '/';

  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 1), () {
      context.pushReplacementNamed(HomeScreen.name);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Splash Screen',
        ),
      ),
    );
  }
}
