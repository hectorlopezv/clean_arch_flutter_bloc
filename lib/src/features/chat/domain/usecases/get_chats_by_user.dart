import 'package:clean_arch_bloc/src/features/chat/domain/entities/chat_entity.dart';
import 'package:clean_arch_bloc/src/features/chat/domain/repositories/chat_repository.dart';
import 'package:clean_arch_bloc/src/shared/domain/usecases/usecases.dart';

class GetChatByUser implements UseCase<List<Chat>, GetChatByUserParams> {
  final ChatRepository chatRepository;

  GetChatByUser(this.chatRepository);

  @override
  Future<List<Chat>> call(GetChatByUserParams params) {
    return chatRepository.getChatsByUser(params.userId);
  }
}

class GetChatByUserParams extends Params {
  final String userId;

  GetChatByUserParams({required this.userId});

  @override
  List<Object?> get props => [userId];
}
