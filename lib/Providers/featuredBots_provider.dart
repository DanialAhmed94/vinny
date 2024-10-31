// File: ../providers/FeaturedBotProvider.dart

import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';

import '../apis/getFeaturedBots.dart';
import '../dataModels/featuredBots_model.dart';

class FeaturedBotProvider with ChangeNotifier {
  List<FeaturedBot> _featuredBots = [];
  bool _isLoading = false;
  String _message = ''; // Store the message for error/success feedback

  List<FeaturedBot> get featuredBots => _featuredBots;
  bool get isLoading => _isLoading;
  String get message => _message;

  Future<void> fetchFeaturedBotsData() async {
    _isLoading = true;
    _message = '';
    notifyListeners();

    try {
      final featuredBotsResponse = await fetchFeaturedBots(); // Fetches a FeaturedBots instance
      _featuredBots = featuredBotsResponse.data; // Access the list of FeaturedBot instances
      _message = featuredBotsResponse.message; // Set the message from the response
    } on SocketException {
      _message = "No internet connection. Please check your network and try again.";
    } on TimeoutException {
      _message = "The server took too long to respond. Please try again later.";
    } on FormatException {
      _message = "Unexpected data format received from the server.";
    } on HttpException catch (e) {
      _message = e.message;
    } catch (error) {
      _message = error.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
