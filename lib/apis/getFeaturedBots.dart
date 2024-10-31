// File: ../apis/fetchFeaturedBots.dart

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/AppConstants.dart';
import '../dataModels/featuredBots_model.dart';

Future<FeaturedBots> fetchFeaturedBots() async {
  String baseUrl = AppConstants.baseUrl;
  final url = Uri.parse("$baseUrl/featured_bots"); // Adjust endpoint as needed

  final prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('bearerToken') ?? '';

  try {
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    ).timeout(Duration(seconds: 30));

    if (response.statusCode == 200) {
      try {
        print("Response Body: ${response.body}"); // Debugging line
        final Map<String, dynamic> data = json.decode(response.body);
        return FeaturedBots.fromJson(data);
      } catch (e) {
        print("JSON Decoding Error: $e");
        throw Exception('Failed to decode response data.');
      }
    } else {
      throw HttpException(
        'Failed to load featured bots. Server returned status code: ${response.statusCode}',
      );
    }
  } on SocketException {
    throw Exception('No internet connection. Please check your network.');
  } on TimeoutException {
    throw Exception('The request timed out. Please try again later.');
  } on FormatException {
    throw Exception('Unexpected data format from the server.');
  } on HttpException catch (e) {
    throw Exception(e.message);
  } catch (e) {
    throw Exception('An unexpected error occurred. Please try again.');
  }
}
