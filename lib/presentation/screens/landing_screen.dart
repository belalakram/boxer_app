import 'package:boxer/core/my_scaffold.dart';
import 'package:boxer/presentation/screens/beginner_screen.dart';
import 'package:boxer/presentation/widgets/title_app.dart';
import 'package:flutter/material.dart';

import '../widgets/landing_item.dart';

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
            SizedBox(
              height: 40,
            ),
            TitleApp(),
            SizedBox(
              height: 300,
            ),
            Text(
              "About you",
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            Text(
                "we want to know more about you, follow the next steps to complete the information"),
            SizedBox(
              height: 5,
            ),
            Container(
              height: 170,
              child: Expanded(
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    LandingItem(
                      onPress: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context)=>  BeginnerScreen()
                          ),),
                      title: "I am\nBeginner",
                      subtitle: "I have never trained",
                    ),
                    LandingItem(
                      title: "I am\ninactive",
                      subtitle: "I have never trained",
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
