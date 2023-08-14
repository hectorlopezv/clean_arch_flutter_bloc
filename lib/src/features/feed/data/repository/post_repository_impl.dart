import 'package:clean_arch_bloc/src/features/feed/data/datasources/local_feed_data_source.dart';
import 'package:clean_arch_bloc/src/features/feed/data/datasources/mock_feed_data_source.dart';
import 'package:clean_arch_bloc/src/features/feed/domain/repositories/post_repository.dart';
import 'package:clean_arch_bloc/src/shared/domain/entities/post/post.dart';

class PostRepositoryImpl implements PostRepository {
  final MockFeedDataSource mockFeedDataSource;
  final LocalFeedDataSource localFeedDataSource;

  PostRepositoryImpl(this.mockFeedDataSource, this.localFeedDataSource);

  @override
  Future<List<Post>> getPosts() async {
    //if not internet connection get data from hive storage
    var lfPosts = await localFeedDataSource.getPosts();
    print("lfPosts: $lfPosts");
    print(lfPosts.length);

    if (lfPosts.isEmpty) {
      var posts = await mockFeedDataSource.getPosts();
      //save data to hive storage
      posts.forEach((post) async {
        await localFeedDataSource.addPost(post);
      });
      return posts;
    }
    return lfPosts;
  }

  @override
  Future<List<Post>> getPostsByUser(String userId) async {
    List<Post> lposts = await localFeedDataSource.getPostsByUser(userId);
    if (lposts.isEmpty) {
      lposts.forEach((post) {
        localFeedDataSource.addPost(post);
      });
      return lposts;
    } else {
      return localFeedDataSource.getPostsByUser(userId);
    }
  }

  @override
  Future<void> createPost(Post post) {
    return localFeedDataSource.addPost(post);
  }

  @override
  Future<void> deletePostById(String postId) {
    //delete the post locally or remote data source
    return localFeedDataSource.deletePostById(postId);
  }
}
