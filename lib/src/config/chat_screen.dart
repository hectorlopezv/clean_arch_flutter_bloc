import 'package:clean_arch_bloc/src/features/chat/domain/entities/message_entity.dart';
import 'package:clean_arch_bloc/src/features/chat/presentation/blocs/chat/chat_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56),
        child: _CustomAppBar(),
      ),
      body: BlocConsumer<ChatBloc, ChatState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is ChatLoading) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            );
          }
          if (state is ChatLoaded) {
            return SafeArea(
              minimum: EdgeInsets.all(20),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        Message message = state.chat.messages![index];
                        return _MessageCard(
                          message: message,
                          width: size.width,
                          height: size.height,
                        );
                      },
                      itemCount: state.chat.messages!.length,
                      shrinkWrap: true,
                    ),
                  ),
                  _CustomTextFormField(
                    labelText: "Message",
                    textInputType: TextInputType.text,
                    obscureText: false,
                    onChanged: (value) {},
                  ),
                ],
              ),
            );
          }
          return Text("Something went wrong");
        },
      ),
    );
  }
}

class _MessageCard extends StatelessWidget {
  final Message message;
  final double width;
  final double height;

  const _MessageCard(
      {super.key,
      required this.message,
      required this.width,
      required this.height});

  @override
  Widget build(BuildContext context) {
    String userId =
        (context.read<ChatBloc>().state as ChatLoaded).chat.currentUser.id;
    bool isCurrentUser = message.senderId == userId;
    Alignment alignment =
        isCurrentUser ? Alignment.centerLeft : Alignment.centerRight;
    Color color = isCurrentUser
        ? Theme.of(context).colorScheme.primary
        : Theme.of(context).colorScheme.secondary;
    return Align(
      alignment: alignment,
      child: Container(
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.all(10),
        constraints: BoxConstraints(
          maxWidth: width * 0.66,
        ),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(message.text),
      ),
    );
  }
}

class _CustomTextFormField extends StatelessWidget {
  final String labelText;
  final String? errorText;
  final TextInputType textInputType;
  final bool obscureText;
  final void Function(String)? onChanged;

  const _CustomTextFormField(
      {Key? key,
      required this.labelText,
      this.errorText,
      required this.textInputType,
      required this.obscureText,
      this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      keyboardType: textInputType,
      obscureText: obscureText,
      style:
          Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.black),
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          labelText: labelText,
          errorText: errorText,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),
          contentPadding: EdgeInsets.all(20),
          suffixIcon: IconButton(
            icon: Icon(Icons.send),
            onPressed: () {
              context
                  .read<ChatBloc>()
                  .add(ChatUpdateChat(text: controller.text));
              controller.clear();
            },
          )),
    );
  }
}

class _CustomAppBar extends StatelessWidget {
  const _CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Column(
        children: [
          Text(
            "UserName",
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            "online",
            style: Theme.of(context).textTheme.bodySmall!,
          ),
        ],
      ),
      actions: [
        Container(
          margin: EdgeInsets.only(right: 10),
          child: CircleAvatar(
            backgroundColor: Colors.white,
          ),
        )
      ],
    );
  }
}
