import 'package:clean_arch_bloc/src/features/feed/domain/repositories/user_repository.dart';
import 'package:clean_arch_bloc/src/shared/domain/entities/post/post.dart';
import 'package:clean_arch_bloc/src/shared/domain/entities/user/user_entity.dart';
import 'package:clean_arch_bloc/src/shared/domain/usecases/usecases.dart';

class GeUserParams extends Params {
  final String userId;

  GeUserParams(this.userId);

  @override
  List<Object?> get props => [userId];
}

class GetUser implements UseCase<List<Post>, GeUserParams> {
  final UserRepository userRepository;

  GetUser(this.userRepository);

  @override
  Future<User> call(GeUserParams params) {
    return userRepository.getUser(params.userId);
  }
}
