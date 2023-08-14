import 'package:clean_arch_bloc/src/shared/data/models/user_model.dart';
import 'package:clean_arch_bloc/src/shared/domain/entities/post/post.dart';
import 'package:hive/hive.dart';

part 'post_model.g.dart';

@HiveType(typeId: 1)
class PostModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final UserModel userModel;
  @HiveField(2)
  final String caption;
  @HiveField(3)
  final String assetPath;

  PostModel({
    required this.id,
    required this.userModel,
    required this.caption,
    required this.assetPath,
  });

  factory PostModel.fromJson(
      Map<String, dynamic> post, Map<String, dynamic> user) {
    return PostModel(
      id: post['id'],
      userModel: UserModel.fromJson(user),
      caption: post['caption'],
      assetPath: post['assetPath'],
    );
  }

  factory PostModel.fromEntity(Post post) {
    return PostModel(
      id: post.id,
      userModel: UserModel.fromEntity(post.user),
      caption: post.caption,
      assetPath: post.assetpath,
    );
  }

  Post toEntity() {
    return Post(
      id: id,
      user: userModel.toEntity(),
      caption: caption,
      assetpath: assetPath,
    );
  }
}
