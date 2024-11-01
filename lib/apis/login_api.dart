import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:vinny_ai_chat/constants/AppConstants.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Logs in a user, saves the token, name, and email if successful, and returns a success or error message.
Future<Map<String, dynamic>> loginUser({
  String? email,
  String? password,
  String? auth_provider,
}) async {
  String baseurl = AppConstants.baseUrl;
  final url = Uri.parse("$baseurl/authin"); // Adjust the endpoint as needed

  try {
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'email': email ?? '',
        'password': password ?? '',
        'auth_provider': auth_provider ?? 'email',
      }),
    );

    final responseData = json.decode(response.body);

    // Check for response code and handle each case
    if (response.statusCode == 200) {
      // Case 1: Success - Save token, name, email and return success message
      String? token = responseData['data']?['response']?['token'];

      if (token != null) {
        // Get name and email from the response
        String? name = responseData['data']?['user']?['name'];
        String? email = responseData['data']?['user']?['email'];

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('bearerToken', token);
        await prefs.setBool("isLogedin", true);
        await prefs.setString('authProvider', auth_provider ?? 'email');

        // Save name and email if they are not null
        if (name != null) {
          await prefs.setString('userName', name);
        }
        if (email != null) {
          await prefs.setString('userEmail', email);
        }

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
        'message': 'Your trial has expired. Please upgrade to continue.',
      };
    } else if (response.statusCode == 400) {
      // Case 3: Invalid credentials
      return {
        'success': false,
        'message': 'Invalid credentials.',
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
      'message':
          'An error occurred. Please check your connection and try again.',
    };
  }
}
