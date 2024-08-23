import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../helper/transition.dart';
import 'getStartedView.dart';

class Welcomeview extends StatelessWidget {
  const Welcomeview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SvgPicture.asset(
            'assets/svg/welcome.svg', // Path to your SVG file
            fit: BoxFit.cover,
          ),
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.only(left: 20,right: 20),
              child: FractionallySizedBox(
                heightFactor: 0.45,
                child: Container(
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Welcome to Our AI Chatbot Therapy App',
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        'This app provides simulated conversations for mental health support. By using this app, you acknowledge that the advice provided by the chatbot is based on algorithms and should not replace professional healthcare advice.',
                        style: TextStyle(fontSize: 16.0,color: Colors.white,),
                      ),


                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 20,
            bottom: 100,
          child:  GestureDetector(
            onTap: ()=>Navigator.push(
              context,
              FadePageRouteBuilder(
                widget: Getstartedview(),
              ),
            ),
            child: Center(
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(color: Color(0xFF03BCBF),
                    borderRadius: BorderRadius.circular(20)),
                child: Center(child: Text("Accept",style: TextStyle(color: Colors.white,fontSize: 14), textAlign: TextAlign.center,)),
              ),
            ),
          ),),
        ],
      ),
    );
  }
}
