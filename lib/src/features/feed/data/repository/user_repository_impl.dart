import 'package:clean_arch_bloc/src/features/feed/data/datasources/mock_feed_data_source.dart';
import 'package:clean_arch_bloc/src/features/feed/domain/repositories/user_repository.dart';
import 'package:clean_arch_bloc/src/shared/domain/entities/user/user_entity.dart';

class UserRepositoryImpl implements UserRepository {
  final MockFeedDataSource mockFeedDataSource;

  UserRepositoryImpl({required this.mockFeedDataSource});

  @override
  Future<User> getUser(String userId) {
    return mockFeedDataSource.getUserById(userId);
  }

  @override
  Future<List<User>> getUsers() {
    return mockFeedDataSource.getUsers();
  }
}
