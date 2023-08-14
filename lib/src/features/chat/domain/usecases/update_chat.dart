import 'package:clean_arch_bloc/src/features/chat/domain/entities/chat_entity.dart';
import 'package:clean_arch_bloc/src/features/chat/domain/repositories/chat_repository.dart';
import 'package:clean_arch_bloc/src/shared/domain/usecases/usecases.dart';

class UpdateChat implements UseCase<List<Chat>, UpdateChatParams> {
  final ChatRepository chatRepository;

  UpdateChat(this.chatRepository);

  @override
  Future<void> call(UpdateChatParams params) {
    return chatRepository.updateChat(params.chat);
  }
}

class UpdateChatParams extends Params {
  final Chat chat;

  UpdateChatParams(this.chat);

  @override
  List<Object?> get props => [chat];
}
