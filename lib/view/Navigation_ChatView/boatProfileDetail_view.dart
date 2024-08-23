import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vinny_ai_chat/constants/AppConstants.dart';

class BoatprofiledetailView extends StatelessWidget {
  const BoatprofiledetailView({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Profile",
          style: TextStyle(
            color: AppConstants.fontColor,
            fontSize: 20,
            fontFamily: "InterBold",
          ),
        ),
        backgroundColor: Color(0xFF06B8BE),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        // actions: [
        //   IconButton(
        //     onPressed: () {
        //       // Add functionality for settings button here
        //     },
        //     icon: Icon(
        //       Icons.settings,
        //       color: Colors.white,
        //     ),
        //   )
        // ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            //      mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 30,
              ),
              Container(
                width: 100, // Increased to accommodate space for borders
                height: 100, // Increased to accommodate space for borders
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFFA647FE),
                      Color(0xFFA04CFC),
                      Color(0xFF905AF8),
                      Color(0xFF7571F0),
                      Color(0xFF5191E5),
                      Color(0xFF29B4D9),
                    ],
                    stops: [
                      0.0,
                      0.15,
                      0.34,
                      0.56,
                      0.79,
                      1.0,
                    ],
                  ),
                  border: Border.all(
                    // Transparent to maintain gradient effect
                    width: 1.0,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  // Adjust padding as needed
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFFA647FE),
                          Color(0xFFA04CFC),
                          Color(0xFF905AF8),
                          Color(0xFF7571F0),
                          Color(0xFF5191E5),
                          Color(0xFF29B4D9),
                        ],
                        stops: [
                          0.0,
                          0.15,
                          0.34,
                          0.56,
                          0.79,
                          1.0,
                        ],
                      ),
                      border: Border.all(
                        width: 3.0,
                      ),
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        AppConstants.profileAvatar,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              Text(
                "Jane Smith - Depression",
                style: TextStyle(
                    fontFamily: "InterSemiBold",
                    fontSize: 17,
                    color: AppConstants.fontColor),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.1,
                  ),
                  SvgPicture.asset(
                    AppConstants.likeIcon,
                    height: 20,
                    width: 20,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "70K",
                    style:
                        TextStyle(color: AppConstants.fontColor, fontSize: 11),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.1,
                  ),
                  SvgPicture.asset(
                    AppConstants.dislikeIcon,
                    height: 20,
                    width: 20,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    "70K",
                    style:
                        TextStyle(color: AppConstants.fontColor, fontSize: 11),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.1,
                  ),
                  SvgPicture.asset(
                    AppConstants.mentalHealthIcon,
                    height: 20,
                    width: 20,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    "Menatal Health",
                    style: TextStyle(
                        fontSize: 12,
                        fontFamily: "InterRegular",
                        color: AppConstants.fontColor),
                  )
                ],
              ),
              DetailWidget(),
              ButtonSelection(),
            ],
          ),
        ),
      ),
    );
  }
}

class DetailWidget extends StatelessWidget {
  const DetailWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.65,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xFFE2E2E2).withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Disorder:",
                style: TextStyle(
                  color: AppConstants.shadedfontColor,
                  fontFamily: 'InterMedium',
                  fontSize: 14,
                ),
              ),
              Text(
                "Major Depressive Disorder",
                style: TextStyle(
                  color: AppConstants.fontColor,
                  fontFamily: 'InterRegular',
                  fontSize: 14,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Background:",
                style: TextStyle(
                  color: AppConstants.shadedfontColor,
                  fontFamily: 'InterMedium',
                  fontSize: 14,
                ),
              ),
              Text(
                "25-year-old graduate student facing academic pressure",
                maxLines: 2,
                style: TextStyle(
                  overflow: TextOverflow.ellipsis,
                  color: AppConstants.fontColor,
                  fontFamily: 'InterRegular',
                  fontSize: 14,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Therapy Type:",
                style: TextStyle(
                  color: AppConstants.shadedfontColor,
                  fontFamily: 'InterMedium',
                  fontSize: 14,
                ),
              ),
              Text(
                " Individual",
                maxLines: 1,
                style: TextStyle(
                  overflow: TextOverflow.ellipsis,
                  color: AppConstants.fontColor,
                  fontFamily: 'InterRegular',
                  fontSize: 14,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Key Symptoms:",
                style: TextStyle(
                  color: AppConstants.shadedfontColor,
                  fontFamily: 'InterMedium',
                  fontSize: 14,
                ),
              ),
              Text(
                "Persistent sadness, lack of energy, loss of interest in activities",
                maxLines: 2,
                style: TextStyle(
                  overflow: TextOverflow.ellipsis,
                  color: AppConstants.fontColor,
                  fontFamily: 'InterRegular',
                  fontSize: 14,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Interaction Mode:",
                style: TextStyle(
                  color: AppConstants.shadedfontColor,
                  fontFamily: 'InterMedium',
                  fontSize: 14,
                ),
              ),
              Text(
                "Text/Voice",
                maxLines: 1,
                style: TextStyle(
                  overflow: TextOverflow.ellipsis,
                  color: AppConstants.fontColor,
                  fontFamily: 'InterRegular',
                  fontSize: 14,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Experience Level:",
                style: TextStyle(
                  color: AppConstants.shadedfontColor,
                  fontFamily: 'InterMedium',
                  fontSize: 14,
                ),
              ),
              Text(
                "Beginner",
                maxLines: 1,
                style: TextStyle(
                  overflow: TextOverflow.ellipsis,
                  color: AppConstants.fontColor,
                  fontFamily: 'InterRegular',
                  fontSize: 14,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Sample Dialogue:",
                style: TextStyle(
                  color: AppConstants.shadedfontColor,
                  fontFamily: 'InterMedium',
                  fontSize: 14,
                ),
              ),
              Text(
                "I just don't find joy in anything anymore, and I can't get out of bed most days.",
                maxLines: 2,
                style: TextStyle(
                  overflow: TextOverflow.ellipsis,
                  color: AppConstants.fontColor,
                  fontFamily: 'InterRegular',
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class ButtonSelection extends StatefulWidget {
  const ButtonSelection({super.key});

  @override
  State<ButtonSelection> createState() => _ButtonSelectionState();
}

class _ButtonSelectionState extends State<ButtonSelection> {
  Widget _displayWidget = Container(height: 0, width: 0,);
  String _activeButton = '';

  void showBoatOptions() {
    setState(() {
      _activeButton = 'BoatOptions';
      _displayWidget = BoatOptions();
    });
  }

  void showSimilarBoats() {
    setState(() {
      _activeButton = 'SimilarBoats';
      _displayWidget = SimilarBoats();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: showBoatOptions,
              child: Container(
                height: 50,
                width: 100,
                decoration: BoxDecoration(
                  color: _activeButton == 'BoatOptions' ? Colors.blueAccent : Colors.white.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  "Boat Options",
                  style: TextStyle(color: AppConstants.fontColor, fontWeight: FontWeight.bold),
                ),
                alignment: Alignment.center,
              ),
            ),
            GestureDetector(
              onTap: showSimilarBoats,
              child: Container(
                height: 50,
                width: 100,
                decoration: BoxDecoration(
                  color: _activeButton == 'SimilarBoats' ? Colors.blueAccent : Colors.white.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  "Similar Boats",
                  style: TextStyle(color: AppConstants.fontColor, fontWeight: FontWeight.bold),
                ),
                alignment: Alignment.center,
              ),
            ),
          ],
        ),
        SizedBox(height: 10,),
        _displayWidget,
      ],
    );
  }
}

class BoatOptions extends StatelessWidget {
  const BoatOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 16),
      child: Column(
        children: [
          Row(
            children: [
              SvgPicture.asset(AppConstants.shareBoatIcon),
              SizedBox(
                width: 10,
              ),
              Text(
                "Share Boat",
                style: TextStyle(color: AppConstants.fontColor),
              )
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            children: [
              SvgPicture.asset(AppConstants.duplicateBoatIcon),
              SizedBox(
                width: 10,
              ),
              Text(
                "Duplicate Boat",
                style: TextStyle(color: AppConstants.fontColor),
              )
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            children: [
              SvgPicture.asset(AppConstants.clearTextIcon),
              SizedBox(
                width: 12,
              ),
              Text(
                "Clear Text",
                style: TextStyle(color: AppConstants.fontColor),
              )
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            children: [
              SvgPicture.asset(AppConstants.reportBoatIcon),
              SizedBox(
                width: 10,
              ),
              Text(
                "Report Boat",
                style: TextStyle(color: AppConstants.fontColor),
              )
            ],
          ),
          SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}

class SimilarBoats extends StatelessWidget {
  const SimilarBoats({super.key});

  @override
  Widget build(BuildContext context) {
    // Placeholder widget for Similar Boats
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 16),
      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.directions_boat, color: AppConstants.fontColor),
              SizedBox(
                width: 10,
              ),
              Text(
                "Similar Boat 1",
                style: TextStyle(color: AppConstants.fontColor),
              )
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            children: [
              Icon(Icons.directions_boat, color: AppConstants.fontColor),
              SizedBox(
                width: 10,
              ),
              Text(
                "Similar Boat 2",
                style: TextStyle(color: AppConstants.fontColor),
              )
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            children: [
              Icon(Icons.directions_boat, color: AppConstants.fontColor),
              SizedBox(
                width: 10,
              ),
              Text(
                "Similar Boat 3",
                style: TextStyle(color: AppConstants.fontColor),
              )
            ],
          ),
          SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}