import 'package:flutter/material.dart';
import 'package:radio_javan/ui/screens/dashboard_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3)).then((value) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (_) => DashboardScreen(),
          ),
          (route) => false);
    });

    return Scaffold();
  }
}
