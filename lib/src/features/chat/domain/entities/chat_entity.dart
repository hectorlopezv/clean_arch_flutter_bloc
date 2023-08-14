import 'package:clean_arch_bloc/src/features/chat/domain/entities/message_entity.dart';
import 'package:clean_arch_bloc/src/shared/domain/entities/user/user_entity.dart';
import 'package:equatable/equatable.dart';

class Chat extends Equatable {
  final String id;
  final User currentUser;
  final User otherUser;
  final List<Message>? messages;

  Chat({
    required this.id,
    required this.currentUser,
    required this.otherUser,
    this.messages = const <Message>[],
  });

  Chat copyWith({
    String? id,
    User? currentUser,
    User? otherUser,
    List<Message>? messages,
  }) {
    return Chat(
      id: id ?? this.id,
      currentUser: currentUser ?? this.currentUser,
      otherUser: otherUser ?? this.otherUser,
      messages: messages ?? this.messages,
    );
  }

  @override
  List<Object?> get props => [id, currentUser, otherUser, messages];
}
