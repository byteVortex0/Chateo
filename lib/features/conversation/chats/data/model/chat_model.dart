import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

class ChatModel extends Equatable {
  const ChatModel({
    this.id,
    required this.users,
    required this.chatData,
    required this.lastMessageTime,
    required this.lastMessage,
  });

  final String? id;
  final Users users;
  final List<ChatData> chatData;
  final DateTime lastMessageTime;
  final String lastMessage;

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      id: json['id'] as String?,
      users: Users.fromJson(json['users'] as Map<String, dynamic>),
      chatData:
          (json['chat_data'] as List<dynamic>)
              .map((e) => ChatData.fromJson(e as Map<String, dynamic>))
              .toList(),
      lastMessageTime: DateTime.parse(json['last_message_time'] as String),
      lastMessage: json['last_message'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'users': users.toJson(),
      'chat_data': chatData.map((e) => e.toJson()).toList(),
      'last_message_time': lastMessageTime.toIso8601String(),
      'last_message': lastMessage,
    };
  }

  @override
  List<Object?> get props => [
    id,
    users,
    chatData,
    lastMessageTime,
    lastMessage,
  ];
}

class Users {
  final String user1Id;
  final String user2Id;

  Users({required this.user1Id, required this.user2Id});

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      user1Id: json['user1_id'] as String,
      user2Id: json['user2_id'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {'user1_id': user1Id, 'user2_id': user2Id};
  }
}

final uuid = Uuid();

class ChatData {
  final String? messageId;
  final String? senderId;
  final String? content;
  final DateTime sendAt;
  final bool isSeen;
  final String? swipperMessageId;

  ChatData({
    this.messageId,
    required this.senderId,
    required this.content,
    required this.sendAt,
    required this.isSeen,
    required this.swipperMessageId,
  });

  factory ChatData.fromJson(Map<String, dynamic> json) {
    return ChatData(
      messageId: json['id'] as String?,
      senderId: json['sender_id'] as String?,
      content: json['content'] as String?,
      sendAt: DateTime.parse(json['send_at'] as String),
      isSeen: json['is_seen'] as bool,
      swipperMessageId: json['swipper_massage_id'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': uuid.v4(),
      'sender_id': senderId,
      'content': content,
      'send_at': sendAt.toIso8601String(),
      'is_seen': isSeen,
      'swipper_massage_id': swipperMessageId,
    };
  }
}
