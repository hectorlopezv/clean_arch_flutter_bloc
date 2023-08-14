import 'package:clean_arch_bloc/src/shared/domain/entities/user/user_entity.dart';
import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0)
class UserModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String username;
  @HiveField(2)
  final int followers;
  @HiveField(3)
  final int followings;
  @HiveField(4)
  final String? imagePath;

  const UserModel({
    required this.id,
    required this.username,
    this.followers = 0,
    this.followings = 0,
    this.imagePath,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      username: json['username'],
      followers: json['followers'],
      followings: json['followings'],
      imagePath: json['imagePath'],
    );
  }

  factory UserModel.fromEntity(User user) {
    return UserModel(
      id: user.id,
      username: user.username.value,
      followers: user.followers,
      followings: user.following,
      imagePath: user.imagePath,
    );
  }

  User toEntity() {
    return User(
      id: id,
      username: Username.dirty(username),
      followers: followers,
      following: followings,
      imagePath: imagePath,
    );
  }
}
