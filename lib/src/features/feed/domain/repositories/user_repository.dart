import 'package:clean_arch_bloc/src/shared/domain/entities/user/user_entity.dart';

abstract class UserRepository {
  Future<List<User>> getUsers();

  Future<User> getUser(String userId);
}
