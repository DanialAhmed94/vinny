import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vinny_ai_chat/home.dart';
import 'package:lottie/lottie.dart';

import 'helper/transition.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(vsync: this);
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // Navigator.of(context).pushReplacement(
        //   MaterialPageRoute(builder: (context) => HomeScreen()),
        // );
        Navigator.pushReplacement(
          context,
          FadePageRouteBuilder(
            widget: HomeScreen(),
          ),
        );

      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Lottie.asset(
          'assets/loti/splash.json', // Path to your Lottie animation
          controller: _controller,
          onLoaded: (composition) {
            _controller
              ..duration = composition.duration
              ..forward();
          },
          fit: BoxFit.cover, // Ensure it covers the entire screen
        ),
      ),
    );
  }
}

