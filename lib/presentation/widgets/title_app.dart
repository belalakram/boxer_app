import 'package:flutter/material.dart';

class TitleApp extends StatelessWidget {
  const TitleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
        SizedBox(
          width: 30,
        ),
        Text(
          "Boxer",
          style:
          TextStyle(fontSize: 45, fontWeight: FontWeight.bold),
        ),
      ],
    );

  }
}
