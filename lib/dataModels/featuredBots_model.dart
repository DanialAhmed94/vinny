import 'dart:convert';

class FeaturedBots {
  final String message;
  final List<FeaturedBot> data;
  final int status;

  FeaturedBots({
    required this.message,
    required this.data,
    required this.status,
  });

  // Factory method to create a Bots instance from JSON
  factory FeaturedBots.fromJson(Map<String, dynamic> json) {
    return FeaturedBots(
      message: json['message'] as String,
      data: (json['data'] as List)
          .map((botJson) => FeaturedBot.fromJson(botJson))
          .toList(),
      status: json['status'] as int,
    );
  }


}

class FeaturedBot {
  final int id;
  final String botName;
  final String shortDescription;
  final String image;
  final String isFree; // Kept as String as per requirement
  final String categoryId; // Kept as String as per requirement
  final String isFeatured; // Kept as String as per requirement
  final String setOfRules;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int likes_count;

  FeaturedBot({
    required this.id,
    required this.botName,
    required this.shortDescription,
    required this.image,
    required this.isFree,
    required this.categoryId,
    required this.isFeatured,
    required this.setOfRules,
    required this.createdAt,
    required this.updatedAt,      required this.likes_count


  });

  // Factory method to create a Bot instance from JSON
  factory FeaturedBot.fromJson(Map<String, dynamic> json) {
    return FeaturedBot(
      id: json['id'] as int,
      botName: json['bot_name'] as String,
      shortDescription: json['short_description'] as String,
      image: json['image'] as String,
      isFree: json['is_free'] as String, // Kept as String
      categoryId: json['category_id'] as String, // Kept as String
      isFeatured: json['is_featured'] as String, // Kept as String
      setOfRules: json['set_of_rules'] as String,
      likes_count: json['likes_count'] as int,

      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

}
