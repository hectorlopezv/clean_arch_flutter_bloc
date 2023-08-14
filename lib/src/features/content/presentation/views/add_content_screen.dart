import 'dart:io';

import 'package:clean_arch_bloc/src/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:clean_arch_bloc/src/features/content/presentation/blocs/add_content/add_content_bloc.dart';
import 'package:clean_arch_bloc/src/shared/presentation/widgets/custom_nav_bar.dart';
import 'package:clean_arch_bloc/src/shared/presentation/widgets/custom_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class AddContentScreen extends StatelessWidget {
  const AddContentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Content"),
        backgroundColor: Colors.black,
        leading: BackButton(
          onPressed: () {
            context.goNamed("feed");
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              print("im pressed reset");
              context.read<AddContentCubit>().reset();
            },
            icon: const Icon(Icons.clear),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: BlocConsumer<AddContentCubit, AddContentState>(
        listener: (context, state) {
          if (state.status == AddContentStatus.success) {
            print("success");
            context.goNamed("feed");
          }
        },
        builder: (context, state) {
          if (state.video == null) {
            return Center(
              child: ElevatedButton(
                onPressed: () async {
                  File? video = await _handleVideo();
                  if (video != null) {
                    context.read<AddContentCubit>().videoChanged(video);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                ),
                child: Text(
                  "Select a Video",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            );
          } else if (state.video != null) {
            print("state.video: ${state.video!.path}");
            return Stack(
              fit: StackFit.expand,
              children: [
                CustomVideoPlayer(assetPath: state.video!.path),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Spacer(),
                      ElevatedButton(
                        onPressed: () async {
                          await _addCaption(context);
                        },
                        child: Text("Share video"),
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size.fromHeight(56),
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            );
          }
          return Text("Something went wrong");
        },
      ),
      bottomNavigationBar: CustomNavBar(),
    );
  }
}

Future<dynamic> _addCaption(BuildContext context) {
  return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          color: Colors.white.withAlpha(175),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Add your caption",
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        minLines: 3,
                        maxLines: 3,
                        keyboardType: TextInputType.multiline,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: Colors.black),
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onChanged: (value) => context
                            .read<AddContentCubit>()
                            .captionChanged(value),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () async {
                    try {
                      print("user");
                      print(context.read<AuthBloc>().state.user);
                      context
                          .read<AddContentCubit>()
                          .send_submit(context.read<AuthBloc>().state.user);
                      Navigator.of(context).pop();
                    } catch (e) {
                      print(e);
                    }
                  },
                  child: Text("Share"),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size.fromHeight(56),
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      });
}

Future<File?> _handleVideo() async {
  XFile? uploadVideo =
      await ImagePicker().pickVideo(source: ImageSource.gallery);
  if (uploadVideo == null) {
    return null;
  }
  final directory = await getApplicationDocumentsDirectory();
  final filename = basename(uploadVideo.path);
  final savedVideo =
      await File(uploadVideo.path).copy('${directory.path}/$filename');

  if (savedVideo == null) {
    return null;
  }
  return savedVideo;
  print("savedVideo: $savedVideo");
}
