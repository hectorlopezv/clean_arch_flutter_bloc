import 'package:clean_arch_bloc/src/shared/data/dataSource/post/post_data_source.dart';
import 'package:clean_arch_bloc/src/shared/data/dataSource/user/user_data_source.dart';
import 'package:clean_arch_bloc/src/shared/data/models/post_model.dart';
import 'package:clean_arch_bloc/src/shared/data/models/user_model.dart';
import 'package:clean_arch_bloc/src/shared/domain/entities/post/post.dart';
import 'package:clean_arch_bloc/src/shared/domain/entities/user/user_entity.dart';

abstract class MockFeedDataSource {
  Future<List<Post>> getPosts();

  Future<List<Post>> getPostsByUserId(String userId);

  Future<List<User>> getUsers();

  Future<User> getUserById(String userId);
}

class MockFeedDataSourceImpl implements MockFeedDataSource {
  @override
  Future<List<Post>> getPosts() async {
    await Future.delayed(const Duration(milliseconds: 300), () {});
    var postsRes = posts.map((post) {
      Map<String, dynamic> user = users.where((user) {
        print("user: ${user['id']}");
        print("post: ${post['userId']}");
        return user['id'] == post["userId"];
      }).first;
      print("res $user");
      return PostModel.fromJson(post, user).toEntity();
    }).toList();
    return postsRes;
  }

  @override
  Future<List<Post>> getPostsByUserId(String userId) async {
    await Future.delayed(const Duration(milliseconds: 300), () {});
    var postByUser =
        posts.where((post) => post['userId'] == userId).map((post) {
      Map<String, dynamic> user =
          users.firstWhere((user) => user['id'] == post["userId"]);
      return PostModel.fromJson(post, user).toEntity();
    }).toList();
    return postByUser;
  }

  @override
  Future<User> getUserById(String userId) async {
    await Future.delayed(const Duration(milliseconds: 300), () {});
    Map<String, dynamic> user =
        users.where((user) => user['id'] == userId).first;
    return UserModel.fromJson(user).toEntity();
  }

  @override
  Future<List<User>> getUsers() async {
    await Future.delayed(const Duration(milliseconds: 300), () {});
    var usersRes = users.map((user) {
      return UserModel.fromJson(user).toEntity();
    }).toList();
    return usersRes;
  }
}
