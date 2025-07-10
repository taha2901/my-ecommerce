import 'dart:async';
import 'package:ecommerce_app/features/address/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../routings/routers.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacementNamed(Routers.loginRoute);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: AppColors.primary,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // إضافة أيقونة أو لوجو مع تأثير انيميشن
            Icon(
              Icons.shopping_bag,
              size: 100,
              color: Colors.white,
            ).animate().fadeIn(duration: 1.seconds).scale(begin: Offset(0.5, 0.5), duration: 1.seconds),

            const SizedBox(height: 20), // مسافة بين الأيقونة والنص

            // نص "My Shop" مع تأثيرات حركة
            Text(
              'My Shop',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ).animate().fadeIn(duration: 1.seconds).moveY(begin: -20, end: 0, duration: 1.seconds),

            const SizedBox(height: 10),

            // إضافة نص فرعي "Best Shopping Experience"
            Text(
              'Best Shopping Experience',
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 16,
              ),
            ).animate().fadeIn(duration: 1.seconds).moveY(begin: 10, end: 0, duration: 1.seconds),
          ],
        ),
      ),
    );
  }
}
