import 'package:clean_arch_bloc/src/shared/domain/entities/user/user_entity.dart';
import 'package:equatable/equatable.dart';

class Post extends Equatable {
  final String id;
  final User user;
  final String caption;
  final String assetpath;

  Post({
    required this.id,
    required this.user,
    required this.caption,
    required this.assetpath,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [id, user, caption, assetpath];
}
