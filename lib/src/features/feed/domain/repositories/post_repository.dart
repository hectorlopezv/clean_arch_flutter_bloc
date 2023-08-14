import 'package:clean_arch_bloc/src/shared/domain/entities/post/post.dart';

abstract class PostRepository {
  Future<List<Post>> getPosts();

  Future<List<Post>> getPostsByUser(String userId);

  Future<void> createPost(Post post);
}
