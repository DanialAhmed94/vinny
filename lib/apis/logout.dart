import 'dart:async';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:vinny_ai_chat/constants/AppConstants.dart';

/// Logs out a user by clearing stored token and user data.
/// Returns a success or error message.
Future<Map<String, dynamic>> logoutUser() async {
  String baseurl = AppConstants.baseUrl;
  final url = Uri.parse("$baseurl/logout"); // Adjust the endpoint as needed

  try {
    // Make a request to log out on the server if needed
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('bearerToken');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    // Check the response status
    if (response.statusCode == 200) {
      // Clear the stored user data
      await prefs.remove('bearerToken');
      await prefs.remove('isLogedin');
      await prefs.remove('userName');
      await prefs.remove('userEmail');

      return {
        'success': true,
        'message': 'Logout successful.',
      };
    } else {
      return {
        'success': false,
        'message': 'Failed to log out. Please try again.',
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
      'message': 'An error occurred. Please try again.',
    };
  }
}
