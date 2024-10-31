import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart'; // For CupertinoAlertDialog
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vinny_ai_chat/apis/login_api.dart'; // Import your login API
import 'package:vinny_ai_chat/view/welcome/welcomeView.dart';

import '../../apis/loginWithGoogle.dart';
import '../../helper/transition.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool isChecked = false;

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  bool _isLoading = false;
  bool _isGoogleLoading = false; // New variable for Google loading
  bool _obscurePassword = true; // Password visibility toggle
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<void> _handleGoogleSignIn(BuildContext context) async {
    setState(() {
      _isGoogleLoading = true; // Show loading indicator on Google icon
    });

    try {
      print('user is empty.........***********');

      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        setState(() {
          _isGoogleLoading = false;
        });
        return;
      } // Sign in aborted

      final GoogleSignInAuthentication googleAuth =
      await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
      await _auth.signInWithCredential(credential);
      final User? user = userCredential.user;

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('userName', "${user!.displayName}");
      await prefs.setString('userEmail', "${user!.email}");



      if (user != null) {
        // Send user information to signup API
        final result = await loginWithGoogle(
          email: user.email!,
          username: user.displayName ?? user.email!.split('@')[0],
          auth_provider: "google",
          google_id: user.uid,
        );
        setState(() {
          _isGoogleLoading = false;
        });

        if (result['success']) {
          Navigator.pushAndRemoveUntil(
            context,
            FadePageRouteBuilder(widget: Welcomeview()),(Route<dynamic> route) => false,
          );
        } else {
          // Handle error message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(result['message']),
              backgroundColor: Colors.red,
            ),
          );
        }
      } else {
        print('user is empty.........***********');
      }
    } catch (e) {
      print("Google Sign-In error: $e");
    } finally {
      setState(() {
        _isGoogleLoading = false; // Hide loading indicator on Google icon
      });
    }
  }
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        // Ensure the content resizes when the keyboard appears
        fit: StackFit.expand,
        children: [
          SvgPicture.asset(
            'assets/svg/plan_background.svg',
            fit: BoxFit.cover,
          ),
          Column(
            children: [
              AppBar(
                centerTitle: true,
                title: Text(
                  "Login",
                  style: TextStyle(fontSize: 22, color: Colors.white),
                ),
                backgroundColor: Colors.transparent,
                elevation: 0,
                iconTheme: IconThemeData(
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Theme(
                      data: Theme.of(context).copyWith(
                        inputDecorationTheme: InputDecorationTheme(
                          errorStyle: TextStyle(color: Colors.white),
                        ),
                      ),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Email Label with red asterisk
                            RichText(
                              text: TextSpan(
                                text: "Email",
                                style: TextStyle(color: Colors.white, fontSize: 14),
                                children: [
                                  TextSpan(
                                    text: " *",
                                    style: TextStyle(color: Colors.red, fontSize: 14),
                                  ),
                                ],
                              ),
                            ),
                            TextFormField(
                              controller: _emailController,
                              focusNode: _emailFocusNode,
                              textInputAction: TextInputAction.next,
                              onFieldSubmitted: (_) {
                                FocusScope.of(context)
                                    .requestFocus(_passwordFocusNode);
                              },
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
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter an email';
                                }
                                final emailRegex = RegExp(
                                    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                                if (!emailRegex.hasMatch(value)) {
                                  return 'Enter a valid email';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 20),
                            // Password Label with red asterisk
                            RichText(
                              text: TextSpan(
                                text: "Password",
                                style: TextStyle(color: Colors.white, fontSize: 14),
                                children: [
                                  TextSpan(
                                    text: " *",
                                    style: TextStyle(color: Colors.red, fontSize: 14),
                                  ),
                                ],
                              ),
                            ),
                            TextFormField(
                              controller: _passwordController,
                              focusNode: _passwordFocusNode,
                              textInputAction: TextInputAction.done,
                              onFieldSubmitted: (_) {
                                FocusScope.of(context).unfocus();
                              },
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
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _obscurePassword
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _obscurePassword = !_obscurePassword;
                                    });
                                  },
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                              ),
                              obscureText: _obscurePassword,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a password';
                                }
                                if (value.length < 6) {
                                  return 'Password must be at least 6 characters long';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 20),
                            Row(
                              children: [
                                Theme(
                                  data: ThemeData(
                                    unselectedWidgetColor: Colors.white,
                                  ),
                                  child: Checkbox(
                                    side: BorderSide(
                                      color: Colors.white,
                                      width: 1.5,
                                    ),
                                    value: isChecked,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        isChecked = value ?? false;
                                      });
                                    },
                                    activeColor: Colors.white,
                                    checkColor: Colors.black,
                                  ),
                                ),
                                Text(
                                  'Remember me',
                                  style: TextStyle(color: Colors.white),
                                ),
                                Spacer(),
                                Text(
                                  "Forgot Password?",
                                  style: TextStyle(color: Color(0xFF03BCBF)),
                                )
                              ],
                            ),
                            SizedBox(height: 20),
                            GestureDetector(
                              onTap: () async {
                                FocusScope.of(context).unfocus();
                                if (_formKey.currentState!.validate()) {
                                  setState(() {
                                    _isLoading = true;
                                  });

                                  final result = await loginUser(
                                    email: _emailController.text.trim(),
                                    password: _passwordController.text,
                                    auth_provider: 'email',
                                  );

                                  setState(() {
                                    _isLoading = false;
                                  });

                                  if (result['success']) {
                                    // Navigate to WelcomeView
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      FadePageRouteBuilder(
                                        widget: Welcomeview()
                                      ),(Route<dynamic> route) => false,
                                    );
                                  } else {
                                    // Show platform-specific error message
                                    if (Platform.isAndroid) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text(result['message']),
                                          backgroundColor: Colors.red,
                                        ),
                                      );
                                    } else if (Platform.isIOS) {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return CupertinoAlertDialog(
                                            title: Text('Error'),
                                            content: Text(result['message']),
                                            actions: [
                                              CupertinoDialogAction(
                                                isDefaultAction: true,
                                                child: Text('OK'),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    } else {
                                      // Fallback for other platforms
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text(result['message']),
                                          backgroundColor: Colors.red,
                                        ),
                                      );
                                    }
                                  }
                                }
                              },
                              child: Center(
                                child: Container(
                                  height: 50,
                                  width: MediaQuery.of(context).size.width * 0.9,
                                  decoration: BoxDecoration(
                                    color: Color(0xFF03BCBF),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Center(
                                    child: _isLoading
                                        ? CircularProgressIndicator(
                                      valueColor:
                                      AlwaysStoppedAnimation<Color>(
                                          Colors.white),
                                    )
                                        : Text(
                                      "Login",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    height: 1,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  "or continue with",
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.white),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Container(
                                    height: 1,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: ()async{
                                    _handleGoogleSignIn(context);
                                  },
                                  child: _isGoogleLoading
                                      ? CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                  )
                                      : SvgPicture.asset("assets/svg/google svg.svg"),
                                ),
                                SizedBox(width: 10),
                                // SvgPicture.asset(
                                //   "assets/svg/apple svg.svg",
                                //   height: 36,
                                //   width: 36,
                                // ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
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
