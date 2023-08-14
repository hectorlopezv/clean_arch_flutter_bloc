import 'package:clean_arch_bloc/src/features/feed/domain/repositories/post_repository.dart';
import 'package:clean_arch_bloc/src/shared/domain/usecases/usecases.dart';

class DeletePostById implements UseCase<void, DeletePostByIdParams> {
  final PostRepository postRepository;

  DeletePostById(this.postRepository);

  @override
  Future<void> call(params) {
    return postRepository.deletePostById(params.postId);
  }
}

class DeletePostByIdParams extends Params {
  final String postId;

  DeletePostByIdParams({required this.postId});

  @override
  List<Object?> get props => [postId];
}
