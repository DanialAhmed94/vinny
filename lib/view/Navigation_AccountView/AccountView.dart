import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants/AppConstants.dart';

class Accountview extends StatelessWidget {
  const Accountview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text(
            "Profile",
            style: TextStyle(
              color: AppConstants.fontColor,
              fontSize: 20,
              fontFamily: "InterBold",
            ),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.only(left: 16, right: 16),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.15,
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                      color: Color(0xFF10B3C2),
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    child: Row(
                      children: [
                        ClipOval(
                          child: Image.asset(
                            AppConstants.profileAvatar,
                          ),
                        ),
                        SizedBox(width: 8,),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            Text(
                              "James Morgan",
                              style: TextStyle(
                                  fontSize: 13,
                                  fontFamily: "JostMedium",
                                  color: AppConstants.fontColor),
                            ),

                            Text(
                              "james@gmail.com",
                              style: TextStyle(
                                  fontSize: 13,
                                  fontFamily: "JostMedium",
                                  color: AppConstants.fontColor),
                            )
                          ],
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: Icon(Icons.edit,color: Colors.white,),
                        ),

                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.only(left: 16, right: 16),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.width * 0.99,
                  decoration: BoxDecoration(
                      color: Color(0xFF05174C),
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 8,
                      ),
                      SvgPicture.asset(AppConstants.shareIcon),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Share with friends",
                        style: TextStyle(
                            color: AppConstants.fontColor,
                            fontFamily: "JostMedium",
                            fontSize: 18),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.only(left: 16, right: 16),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.width * 0.99,
                  decoration: BoxDecoration(
                      color: Color(0xFF05174C),
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 8,
                      ),
                      SvgPicture.asset(AppConstants.rateAppIcon),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Rate App",
                        style: TextStyle(
                            color: AppConstants.fontColor,
                            fontFamily: "JostMedium",
                            fontSize: 18),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.only(left: 16, right: 16),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.width * 0.99,
                  decoration: BoxDecoration(
                      color: Color(0xFF05174C),
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 8,
                      ),
                      SvgPicture.asset(AppConstants.feedbackIcon),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Feedback",
                        style: TextStyle(
                            color: AppConstants.fontColor,
                            fontFamily: "JostMedium",
                            fontSize: 18),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.only(left: 16, right: 16),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.width * 0.99,
                  decoration: BoxDecoration(
                      color: Color(0xFF05174C),
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 8,
                      ),
                      SvgPicture.asset(AppConstants.privacyIcon),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Privacy Policy",
                        style: TextStyle(
                            color: AppConstants.fontColor,
                            fontFamily: "JostMedium",
                            fontSize: 18),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16),
                child: SvgPicture.asset(AppConstants.premiumLabel),
              )
            ],
          ),
        ));
  }
}
