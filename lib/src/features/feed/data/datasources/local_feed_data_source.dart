import 'package:clean_arch_bloc/src/shared/data/models/post_model.dart';
import 'package:clean_arch_bloc/src/shared/domain/entities/post/post.dart';
import 'package:hive/hive.dart';

abstract class LocalFeedDataSource {
  Future<List<Post>> getPosts();

  Future<void> addPost(Post post);

  Future<void> deleteAllPosts();
}

class LocalFeedDataSourceImpl implements LocalFeedDataSource {
  String boxName = "posts";
  Type boxType = PostModel;

  @override
  Future<void> addPost(Post post) async {
    Box box = await _openBox();
    await box.put(post.id, PostModel.fromEntity(post));
  }

  Future<Box> _openBox() {
    return Hive.openBox<PostModel>(boxName);
  }

  @override
  Future<void> deleteAllPosts() async {
    Box box = await _openBox();
    await box.clear();
  }

  @override
  Future<List<Post>> getPosts() async {
    Box<PostModel> box = await _openBox() as Box<PostModel>;
    return box.values
        .toList()
        .map(
          (post) => post.toEntity(),
        )
        .toList();
  }
}
