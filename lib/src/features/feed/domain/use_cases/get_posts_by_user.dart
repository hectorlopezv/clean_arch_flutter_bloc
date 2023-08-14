import 'package:clean_arch_bloc/src/features/feed/domain/repositories/post_repository.dart';
import 'package:clean_arch_bloc/src/shared/domain/entities/post/post.dart';
import 'package:clean_arch_bloc/src/shared/domain/usecases/usecases.dart';

class GetPostsByUser implements UseCase<List<Post>, GetPostsByUserParams> {
  final PostRepository postRepository;

  GetPostsByUser(this.postRepository);

  @override
  Future<List<Post>> call(GetPostsByUserParams params) {
    return postRepository.getPostsByUser(params.userId);
  }
}

class GetPostsByUserParams extends Params {
  final String userId;

  GetPostsByUserParams(this.userId);

  @override
  List<Object?> get props => [userId];
}
