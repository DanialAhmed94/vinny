import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vinny_ai_chat/view/HomeView/homeView.dart';

import '../../helper/transition.dart';

class Premimumview extends StatelessWidget {
  const Premimumview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SvgPicture.asset(
            "assets/svg/Get Premium.svg",
            fit: BoxFit.cover,
          ),
          Positioned(
              right: 20,
              left: 20,
              //  bottom: 50,
              bottom: MediaQuery.of(context).size.height * 0.08,
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 80,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            10.0), // Set circular border radius
                      ),
                      color: Color(0xFF092765).withOpacity(0.6),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 15, right: 8, top: 8, bottom: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Annual",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                Spacer(),
                                Container(
                                  height: 30,
                                  width: 130,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.greenAccent),
                                  child: Center(
                                      child: Text(
                                    "Best Value Offer",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: Colors.white),
                                  )),
                                )
                              ],
                            ),
                            Text(
                              "\$999/year",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 80,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            10.0), // Set circular border radius
                      ),
                      color: Colors.white.withOpacity(0.6),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 15, right: 8, top: 8, bottom: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Monthly",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                Spacer(),
                                Container(
                                  height: 30,
                                  width: 130,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.greenAccent),
                                  child: Center(
                                      child: Text(
                                    "Best Value Offer",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: Colors.white),
                                  )),
                                )
                              ],
                            ),
                            Text(
                              "\$999/year",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: ()=>Navigator.push(
                      context,
                      FadePageRouteBuilder(
                        widget: HomeView(),
                      ),
                    ),
                    child: Center(
                      child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width * 0.9,
                        decoration: BoxDecoration(
                            color: Color(0xFF03BCBF),
                            borderRadius: BorderRadius.circular(20)),
                        child: Center(
                            child: Text(
                          "Start 7 days free trial",
                          style: TextStyle(color: Colors.white, fontSize: 14),
                          textAlign: TextAlign.center,
                        )),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Enjoy a risk-free 7-day trial. No commitment required; cancel anytime",
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  )
                ],
              ))
        ],
      ),
    );
  }
}
