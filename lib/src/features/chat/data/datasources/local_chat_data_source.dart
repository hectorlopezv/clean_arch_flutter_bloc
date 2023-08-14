import 'package:clean_arch_bloc/src/features/chat/data/models/chat_model.dart';
import 'package:clean_arch_bloc/src/features/chat/domain/entities/chat_entity.dart';
import 'package:hive/hive.dart';

abstract class LocalChatDataSource {
  Future<List<Chat>> getChats();

  Future<Chat?> getChatById(String chatId);

  Future<void> addChat(Chat chat);

  Future<void> updateChat(Chat chat);
}

class LocalChatDataSourceImpl implements LocalChatDataSource {
  String boxName = 'chats';
  Type boxType = ChatModel;

  Future<Box> _openBox() {
    return Hive.openBox<ChatModel>(boxName);
  }

  @override
  Future<void> addChat(Chat chat) async {
    Box box = await _openBox();
    return box.put(
      chat.id,
      ChatModel.fromEntity(chat),
    );
  }

  @override
  Future<Chat?> getChatById(String chatId) async {
    Box box = await _openBox();
    ChatModel? chatModel = box.get(chatId);
    return chatModel?.toEntity();
  }

  @override
  Future<List<Chat>> getChats() async {
    Box<ChatModel> box = await _openBox() as Box<ChatModel>;
    return box.values.map((chat) => chat.toEntity()).toList();
  }

  @override
  Future<void> updateChat(Chat chat) async {
    Box<ChatModel> box = await _openBox() as Box<ChatModel>;
    return box.put(
      chat.id,
      ChatModel.fromEntity(chat),
    );
  }
}
