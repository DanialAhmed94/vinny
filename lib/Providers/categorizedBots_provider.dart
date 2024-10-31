import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';

import '../apis/categorizedBots.dart';
import '../dataModels/BotsMoel.dart';


class CategorizedBotsProvider with ChangeNotifier {
  List<Bot> _bots = [];
  bool _isLoading = false;
  String _message = '';

  List<Bot> get bots => _bots;
  bool get isLoading => _isLoading;
  String get message => _message;

  // Fetch bots by category ID
  Future<void> fetchBotsByCategory(String categoryId) async {
    _isLoading = true;
    _message = '';
    notifyListeners();

    try {
      // Fetch the bots from the API
      final botsResponse = await getCategorizedBots(categoryId);

      // Update the bots list and message
      _bots = botsResponse.data;
      _message = botsResponse.message;
    } on SocketException {
      _message = "No internet connection. Please check your network and try again.";
    } on TimeoutException {
      _message = "The server took too long to respond. Please try again later.";
    } on FormatException {
      _message = "Unexpected data format received from the server.";
    } catch (error) {
      _message = error.toString();
    } finally {
      // Update the loading state and notify listeners
      _isLoading = false;
      notifyListeners();
    }
  }
}
