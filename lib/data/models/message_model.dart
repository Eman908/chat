import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  final String message;
  final DateTime time;
  final String messagesId;
  final String senderId;

  MessageModel({
    required this.message,
    required this.time,
    required this.messagesId,
    required this.senderId,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      message: json['message'],
      time: json['time'] is Timestamp
          ? (json['time'] as Timestamp).toDate()
          : DateTime.now(),
      messagesId: json['messagesId'],
      senderId: json['senderId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'time': Timestamp.fromDate(time),
      'senderId': senderId,
      'messagesId': messagesId,
    };
  }
}
