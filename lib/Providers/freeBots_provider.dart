import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';

import '../apis/freeBots.dart';
import '../dataModels/BotsMoel.dart';

class BotProvider with ChangeNotifier {
  List<Bot> _bots = [];
  bool _isLoading = false;
  String _message = ''; // Store the message for error/success feedback

  List<Bot> get bots => _bots;
  bool get isLoading => _isLoading;
  String get message => _message;

  Future<void> fetchBots() async {
    _isLoading = true;
    _message = '';
    notifyListeners();

    try {
      final botsResponse = await fetchFreeBots(); // Now fetches a Bots instance
      _bots = botsResponse.data; // Access the list of Bot instances
      _message = botsResponse.message; // Set the message from the response
    } on SocketException {
      _message = "No internet connection. Please check your network and try again.";
    } on TimeoutException {
      _message = "The server took too long to respond. Please try again later.";
    } on FormatException {
      _message = "Unexpected data format received from the server.";
    } catch (error) {
      _message = error.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
