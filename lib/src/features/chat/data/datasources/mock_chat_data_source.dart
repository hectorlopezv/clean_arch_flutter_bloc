import 'package:clean_arch_bloc/src/features/chat/data/models/chat_model.dart';
import 'package:clean_arch_bloc/src/features/chat/domain/entities/chat_entity.dart';
import 'package:clean_arch_bloc/src/shared/data/dataSource/chat/chat_data.dart';
import 'package:clean_arch_bloc/src/shared/data/dataSource/user/user_data_source.dart';

abstract class MockChatDataSource {
  Future<List<Chat>> getChatsByUser(String userId);

  Future<Chat> getChatById(String userId, String chatId);

  Future<void> updateChat(Chat chat);
}

class MockChatDataSourceImpl implements MockChatDataSource {
  @override
  Future<Chat> getChatById(String userId, String chatId) async {
    await Future.delayed(Duration(milliseconds: 300), () {});

    var res = chats.where((chat) => chat['userIds'] == chatId).map((chat) {
      String currentUserId = userId;
      String otherUserId =
          (chat["usersIds"] as List).where((id) => id != currentUserId).first;
      Map<String, dynamic> currentUser =
          users.where((user) => user["id"] == currentUserId).first;
      Map<String, dynamic> otherUser =
          users.where((user) => user["id"] == otherUserId).first;
      return ChatModel.fromJson(
        chat,
        currentUser,
        otherUser,
      ).toEntity();
    }).first;
    return res;
  }

  @override
  Future<List<Chat>> getChatsByUser(String userId) async {
    print("user_id $userId");
    await Future.delayed(Duration(milliseconds: 300), () {});
    // print("chats ${chats}");
    var containsUser = chats.where((chat) => chat['userIds'].contains(userId));

    print("containsUser ${containsUser}");
    var res = containsUser.map((chat) {
      String currentUserId = userId;
      String otherUserId =
          chat["userIds"].where((id) => id != currentUserId).first;
      Map<String, dynamic> currentUser =
          users.where((user) => user["id"] == currentUserId).first;
      Map<String, dynamic> otherUser =
          users.where((user) => user["id"] == otherUserId).first;
      print("currentUser ${currentUser}");
      print("otherUser ${otherUser}");
      print("chat ${chat}");
      return ChatModel.fromJson(
        chat,
        currentUser,
        otherUser,
      ).toEntity();
    }).toList();
    return res;
  }

  @override
  Future<void> updateChat(Chat chat) {
    // TODO: implement updateChat
    throw UnimplementedError();
  }
}
