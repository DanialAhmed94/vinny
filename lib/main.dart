import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vinny_ai_chat/Providers/categories_provider.dart';
import 'package:vinny_ai_chat/Providers/featuredBots_provider.dart';
import 'package:vinny_ai_chat/splash.dart';

import 'Providers/categorizedBots_provider.dart';
import 'Providers/chat_provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'Providers/freeBots_provider.dart';
import 'Providers/likeDislikeProvider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
await dotenv.load(fileName: '.env');
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ChatProvider()),
        ChangeNotifierProvider(create: (_) => BotProvider()),
        ChangeNotifierProvider(create: (_) => CategoryProvider()),
        ChangeNotifierProvider(create: (_) => FeaturedBotProvider()),
        ChangeNotifierProvider(create: (_) => CategorizedBotsProvider()),
        ChangeNotifierProvider(create: (_) => LikeDislikeProvider()),
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
