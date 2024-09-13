import 'package:flutter/material.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset("assets/images/bg.png", width: double.infinity,
          height: double.infinity,
          fit: BoxFit.fill,),

        Scaffold(
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                SizedBox(height: 360,),
                Row(
                  children: [
                    SizedBox(width: 50,),
                    Text("Boxer", style: TextStyle(
                        fontSize: 45, fontWeight: FontWeight.bold),),

                  ],
                ),
                SizedBox(height: 20,),
                Text("About You",textAlign: TextAlign.start ,style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold,color: Colors.black),),
                Text("we want to know more about you, follow the next steps to complete the information"),
              ],
            ),
          ),

        ),

      ],
    );
  }
}
