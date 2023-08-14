import 'package:clean_arch_bloc/src/features/chat/domain/entities/chat_entity.dart';
import 'package:clean_arch_bloc/src/features/chat/domain/repositories/chat_repository.dart';
import 'package:clean_arch_bloc/src/shared/domain/usecases/usecases.dart';

class GetChatById implements UseCase<List<Chat>, GetChatByIdParams> {
  final ChatRepository chatRepository;

  GetChatById(this.chatRepository);

  @override
  Future<Chat> call(GetChatByIdParams params) {
    return chatRepository.getChatById(params.userId, params.chatId);
  }
}

class GetChatByIdParams extends Params {
  final String chatId;
  final String userId;

  GetChatByIdParams({required this.chatId, required this.userId});

  @override
  List<Object?> get props => [userId];
}
