import 'package:clean_arch_bloc/src/features/feed/domain/repositories/post_repository.dart';
import 'package:clean_arch_bloc/src/shared/domain/entities/post/post.dart';
import 'package:clean_arch_bloc/src/shared/domain/usecases/usecases.dart';

class GetPosts implements UseCase<List<Post>, NoParams> {
  final PostRepository postRepository;

  GetPosts(this.postRepository);

  @override
  Future<List<Post>> call(NoParams params) {
    return postRepository.getPosts();
  }

}
