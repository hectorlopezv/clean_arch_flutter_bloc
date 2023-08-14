import 'package:clean_arch_bloc/src/features/feed/presentation/blocs/feed/feed_bloc.dart';
import 'package:clean_arch_bloc/src/shared/presentation/widgets/custom_nav_bar.dart';
import 'package:clean_arch_bloc/src/shared/presentation/widgets/custom_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomNavBar(),
      body: BlocBuilder<FeedBloc, FeedState>(
        builder: (context, state) {
          if (state is FeedLoading) {
            return SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
            );
          }
          if (state is FeedLoaded) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                addAutomaticKeepAlives: true,
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) {
                  print("posts");
                  print(state.posts[index]);
                  return CustomVideoPlayer(
                    key: UniqueKey(),
                    assetPath: state.posts[index].assetpath,
                    caption: state.posts[index].caption,
                    username: state.posts[index].user.username.value,
                  );
                },
                itemCount: state.posts.length,
              ),
            );
          } else {
            return const Center(
              child: Text('Something went wrong!'),
            );
          }
        },
      ),
    );
  }
}
