import 'package:clean_arch_bloc/src/shared/presentation/widgets/custom_gradient_overlay.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class CustomVideoPlayer extends StatefulWidget {
  final String assetPath;
  final String? caption;
  final String? username;

  const CustomVideoPlayer(
      {super.key, required this.assetPath, this.caption, this.username});

  @override
  State<CustomVideoPlayer> createState() => _CustomVideoPlayerState();
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    _controller = VideoPlayerController.asset(widget.assetPath);
    super.initState();
    _controller.initialize().then((_) {
      setState(() {});
    });
    _controller.setLooping(true);
    _controller.play();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_controller.value.isInitialized) {
      return const SizedBox();
    }
    return GestureDetector(
      onTap: () {
        setState(() {
          if (_controller.value.isPlaying) {
            _controller.pause();
          } else {
            _controller.play();
          }
        });
      },
      child: AspectRatio(
        aspectRatio: _controller.value.aspectRatio,
        child: Stack(
          children: [
            VideoPlayer(_controller),
            const CustomGradientOverLay(),
            (widget.caption == null)
                ? const SizedBox()
                : VideoCaption(
                    username: widget.username,
                    caption: widget.caption,
                  ),
          ],
        ),
      ),
    );
    return Container();
  }
}

class VideoCaption extends StatelessWidget {
  final String? username;
  final String? caption;

  const VideoCaption({super.key, this.username, this.caption});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        height: 125,
        width: MediaQuery.of(context).size.width * 0.75,
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              username ?? '',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            SizedBox(height: 5),
            Text(
              caption ?? '',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
