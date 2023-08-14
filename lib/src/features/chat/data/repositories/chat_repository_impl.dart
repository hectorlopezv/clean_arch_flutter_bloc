import 'package:clean_arch_bloc/src/features/chat/data/datasources/local_chat_data_source.dart';
import 'package:clean_arch_bloc/src/features/chat/data/datasources/mock_chat_data_source.dart';
import 'package:clean_arch_bloc/src/features/chat/domain/entities/chat_entity.dart';
import 'package:clean_arch_bloc/src/features/chat/domain/repositories/chat_repository.dart';

class ChatRepositoryImpl implements ChatRepository {
  final MockChatDataSource chatDataSource;
  final LocalChatDataSource localChatDataSource;

  ChatRepositoryImpl(this.chatDataSource, this.localChatDataSource);

  @override
  Future<Chat> getChatById(String userId, String chatId) async {
    Chat? chat = await localChatDataSource.getChatById(chatId);
    chat ??= await chatDataSource.getChatById(userId, chatId);
    return chat;
  }

  @override
  Future<List<Chat>> getChatsByUser(String userId) async {
    print("getChatsByUser");
    print(userId);
    List<Chat> mchats = await localChatDataSource.getChats();
    print("mcharts");
    print(mchats);
    if (mchats.isEmpty) {
      List<Chat> chats = await chatDataSource.getChatsByUser(userId);
      print("chat data source");
      print(chats);

      for (var chat in chats) {
        localChatDataSource.addChat(chat);
      }
      return chats;
    }
    return mchats;
  }

  @override
  Future<void> updateChat(Chat chat) {
    return localChatDataSource.updateChat(chat);
  }
}
