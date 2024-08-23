import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vinny_ai_chat/splash.dart';

import 'Providers/chat_provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';


void main() async {
await dotenv.load(fileName: '.env');
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ChatProvider()),
      ],
      child: MyApp(),
    ),
  );
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFF010125), // Example color
      ),
      home: SplashScreen(),
    );
  }
}
