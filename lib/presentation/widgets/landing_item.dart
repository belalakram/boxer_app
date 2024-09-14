import 'package:flutter/material.dart';

class LandingItem extends StatelessWidget {
  const LandingItem(
      {super.key, required this.title, required this.subtitle, this.onPress});

  final String title;
  final String subtitle;
  final VoidCallback? onPress;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        height: 20,
        width: 160,
        decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(15)),
        margin: EdgeInsets.all(10),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                    color: Colors.brown,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                subtitle,
                style: TextStyle(color: Colors.white, fontSize: 14),
              )
            ],
          ),
        ),
      ),
    );
  }
}
