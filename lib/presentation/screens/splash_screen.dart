import 'dart:async';
import 'package:boxer/presentation/screens/landing_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  AnimationController? animationController;
  Animation<double>? animation;

  @override
  void initState() {
    super.initState();

    // Set up the animation controller and animation
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900), // Change to milliseconds
    );

    animation = Tween<double>(
      begin: 0.2,
      end: 1.0,
    ).animate(animationController!)
      ..addListener(() {
        setState(() {});
      });

    animationController?.repeat(reverse: true);

    // Timer to navigate to the next screen after 5 seconds
    Timer(const Duration(seconds: 10), goToNext);
  }

  void goToNext() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LandingScreen()),
    );
  }

  @override
  void dispose() {
    // Dispose of the animation controller when the screen is disposed
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: FadeTransition(
        opacity: animation!,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo and App name
              Image.asset("assets/images/logo.png", height: size.height * 0.6),
              const Text(
                "Boxer",
                style: TextStyle(fontSize: 80, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 40),

              // Loading Indicator
              Column(
                children: const [
                  CircularProgressIndicator(
                    color: Colors.green,
                    backgroundColor: Colors.transparent,
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Loading...",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 19,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
