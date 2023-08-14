import 'package:bloc/bloc.dart';
import 'package:clean_arch_bloc/src/features/feed/domain/use_cases/get_posts.dart';
import 'package:clean_arch_bloc/src/shared/domain/entities/post/post.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'feed_event.dart';
part 'feed_state.dart';

class FeedBloc extends Bloc<FeedEvent, FeedState> {
  final GetPosts _getPosts;

  FeedBloc({
    required GetPosts getPosts,
  })  : assert(getPosts != null),
        _getPosts = getPosts,
        super(FeedLoading()) {
    on<FeedGetsPosts>(_onFeedGetPosts);
  }

  void _onFeedGetPosts(FeedGetsPosts event, Emitter<FeedState> emit) async {
    debugPrint('FeedGetsPosts');
    emit(FeedLoading());
    final posts = await _getPosts.postRepository.getPosts();
    print(posts);
    emit(FeedLoaded(posts: posts));
  }
}
