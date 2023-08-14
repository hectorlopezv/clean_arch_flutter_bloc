import 'package:clean_arch_bloc/src/features/content/presentation/views/custom_user_information.dart';
import 'package:clean_arch_bloc/src/shared/domain/entities/post/post.dart';
import 'package:clean_arch_bloc/src/shared/domain/entities/user/user_entity.dart';
import 'package:clean_arch_bloc/src/shared/presentation/widgets/custom_video_player.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ManageContentScreen extends StatelessWidget {
  const ManageContentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final User user = User.empty;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          user.username.value,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        backgroundColor: Colors.black,
        leading: BackButton(
          onPressed: () {
            context.goNamed("feed");
          },
        ),
      ),
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxScrolled) => [
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        CustomerUserInformation(user: user),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFFFF006E),
                                fixedSize: Size(150, 50),
                              ),
                              onPressed: () {
                                context.goNamed("add-content");
                              },
                              child: Text(
                                "Add Video",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFFFF006E),
                                fixedSize: Size(150, 50),
                              ),
                              onPressed: () {},
                              child: Text(
                                "Update Picture",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        TabBar(
                          indicatorColor: Colors.white,
                          tabs: [
                            Tab(
                              icon: Icon(Icons.grid_view_rounded),
                            ),
                            Tab(
                              icon: Icon(Icons.favorite),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
            body: TabBarView(
              children: [
                GridView.builder(
                    itemCount: 9,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 9 / 16,
                    ),
                    itemBuilder: (context, index) {
                      Post post = Post(
                        id: 'id',
                        user: user,
                        caption: 'test',
                        assetpath: 'assets/videos/video_1.mp4',
                      );
                      return CustomVideoPlayer(assetPath: post.assetpath);
                    }),
                Container(
                  child: Center(
                    child: Text("Content"),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
