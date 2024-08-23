import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vinny_ai_chat/view/auth_view/loginView.dart';

import '../../helper/transition.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupState();
}

class _SignupState extends State<SignupView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SvgPicture.asset(
            'assets/svg/plan_background.svg', // Path to your SVG file
            fit: BoxFit.cover,
          ),
          Column(
            children: [
              AppBar(
                centerTitle: true,
                title: Text(
                  "Create an account",
                  style: TextStyle(fontSize: 22, color: Colors.white),
                ),
                backgroundColor: Colors.transparent,
                // Make the AppBar transparent
                elevation: 0,
                iconTheme: IconThemeData(
                  color: Colors.white, // Set the color of the back button
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 25, left: 25),
                    child: Form(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Email",
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                        TextFormField(
                          style: TextStyle(color: Colors.white),
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 10.0,
                              horizontal: 10,
                            ),
                            hintText: 'Enter your email address',
                            hintStyle: TextStyle(
                                color: Colors.white.withOpacity(0.5),
                                fontSize: 12),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            // focusedBorder: UnderlineInputBorder(
                            //   borderSide: BorderSide(color: Colors.white),
                            // ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Username",
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                        TextFormField(
                          style: TextStyle(color: Colors.white),
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 10.0,
                              horizontal: 10,
                            ),
                            hintText: 'Enter your username',
                            hintStyle: TextStyle(
                                color: Colors.white.withOpacity(0.5),
                                fontSize: 12),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            // focusedBorder: UnderlineInputBorder(
                            //   borderSide: BorderSide(color: Colors.white),
                            // ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Password",
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                        TextFormField(
                          style: TextStyle(color: Colors.white),
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 10.0,
                              horizontal: 10,
                            ),
                            hintText: 'Enter your password',
                            hintStyle: TextStyle(
                                color: Colors.white.withOpacity(0.5),
                                fontSize: 12),
                            suffixIcon: Icon(
                              Icons.visibility_off,
                              color: Colors.white,
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            // focusedBorder: UnderlineInputBorder(
                            //   borderSide: BorderSide(color: Colors.white),
                            // ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Confirm Password",
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                        TextFormField(
                          style: TextStyle(color: Colors.white),
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 10.0,
                              horizontal: 10,
                            ),
                            hintText: 'Confirm your password',
                            hintStyle: TextStyle(
                                color: Colors.white.withOpacity(0.5),
                                fontSize: 12),
                            suffixIcon:
                                Icon(Icons.visibility_off, color: Colors.white),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            // focusedBorder: UnderlineInputBorder(
                            //   borderSide: BorderSide(color: Colors.white),
                            // ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: () => Navigator.push(
                            context,
                            FadePageRouteBuilder(
                              widget: LoginView(),
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
                                "Register",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14),
                                textAlign: TextAlign.center,
                              )),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        RichText(
                          text: TextSpan(
                            style: TextStyle(fontSize: 11, color: Colors.white),
                            children: [
                              TextSpan(
                                  text: "By continuing, you agree to our "),
                              TextSpan(
                                text: "Terms of Service",
                                style: TextStyle(color: Color(0xFF03BCBF)),
                              ),
                              TextSpan(text: " and "),
                              TextSpan(
                                text: "Privacy Policy.",
                                style: TextStyle(color: Color(0xFF03BCBF)),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Container(
                              height: 1,
                              // Adjust the height of the line as needed
                              width: MediaQuery.of(context).size.width * 0.25,
                              // Adjust the width of the line as needed
                              color: Colors.white, // Color of the line
                            ),
                            SizedBox(width: 10),
                            // Space between the line and the text
                            Text(
                              "or continue with",
                              style:
                                  TextStyle(fontSize: 14, color: Colors.white),
                            ),
                            SizedBox(width: 10),
                            // Space between the text and the new line
                            Container(
                              height: 1,
                              // Adjust the height of the line as needed
                              width: MediaQuery.of(context).size.width * 0.25,
                              // Adjust the width of the line as needed
                              color: Colors.white, // Color of the line
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset("assets/svg/google svg.svg"),
                            SizedBox(
                              width: 10,
                            ),
                            SvgPicture.asset(
                              "assets/svg/apple svg.svg",
                              height: 36,
                              width: 36,
                            ),
                          ],
                        ),
                      ],
                    )),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
