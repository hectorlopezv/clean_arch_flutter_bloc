import 'package:clean_arch_bloc/src/features/feed/domain/repositories/post_repository.dart';
import 'package:clean_arch_bloc/src/shared/domain/entities/post/post.dart';
import 'package:clean_arch_bloc/src/shared/domain/usecases/usecases.dart';

class CreatePost implements UseCase<void, CreatePostParams> {
  final PostRepository postRepository;

  CreatePost({required this.postRepository});

  @override
  Future<void> call(CreatePostParams params) {
    print("call me");
    return postRepository.createPost(params.post);
  }
}

class CreatePostParams extends Params {
  final Post post;

  CreatePostParams({required this.post});

  @override
  List<Object?> get props => [post];
}
