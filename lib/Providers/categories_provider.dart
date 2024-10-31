import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';

import '../apis/getCategories.dart';
import '../dataModels/categoriesModel.dart';


class CategoryProvider with ChangeNotifier {
  List<Category> _categories = [];
  bool _isLoading = false;
  String _message = ''; // Store the message for error/success feedback

  List<Category> get categories => _categories;
  bool get isLoading => _isLoading;
  String get message => _message;

  Future<void> fetchCategories() async {
    _isLoading = true;
    _message = '';
    notifyListeners();

    try {
      final categoriesResponse = await getCategories(); // Fetches a Categories instance
      _categories = categoriesResponse.data; // Access the list of Category instances
      _message = categoriesResponse.message; // Set the message from the response
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
