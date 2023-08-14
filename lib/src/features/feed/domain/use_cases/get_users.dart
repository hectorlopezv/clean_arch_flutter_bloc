import 'package:clean_arch_bloc/src/features/feed/domain/repositories/user_repository.dart';
import 'package:clean_arch_bloc/src/shared/domain/entities/post/post.dart';
import 'package:clean_arch_bloc/src/shared/domain/entities/user/user_entity.dart';
import 'package:clean_arch_bloc/src/shared/domain/usecases/usecases.dart';

class GetUsers implements UseCase<List<Post>, NoParams> {
  final UserRepository userRepository;

  GetUsers(this.userRepository);

  @override
  Future<List<User>> call(NoParams params) {
    return userRepository.getUsers();
  }
}
