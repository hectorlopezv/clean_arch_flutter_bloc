import 'package:clean_arch_bloc/src/features/chat/domain/entities/chat_entity.dart';
import 'package:clean_arch_bloc/src/features/chat/domain/entities/message_entity.dart';
import 'package:clean_arch_bloc/src/features/chat/domain/usecases/get_chats_by_id.dart';
import 'package:clean_arch_bloc/src/features/chat/domain/usecases/update_chat.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final GetChatById _getChatById;
  final UpdateChat _updateChat;

  ChatBloc({
    required GetChatById getChatById,
    required UpdateChat updateChat,
  })  : _getChatById = getChatById,
        _updateChat = updateChat,
        super(ChatLoading()) {
    on<ChatGetChat>(_onChatGetChat);
    on<ChatUpdateChat>(_onChatUpdateChat);
  }

  _onChatGetChat(ChatGetChat event, Emitter<ChatState> emit) async {
    print("Start on CHAET getchat");
    print("event.chatId ${event.chatId}");
    print("event.userId ${event.userId}");
    Chat chat = await _getChatById(
      GetChatByIdParams(chatId: event.chatId.toString(), userId: event.userId),
    );
    emit(ChatLoaded(chat: chat));
  }

  _onChatUpdateChat(ChatUpdateChat event, Emitter<ChatState> emit) async {
    print("Start on chget updatechat");
    if (state is ChatLoaded) {
      final state = this.state as ChatLoaded;
      Message message = Message(
        chatId: state.chat.id,
        senderId: state.chat.currentUser.id,
        recipientId: state.chat.otherUser.id,
        text: event.text,
        createdAt: DateTime.now(),
      );
      Chat chat = state.chat.copyWith(
        messages: [...state.chat.messages!, message],
      );
      _updateChat(UpdateChatParams(chat));
      emit(ChatLoaded(chat: chat));
    }
  }
}
