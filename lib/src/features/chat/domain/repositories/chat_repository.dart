import 'package:clean_arch_bloc/src/features/chat/domain/entities/chat_entity.dart';

abstract class ChatRepository {
  Future<List<Chat>> getChatsByUser(String userId);

  Future<Chat> getChatById(String userId, String chatId);

  Future<void> updateChat(Chat chat);
}
