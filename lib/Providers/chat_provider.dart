

import 'dart:async';
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:record/record.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

import '../constants/AppConstants.dart';
class ChatProvider with ChangeNotifier {
  final Map<String, List<Map<String, dynamic>>> _chatMessages = {};
  bool _showStar = false;
  int _selectedStar = 0;
  bool _isRecording = false;
  bool _isPlaying = false;
  bool _isTyping = false;
  bool _showAdditionalIcons = true; // Default state shows additional icons
  bool _isLoading = false;

  List<Map<String, dynamic>> getMessages(String chatTitle) {
    return _chatMessages[chatTitle] ?? [];
  }
  bool get isLoading => _isLoading;
  bool get isTyping => _isTyping;
  bool get isPlaying => _isPlaying;
  bool get showStar => _showStar;
  bool get showAdditionalIcons => _showAdditionalIcons;
  int get selectedStar => _selectedStar;
  bool get isRecording => _isRecording;

  void setTyping(bool isTyping) {
    _isTyping = isTyping;
    if (isTyping) {
      _showAdditionalIcons = false; // Hide icons when typing
    }
    notifyListeners();
  }

  void togglePlaying() {
    _isPlaying = !_isPlaying;
    notifyListeners();
  }

  void toggleStar() {
    _showStar = !_showStar;
    notifyListeners();
  }

  void showAdditionalIcons1() {
    _showAdditionalIcons = true;
    notifyListeners();
  }

  void selectStar(int star) {
    _selectedStar = star;
    notifyListeners();
  }

  Future<void> sendMessage(String chatTitle, String text, String rules) async {
    _isLoading = true; // Set loading state to true
    notifyListeners();

    if (_chatMessages[chatTitle] == null) {
      _chatMessages[chatTitle] = [];
    }
    _chatMessages[chatTitle]?.add({"text": text, "sender": "me", "time": "now"});
    notifyListeners();

    try {
      final response = await http.post(
        Uri.parse('https://api.openai.com/v1/chat/completions'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${dotenv.env['API_KEY']}', // Replace with your API key
        },
        body: jsonEncode({
          'model': 'gpt-4o-mini', // or 'gpt-4' if you have access
          'messages': [
            {'role': 'system', 'content': '$rules'},
            {'role': 'user', 'content': text},
          ],
          'max_tokens': 1000, // Adjust as needed
        }),
      ).timeout(Duration(seconds: 20)); // Set timeout duration

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['choices'] != null && data['choices'].isNotEmpty) {
          final gptResponse = data['choices'][0]['message']['content'].trim();

          _chatMessages[chatTitle]?.add({
            "text": gptResponse,
            "sender": "other",
            "time": "now"
          });
        }
      } else {
        throw Exception('Failed to get response from ChatGPT: ${response.statusCode}');
      }
    } on TimeoutException catch (_) {
      // Handle timeout
      print('Request to ChatGPT API timed out');
      _chatMessages[chatTitle]?.add({
        "text": "Request timed out. Please try again.",
        "sender": "system",
        "time": "now"
      });
    } catch (e) {
      print('Error calling ChatGPT API: $e');
      _chatMessages[chatTitle]?.add({
        "text": "Error: Unable to get a response. Please try again later.",
        "sender": "system",
        "time": "now"
      });
    } finally {
      _isLoading = false; // Set loading state to false
      notifyListeners();
    }
  }

  Future<void> startRecording() async {
    try {
      if (await Permission.microphone.request().isGranted) {
        Record recorder = Record();

        if (await recorder.hasPermission()) {
          Directory appDocDirectory = await getApplicationDocumentsDirectory();
          String path = '${appDocDirectory.path}/audio.mp3';  // Use mp3 file extension

          _isRecording = true;

          await recorder.start(
            path: path,
            encoder: AudioEncoder.aacLc,  // Use AAC codec for mp3-like quality
            bitRate: 128000,
            samplingRate: 44100,
          );

          notifyListeners();
        } else {
          throw Exception('Microphone permission not granted');
        }
      } else {
        throw Exception('Microphone permission not granted');
      }
    } catch (e) {
      print('Error starting recording: $e');
      _isRecording = false;
      notifyListeners();
    }
  }

  Future<void> stopRecording(String chatTitle) async {
    try {
      Record recorder = Record();
      _isRecording = false;
      final path = await recorder.stop();

      if (path != null) {
        if (_chatMessages[chatTitle] == null) {
          _chatMessages[chatTitle] = [];
        }
        _chatMessages[chatTitle]?.add({"audio": path, "sender": "me", "time": "now"});
        notifyListeners();
      } else {
        throw Exception('Error stopping recording');
      }
    } catch (e) {
      print('Error stopping recording: $e');
      notifyListeners();
    }
  }
}













