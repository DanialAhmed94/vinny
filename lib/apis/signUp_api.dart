import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:vinny_ai_chat/constants/AppConstants.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Signs up a user, saves the token, and returns a success or error message.
Future<Map<String, dynamic>> signupUser({
   String? email,
   String? username,
   String? password,
   String? auth_provider,
  String? google_id
}) async {
  String trialStartDate = DateTime.now().toString();
  int trialDays = 7;
  String trialEndDate = DateTime.now().add(Duration(days: trialDays)).toString();

  String baseurl = AppConstants.baseUrl;
  final url = Uri.parse("$baseurl/authup");

  try {
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'email': email,
        'name': username,
        'password': password,
        'auth_provider': auth_provider,
        'google_id':google_id,
        'trial_start_date': trialStartDate,
        'trial_end_date':trialEndDate,
      }),
    );

    final responseData = json.decode(response.body);

    if (response.statusCode == 200) {
      // Extract token from the response
      String? token = responseData['data']?['response']?['token'];

      if (token != null) {
        // Save token to shared preferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('bearerToken', token);

        return {
          'success': true,
          'message': responseData['message'] ?? 'Signup successful!',
        };
      } else {
        // Token not found in the response
        return {
          'success': false,
          'message': 'Signup failed. Token not found in response.',
        };
      }
    } else {
      // Parse and return error from the API response
      String errorMessage = 'Signup failed. Please try again.';
      if (responseData.containsKey('errors') && responseData['errors'] is List) {
        final errors = responseData['errors'].join(' ');
        errorMessage = errors;
      } else if (responseData.containsKey('message')) {
        errorMessage = responseData['message'];
      }

      return {
        'success': false,
        'message': errorMessage,
      };
    }
  } catch (e) {
    // Handle exceptions like network errors
    return {
      'success': false,
      'message':
      'An error occurred. Please check your connection and try again.',
    };
  }
}
