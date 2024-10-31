import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';



class Upgradeview  extends StatelessWidget {
  const Upgradeview ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            "assets/images/getPremiumBg.png",
            fit: BoxFit.cover,
          ),
          Positioned(

              left: 8,
              //  bottom: 50,
              bottom: MediaQuery
                  .of(context)
                  .size
                  .height * 0.08,
              child: Column(
                children: [
                  Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * 0.9,
                    height: 80,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            10.0), // Set circular border radius
                      ),
                      color: const Color(0xFF092765).withOpacity(0.6),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 15, right: 8, top: 8, bottom: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Text(
                                  "Annual",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                const Spacer(),
                                Container(
                                  height: 30,
                                  width: 130,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.greenAccent),
                                  child: const Center(
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
                            const Text(
                              "\$0/year",
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
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * 0.9,
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
                                const Text(
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
                              "\$0/year",
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
                    onTap: () {
                      final message = "This feature is currently in development.";

                      if (Platform.isIOS) {
                        // For iOS, show a CupertinoAlertDialog
                        showCupertinoDialog(
                          context: context,
                          builder: (context) =>
                              CupertinoAlertDialog(
                                content: Text(message),
                                actions: [
                                  CupertinoDialogAction(
                                    child: Text('OK'),
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                  ),
                                ],
                              ),
                        );
                      } else {
                        // For Android and other platforms, show a SnackBar
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(message),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    },
                    child: Center(
                      child: Container(
                        height: 50,
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * 0.88,
                        decoration: BoxDecoration(
                            color: const Color(0xFF03BCBF),
                            borderRadius: BorderRadius.circular(20)),
                        child: Center(
                            child: Text(
                              "Upgrade your Plan",
                              style: TextStyle(color: Colors.white,
                                  fontSize: 14),
                              textAlign: TextAlign.center,
                            )),
                      ),
                    ),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
