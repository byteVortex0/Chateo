import 'package:uuid/uuid.dart';

class StoryModel {
  final String? id;
  final String userId;
  List<StoryData> storiesData;

  StoryModel({this.id, required this.userId, required this.storiesData});

  Map<String, dynamic> toJson() => {
    'user_id': userId,
    'stories_data': storiesData.map((story) => story.toJson()).toList(),
  };

  factory StoryModel.fromJson(Map<String, dynamic> json) {
    return StoryModel(
      id: json['id'],
      userId: json['user_id'],
      storiesData: (json['stories_data'] as List<dynamic>)
          .map((story) => StoryData.fromJson(story))
          .toList(growable: false),
    );
  }
}

Uuid uuid = const Uuid();

class StoryData {
  final String? id;
  final String? imageUrl;
  final String? caption;
  final DateTime createdAt;

  StoryData({this.id, this.imageUrl, this.caption, required this.createdAt});

  Map<String, dynamic> toJson() => {
    'id': id ?? uuid.v4(),
    'image_url': imageUrl,
    'caption': caption?.trim(),
    'created_at': createdAt.toIso8601String(),
  };

  factory StoryData.fromJson(Map<String, dynamic> json) {
    return StoryData(
      id: json['id'],
      imageUrl: json['image_url'],
      caption: json['caption'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}
