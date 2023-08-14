import 'package:clean_arch_bloc/src/features/feed/data/repository/delete_post.dart';
import 'package:clean_arch_bloc/src/features/feed/domain/use_cases/get_posts_by_user.dart';
import 'package:clean_arch_bloc/src/shared/domain/entities/post/post.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'manage_content_event.dart';
part 'manage_content_state.dart';

class ManageContentBloc extends Bloc<ManageContentEvent, ManageContentState> {
  final GetPostsByUser _getPostsByUser;
  final DeletePostById _deletePostById;

  ManageContentBloc(
      {required GetPostsByUser getPostsByUser,
      required DeletePostById deletePostById})
      : _getPostsByUser = getPostsByUser,
        _deletePostById = deletePostById,
        super(ManageContentLoading()) {
    on<ManageContentGetPostsByUser>(_onGetPostsByUser);
    on<ManageContentDeletePost>(_onDeletePost);
  }

  _onGetPostsByUser(ManageContentGetPostsByUser event,
      Emitter<ManageContentState> emit) async {
    emit(ManageContentLoading());
    final posts = await _getPostsByUser(GetPostsByUserParams(event.userId));
    emit(ManageContentLoaded(posts: posts));
  }

  _onDeletePost(
      ManageContentDeletePost event, Emitter<ManageContentState> emit) async {
    if (state is ManageContentLoaded) {
      final state = this.state as ManageContentLoaded;
      await _deletePostById(DeletePostByIdParams(postId: event.post.id));
      final posts =
          state.posts.where((post) => post.id != event.post.id).toList();
      emit(ManageContentLoaded(posts: posts));
    }
  }
}
