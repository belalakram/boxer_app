import 'package:boxer/core/my_scaffold.dart';
import 'package:boxer/presentation/screens/beginner_screen.dart';
import 'package:boxer/presentation/widgets/title_app.dart';
import 'package:flutter/material.dart';

import '../widgets/landing_item.dart';
import 'inactive_screen.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            const TitleApp(),
            const SizedBox(height: 300),
            const Text(
              "About you",
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const Text(
              "We want to know more about you. Follow the next steps to complete the information.",
            ),
            const SizedBox(height: 5),
            Container(
              height: 170,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  LandingItem(
                    onPress: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const BeginnerScreen(),
                      ),
                    ),
                    title: "I am\nBeginner",
                    subtitle: "I have never trained",
                  ),
                  LandingItem(
                    onPress: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const InactiveScreen(),
                      ),
                    ),
                    title: "I am\nInactive",
                    subtitle: "I have been inactive",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
