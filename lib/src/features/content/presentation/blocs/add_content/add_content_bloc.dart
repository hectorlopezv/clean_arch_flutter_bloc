import 'dart:io';

import 'package:clean_arch_bloc/src/features/content/domain/usecases/create_post.dart';
import 'package:clean_arch_bloc/src/shared/domain/entities/post/post.dart';
import 'package:clean_arch_bloc/src/shared/domain/entities/user/user_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

part 'add_content_state.dart';

class AddContentCubit extends Cubit<AddContentState> {
  final CreatePost _createPost;

  AddContentCubit({required CreatePost createPost})
      : _createPost = createPost,
        super(AddContentState.initial());

  void videoChanged(File file) {
    emit(
      state.copyWith(
        video: file,
        status: AddContentStatus.loading,
      ),
    );
  }

  void captionChanged(String cation) {
    emit(
      state.copyWith(
        caption: cation,
        status: AddContentStatus.loading,
      ),
    );
  }

  void send_submit(User user) async {
    print("ADD_CONTENT_SBUMIT_CUBIT");
    try {
      final post = Post(
        id: Uuid().v4(),
        user: user,
        caption: state.caption,
        assetpath: state.video!.path,
      );
      _createPost(CreatePostParams(post: post));
      print("post created");
      emit(
        state.copyWith(
          status: AddContentStatus.success,
        ),
      );
    } catch (e) {
      print("Error_subtmit_add_content_cubit: $e");
      print(e);
    }
  }

  void reset() {
    print("im here");
    emit(AddContentState.initial());
  }
}
