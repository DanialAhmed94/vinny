import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../constants/AppConstants.dart';

class LikeDislikeProvider with ChangeNotifier {
  final Map<String, bool> _likedBots = {}; // Tracks like status by bot ID
  final Map<String, int> _likesCount = {}; // Stores likes count for each bot
  String? errorMessage; // Holds the latest error message for UI display

  // Check if a bot is liked
  bool isLiked(String botId) {
    return _likedBots[botId] ?? false;
  }

  // Get the adjusted like count
  int getAdjustedLikeCount(String botId, int originalLikeCount) {
    if (!_likesCount.containsKey(botId)) {
      _likesCount[botId] = originalLikeCount;
    }
    return _likesCount[botId]!;
  }

  // Toggle like status for a bot
  Future<void> toggleLike(String botId, int originalLikeCount) async {
    bool currentStatus = _likedBots[botId] ?? false;

    try {
      if (!currentStatus) {
        // User is liking the bot
        await _likeBot(botId);
        _likedBots[botId] = true;
        _likesCount[botId] = (_likesCount[botId] ?? originalLikeCount) + 1; // Increment likes_count
      } else {
        // User is unliking the bot
        await _dislikeBot(botId);
        _likedBots[botId] = false;
        _likesCount[botId] = (_likesCount[botId] ?? originalLikeCount) - 1; // Decrement likes_count
      }
      notifyListeners();
    } catch (error) {
      // Revert changes on error
      _likedBots[botId] = currentStatus;
      errorMessage = error.toString(); // Set error message
      notifyListeners();
    }
  }

  // Like a bot (send API request)
  Future<void> _likeBot(String botId) async {
    try {
      String baseurl = AppConstants.baseUrl;
      final url = Uri.parse("$baseurl/like");
      final prefs = await SharedPreferences.getInstance();
      String token = prefs.getString('bearerToken') ?? '';
      final response = await http
          .post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'bot_id': botId,
          'like': 1, // 1 for like
        }),
      )
          .timeout(Duration(seconds: 20));
      if (response.statusCode != 200) {
        throw HttpException(
            "Failed to like bot with status: ${response.statusCode}");
      }
    } on SocketException {
      throw Exception(
          "No internet connection. Please check your connection and try again.");
    } on TimeoutException {
      throw Exception("Request timed out. Please try again later.");
    } on HttpException catch (e) {
      throw Exception("Server error: ${e.message}");
    } catch (e) {
      throw Exception("An unexpected error occurred: $e");
    }
  }

  // Dislike a bot (send API request)
  Future<void> _dislikeBot(String botId) async {
    try {
      String baseurl = AppConstants.baseUrl;
      final url = Uri.parse("$baseurl/like");
      final prefs = await SharedPreferences.getInstance();
      String token = prefs.getString('bearerToken') ?? '';
      final response = await http
          .post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'bot_id': botId,
          'like': 0, // 0 for dislike (unlike)
        }),
      )
          .timeout(Duration(seconds: 20));
      if (response.statusCode != 200) {
        throw HttpException(
            "Failed to dislike bot with status: ${response.statusCode}");
      }
    } on SocketException {
      throw Exception(
          "No internet connection. Please check your connection and try again.");
    } on TimeoutException {
      throw Exception("Request timed out. Please try again later.");
    } on HttpException catch (e) {
      throw Exception("Server error: ${e.message}");
    } catch (e) {
      throw Exception("An unexpected error occurred: $e");
    }
  }

  // Method to clear error message after displaying in snackbar
  void clearErrorMessage() {
    errorMessage = null;
    notifyListeners();
  }

  // Method to clear all liked bots and likes count (e.g., on logout)
  void clearLikedBots() {
    _likedBots.clear();
    _likesCount.clear();
    notifyListeners();
  }
}


// import 'dart:async';
// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
// import '../../constants/AppConstants.dart';
//
// class LikeDislikeProvider with ChangeNotifier {
//   final Map<String, bool> _likedBots = {}; // Tracks like status by bot ID
//   String? errorMessage; // Holds the latest error message for UI display
//
//   bool isLiked(String botId) {
//     return _likedBots[botId] ?? false;
//   }
//
//   Future<void> toggleLike(String botId) async {
//     bool currentStatus = _likedBots[botId] ?? false;
//
//     _likedBots[botId] = !currentStatus;
//     notifyListeners();
//
//     try {
//       if (!currentStatus) {
//         await _likeBot(botId);
//       } else {
//         await _dislikeBot(botId);
//       }
//     } catch (error) {
//       _likedBots[botId] = currentStatus; // Revert status
//       errorMessage = error.toString(); // Set error message
//       notifyListeners();
//     }
//   }
//
//   Future<void> _likeBot(String botId) async {
//     try {
//       String baseurl = AppConstants.baseUrl;
//       final url = Uri.parse("$baseurl/like");
//       final prefs = await SharedPreferences.getInstance();
//       String token = prefs.getString('bearerToken') ?? '';
//       final response = await http
//           .post(
//         url,
//         headers: {
//           'Authorization': 'Bearer $token',
//           'Content-Type': 'application/json',
//         },
//         body: json.encode({
//           'bot_id': botId,
//           'like': 1, // 1 for like
//         }),
//       )
//           .timeout(Duration(seconds: 20));
// if(response.statusCode==200){
//   print('${response.body}');
// }
//       if (response.statusCode != 200) {
//         throw HttpException(
//             "Failed to like bot with status: ${response.statusCode}");
//       }
//     } on SocketException {
//       throw Exception(
//           "No internet connection. Please check your connection and try again.");
//     } on TimeoutException {
//       throw Exception("Request timed out. Please try again later.");
//     } on HttpException catch (e) {
//       throw Exception("Server error: ${e.message}");
//     } catch (e) {
//       throw Exception("An unexpected error occurred: $e");
//     }
//   }
//
//   Future<void> _dislikeBot(String botId) async {
//     try {
//       String baseurl = AppConstants.baseUrl;
//       final url = Uri.parse("$baseurl/like");
//       final prefs = await SharedPreferences.getInstance();
//       String token = prefs.getString('bearerToken') ?? '';
//       final response = await http
//           .post(
//         url,
//         headers: {
//           'Authorization': 'Bearer $token',
//           'Content-Type': 'application/json',
//         },
//         body: json.encode({
//           'bot_id': botId,
//           'like': 0, // 0 for dislike
//         }),
//       )
//           .timeout(Duration(seconds: 20));
//
//       if (response.statusCode != 200) {
//         throw HttpException(
//             "Failed to dislike bot with status: ${response.statusCode}");
//       }
//     } on SocketException {
//       throw Exception(
//           "No internet connection. Please check your connection and try again.");
//     } on TimeoutException {
//       throw Exception("Request timed out. Please try again later.");
//     } on HttpException catch (e) {
//       throw Exception("Server error: ${e.message}");
//     } catch (e) {
//       throw Exception("An unexpected error occurred: $e");
//     }
//   }
//
//   // Method to clear error message after displaying in snackbar
//   void clearErrorMessage() {
//     errorMessage = null;
//     notifyListeners();
//   }
//   void clearLikedBots() {
//     _likedBots.clear();
//     notifyListeners();
//   }
// }
