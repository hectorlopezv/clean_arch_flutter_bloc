import 'package:clean_arch_bloc/src/features/chat/data/models/message_model.dart';
import 'package:clean_arch_bloc/src/features/chat/domain/entities/chat_entity.dart';
import 'package:clean_arch_bloc/src/shared/data/models/user_model.dart';
import 'package:hive/hive.dart';

part 'chat_model.g.dart';

@HiveType(typeId: 3)
class ChatModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final UserModel currentUser;
  @HiveField(2)
  final UserModel otherUser;
  @HiveField(3)
  final List<MessageModel>? messages;

  ChatModel({
    required this.id,
    required this.currentUser,
    required this.otherUser,
    this.messages = const <MessageModel>[],
  });

  factory ChatModel.fromJson(Map<String, dynamic> chat,
      Map<String, dynamic> currentUser, Map<String, dynamic> otherUser) {
    return ChatModel(
      id: chat["id"],
      currentUser: UserModel.fromJson(currentUser),
      otherUser: UserModel.fromJson(otherUser),
      messages: (chat["messages"] as List)!
          .map(
            (message) => MessageModel.fromJson(
              message,
              chat['id'],
            ),
          )
          .toList(),
    );
  }

  factory ChatModel.fromEntity(Chat chat) => ChatModel(
        id: chat.id,
        currentUser: UserModel.fromEntity(chat.currentUser),
        otherUser: UserModel.fromEntity(chat.otherUser),
        messages:
            chat.messages?.map((e) => MessageModel.fromEntity(e)).toList(),
      );

  Chat toEntity() {
    return Chat(
      id: id,
      currentUser: currentUser.toEntity(),
      otherUser: otherUser.toEntity(),
      messages: messages?.map((e) => e.toEntity()).toList(),
    );
  }
}
