import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:vinny_ai_chat/constants/AppConstants.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Signs up a user, saves the token, and returns a success or error message.
Future<Map<String, dynamic>> loginWithGoogle({
  String? email,
  String? username,
  String? auth_provider,
  String? google_id
}) async {
  String trialStartDate = DateTime.now().toString();
  int trialDays = 7;
  String trialEndDate = DateTime.now().add(Duration(days: trialDays)).toString();

  String baseurl = AppConstants.baseUrl;
  final url = Uri.parse("$baseurl/google_login");

  try {
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'email': email,
        'name': username,
        'auth_provider': auth_provider,
        'google_id':google_id,
        'trial_start_date': trialStartDate,
        'trial_end_date':trialEndDate,
      }),
    );

    final responseData = json.decode(response.body);

    if (response.statusCode == 200) {
      // Case 1: Success - Save token and return success message
      String? token = responseData['data']?['response']?['token'];
      if (token != null) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('bearerToken', token);
        await prefs.setBool("isLogedin", true);
        await prefs.setString('authProvider', auth_provider ?? 'email');

        return {
          'success': true,
          'message': responseData['message'] ?? 'Login successful!',
        };
      } else {
        return {
          'success': false,
          'message': 'Login failed. Token not found in response.',
        };
      }
    } else if (response.statusCode == 403) {
      // Case 2: Trial expired
      return {
        'success': false,
        'message':
        'Your trial has expired. Please upgrade to continue.',
      };
    } else if (response.statusCode == 400) {
      // Case 3: Invalid credentials
      return {
        'success': false,
        'message':  'Invalid credentials.',
      };
    } else {
      // Other error codes
      return {
        'success': false,
        'message': 'An unknown error occurred. Please try again.',
      };
    }
  } on SocketException {
    // Handle network issues
    return {
      'success': false,
      'message': 'No internet connection. Please check and try again.',
    };
  } on TimeoutException {
    // Handle request timeout
    return {
      'success': false,
      'message': 'Request timed out. Please try again.',
    };
  } catch (e) {
    // Handle other exceptions
    return {
      'success': false,
      'message': 'An error occurred. Please check your connection and try again.',
    };
  }
}

