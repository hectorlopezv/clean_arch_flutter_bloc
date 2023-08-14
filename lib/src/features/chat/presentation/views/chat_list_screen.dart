import 'package:clean_arch_bloc/src/features/chat/domain/entities/chat_entity.dart';
import 'package:clean_arch_bloc/src/features/chat/presentation/blocs/chat_list/chat_list_bloc.dart';
import 'package:clean_arch_bloc/src/shared/presentation/widgets/custom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chats"),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      bottomNavigationBar: CustomNavBar(),
      body: BlocBuilder<ChatListBloc, ChatListState>(
        builder: (context, state) {
          if (state is ChatListLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is ChatListLoaded) {
            return ListView.builder(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return _Chat(
                  chat: state.chats[index],
                );
              },
              itemCount: state.chats.length,
            );
          }
          return Text("Something went wrong");
        },
      ),
    );
  }
}

class _Chat extends StatelessWidget {
  final Chat chat;

  const _Chat({super.key, required this.chat});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 30,
        backgroundColor: Colors.white,
        backgroundImage: AssetImage(chat.otherUser.imagePath!),
      ),
    );
  }
}
