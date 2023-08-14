import 'package:bloc/bloc.dart';
import 'package:clean_arch_bloc/src/features/chat/domain/entities/chat_entity.dart';
import 'package:clean_arch_bloc/src/features/chat/domain/usecases/get_chats_by_user.dart';
import 'package:equatable/equatable.dart';

part 'chat_list_event.dart';
part 'chat_list_state.dart';

class ChatListBloc extends Bloc<ChatListEvent, ChatListState> {
  final GetChatByUser _getChatByUser;

  ChatListBloc({required GetChatByUser getChatByUser})
      : _getChatByUser = getChatByUser,
        super(ChatListLoading()) {
    on<ChatGetChats>(_onChatGetChats);
  }

  _onChatGetChats(ChatGetChats event, Emitter<ChatListState> emit) async {
    List<Chat> chats = await _getChatByUser(
      GetChatByUserParams(userId: event.userId),
    );
    chats.map((chat) {
      chat.messages!.sort(
        (a, b) => a.createdAt!.compareTo(b.createdAt!),
      );
    });
    emit(ChatListLoaded(chats: chats));
  }
}
