import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vinny_ai_chat/helper/transition.dart';
import 'package:vinny_ai_chat/view/auth_view/loginView.dart';
import 'package:share_plus/share_plus.dart';
import '../../Providers/likeDislikeProvider.dart';
import '../../apis/logout.dart';
import '../../constants/AppConstants.dart';
import '../welcome/premimumView.dart';

class Accountview extends StatefulWidget {
  const Accountview({super.key});

  @override
  State<Accountview> createState() => _AccountviewState();
}

class _AccountviewState extends State<Accountview> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  String? userName;
  String? userEmail;
  bool _isLoading = false; // To manage loading state

  Future<void> _handleLogout() async {
    setState(() {
      _isLoading = true; // Show loading indicator if needed
    });

    try {
      final prefs = await SharedPreferences.getInstance();
      String? authProvider = prefs.getString('authProvider');

      if (authProvider == "google") {
        // Step 1: Call your logout API first
        final result = await logoutUser(); // Implement this function
        if (result['success']) {
          Provider.of<LikeDislikeProvider>(context, listen: false)
              .clearLikedBots();

          // Step 2: Only sign out and disconnect from Google if logout API succeeds
          await _auth.signOut();
          await _googleSignIn.disconnect();

          // Update login status in preferences
          await prefs.setBool("isLogedin", false);

          // Navigate to login screen
          Navigator.pushAndRemoveUntil(
            context,
            FadePageRouteBuilder(widget: LoginView()),
            (Route<dynamic> route) => false,
          );
        } else {
          // Handle error message if logout API fails
          _showPlatformSpecificAlert(
            context,
            title: 'Logout Failed',
            message: result['message'],
          );
        }
      }

      // Step 3: Call your logout API to clear the bearer token
      final result = await logoutUser(); // Implement this function

      if (result['success']) {
        Provider.of<LikeDislikeProvider>(context, listen: false)
            .clearLikedBots();

        Navigator.pushAndRemoveUntil(
          context,
          FadePageRouteBuilder(widget: LoginView()),
          (Route<dynamic> route) => false,
        );
      } else {
        // Handle error message
        _showPlatformSpecificAlert(
          context,
          title: 'Logout Failed',
          message: result['message'],
        );
      }
    } catch (e) {
      print("Logout error: $e");
      // Handle errors
      _showPlatformSpecificAlert(
        context,
        title: 'Error',
        message: 'Error during logout. Please try again.',
      );
    } finally {
      setState(() {
        _isLoading = false; // Hide loading indicator
      });
    }
  }

  Future<void> userInfo() async {
    final prefs = await SharedPreferences.getInstance();
    userName = await prefs.getString("userName");
    userEmail = await prefs.getString("userEmail");
  }

  void shareApp(BuildContext context) async {
    final url =
        "https://semicolonstech.com/"; // Replace with your app's link

    final result = await Share.share("Check out this amazing app: Vinny  Ai chat bot. $url");

    if (result.status == ShareResultStatus.success) {
      _showShareResultMessage(context, 'Thank you for sharing the app!');
    } else if (result.status == ShareResultStatus.dismissed) {
      _showShareResultMessage(context, 'Share canceled');
    }
  }

  void _showShareResultMessage(BuildContext context, String message) {
    if (Platform.isIOS) {
      showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          content: Text(message),
          actions: [
            CupertinoDialogAction(
              child: Text('OK'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
  Future<void> sendFeedbackEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'feedback@test.com', // Replace with your feedback email
      queryParameters: {
        'subject': 'Feedback',
      },
    );

    try {
      await launchUrl(emailUri, mode: LaunchMode.externalApplication);
    } catch (e) {
      print('Could not launch email client: $e');
    }
  }
  Future<void> openPrivacyPolicy(BuildContext context) async {
    final Uri url = Uri.parse("https://semicolonstech.com/privacy-policy/"); // Replace with your actual Privacy Policy URL

    try {
      if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
        throw 'Could not launch $url';
      }
    } catch (e) {
      _showError(context, 'Could not open Privacy Policy: $e');
    }
  }

  void _showError(BuildContext context, String message) {
    if (Platform.isIOS) {
      showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          content: Text(message),
          actions: [
            CupertinoDialogAction(
              child: Text('OK'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userInfo();
  }

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
                        SizedBox(
                          width: 8,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "${userName}",
                              style: TextStyle(
                                  fontSize: 13,
                                  fontFamily: "JostMedium",
                                  color: AppConstants.fontColor),
                            ),
                            Text(
                              "${userEmail}",
                              style: TextStyle(
                                  fontSize: 13,
                                  fontFamily: "JostMedium",
                                  color: AppConstants.fontColor),
                            )
                          ],
                        ),
                        Spacer(),
                        // Padding(
                        //   padding: const EdgeInsets.only(right: 8),
                        //   child: Icon(Icons.edit,color: Colors.white,),
                        // ),
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
                child: GestureDetector(
                  onTap: () => shareApp(context),
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
                            fontSize: 18,
                          ),
                        )
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
                child: GestureDetector(
                  onTap: sendFeedbackEmail,

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
                            fontSize: 18,
                          ),
                        )

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
                child: GestureDetector(
                  onTap: (){
                    openPrivacyPolicy(context);
                  },
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
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.only(left: 16, right: 16),
                child: GestureDetector(
                  onTap: _handleLogout,
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
                        SvgPicture.asset(
                          AppConstants.logoutIcon,
                          height: 40,
                          width: 40,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Logout",
                          style: TextStyle(
                            color: AppConstants.fontColor,
                            fontFamily: "JostMedium",
                            fontSize: 18,
                          ),
                        ),
                        if (_isLoading)
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.push(
                    context, FadePageRouteBuilder(widget: PremimumView())),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: SvgPicture.asset(AppConstants.premiumLabel),
                ),
              )
            ],
          ),
        ));
  }

  // Helper method to show platform-specific alerts
  void _showPlatformSpecificAlert(BuildContext context,
      {required String title, required String message}) {
    if (Platform.isIOS) {
      // For iOS, show a CupertinoAlertDialog
      showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            CupertinoDialogAction(
              child: Text('OK'),
              onPressed: () => Navigator.of(context).pop(),
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
  }
}
