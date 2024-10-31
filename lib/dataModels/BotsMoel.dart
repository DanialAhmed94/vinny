class Bots {
  final String message;
  final List<Bot> data;
  final int status;

  Bots({
    required this.message,
    required this.data,
    required this.status,
  });

  // Factory method to create a Bots instance from JSON
  factory Bots.fromJson(Map<String, dynamic> json) {
    return Bots(
      message: json['message'] as String,
      data: (json['data'] as List)
          .map((botJson) => Bot.fromJson(botJson))
          .toList(),
      status: json['status'] as int,
    );
  }
}

class Bot {
  final int id;
  final String botName;
  final String shortDescription;
  final String image;
  final String isFree; // Keep as String
  final String categoryId; // Keep as String
  final String isFeatured; // Keep as String
  final String setOfRules;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int likes_count;

  Bot({
    required this.id,
    required this.botName,
    required this.shortDescription,
    required this.image,
    required this.isFree,
    required this.categoryId,
    required this.isFeatured,
    required this.setOfRules,
    required this.createdAt,
    required this.updatedAt,
    required this.likes_count
  });

  // Factory method to create a Bot instance from JSON
  factory Bot.fromJson(Map<String, dynamic> json) {
    return Bot(
      id: json['id'] as int,
      botName: json['bot_name'] as String,
      shortDescription: json['short_description'] as String,
      image: json['image'] as String,
      isFree: json['is_free'] as String, // Keep as String
      categoryId: json['category_id'] as String, // Keep as String
      isFeatured: json['is_featured'] as String, // Keep as String
      setOfRules: json['set_of_rules'] as String,
      likes_count: json['likes_count'] as int,
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}
