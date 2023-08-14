import 'package:clean_arch_bloc/src/features/auth/domain/entities/logged_in_user.dart';
import 'package:clean_arch_bloc/src/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:clean_arch_bloc/src/features/content/presentation/blocs/manage_content/manage_content_bloc.dart';
import 'package:clean_arch_bloc/src/features/content/presentation/views/custom_user_information.dart';
import 'package:clean_arch_bloc/src/shared/presentation/widgets/custom_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ManageContentScreen extends StatelessWidget {
  const ManageContentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    LoggedInUser user = context.read<AuthBloc>().state.user;
    print("aqui esta el user");
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
      body: BlocBuilder<ManageContentBloc, ManageContentState>(
        builder: (context, state) {
          if (state is ManageContentLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is ManageContentLoaded) {
            return DefaultTabController(
              length: 2,
              child: NestedScrollView(
                  headerSliverBuilder: (context, innerBoxScrolled) => [
                        SliverToBoxAdapter(
                          child: Column(
                            children: [
                              CustomerUserInformation(user: user),
                              SizedBox(
                                height: 20,
                              ),
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
                                          .copyWith(
                                              fontWeight: FontWeight.bold),
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
                          itemCount: state.posts.length,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 9 / 16,
                          ),
                          itemBuilder: (context, index) {
                            return InkWell(
                              onDoubleTap: () {
                                context.read<ManageContentBloc>().add(
                                      ManageContentDeletePost(
                                        post: state.posts[index],
                                      ),
                                    );
                              },
                              child: CustomVideoPlayer(
                                  key: UniqueKey(),
                                  assetPath: state.posts[index].assetpath),
                            );
                          }),
                      Container(
                        child: Center(
                          child: Text("Content"),
                        ),
                      ),
                    ],
                  )),
            );
          }
          return Text("Something went wrong");
        },
      ),
    );
  }
}
