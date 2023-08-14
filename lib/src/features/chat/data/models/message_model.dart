import 'package:clean_arch_bloc/src/features/chat/domain/entities/message_entity.dart';
import 'package:hive/hive.dart';

part 'message_model.g.dart';

@HiveType(typeId: 2)
class MessageModel {
  @HiveField(0)
  final String chatId;
  @HiveField(1)
  final String senderId;
  @HiveField(2)
  final String recipientId;
  @HiveField(3)
  final String text;
  @HiveField(4)
  final DateTime createdAt;

  MessageModel({
    required this.chatId,
    required this.senderId,
    required this.recipientId,
    required this.text,
    required this.createdAt,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json, String chatId) =>
      MessageModel(
        chatId: chatId,
        senderId: json["senderId"],
        recipientId: json["recipientId"],
        text: json["text"],
        createdAt: json["createdAt"],
      );

  factory MessageModel.fromEntity(Message message) => MessageModel(
        chatId: message.chatId,
        senderId: message.senderId,
        recipientId: message.recipientId,
        text: message.text,
        createdAt: message.createdAt,
      );

  Message toEntity() {
    return Message(
      chatId: chatId,
      senderId: senderId,
      recipientId: recipientId,
      text: text,
      createdAt: createdAt,
    );
  }
}
