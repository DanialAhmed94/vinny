import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vinny_ai_chat/view/welcome/premimumView.dart';

import '../../helper/transition.dart';

class Getstartedview extends StatelessWidget {
  const Getstartedview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SvgPicture.asset("assets/svg/Get Started.svg",fit: BoxFit.cover,),
          Positioned(
            right: 20,
            bottom:60,child: GestureDetector(
            onTap: ()=>Navigator.push(
              context,
              FadePageRouteBuilder(
                widget:Premimumview(),
              ),
            ),
            child: Center(
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(color: Color(0xFFFFFFFF),
                    borderRadius: BorderRadius.circular(20)),
                child: Center(child: Text("Get Started",style: TextStyle(color: Colors.black,fontSize: 14), textAlign: TextAlign.center,)),
              ),
            ),
          ),)
        ],
      ),
    );
  }
}
