import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vinny_ai_chat/home.dart';
import 'package:vinny_ai_chat/view/HomeView/homeView.dart';
import 'package:lottie/lottie.dart';
import 'helper/transition.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  Future<void> whereToGo() async {
    print("whereToGo method called");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isLogedin = prefs.getBool('isLogedin') ?? false;

    if (isLogedin) {
      Navigator.pushAndRemoveUntil(
        context,
        FadePageRouteBuilder(
          widget: HomeView(),
        ),
            (Route<dynamic> route) => false,
      );
    } else {
      Navigator.pushAndRemoveUntil(
        context,
        FadePageRouteBuilder(
          widget: HomeScreen(),
        ),
            (Route<dynamic> route) => false,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    _controller.addStatusListener((status) {
      print("Animation Status: $status");
      if (status == AnimationStatus.completed) {
        whereToGo();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Lottie.asset(
          'assets/loti/splash.json',
          controller: _controller,
          onLoaded: (composition) {
            _controller
              ..duration = composition.duration
              ..forward();
          },
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
