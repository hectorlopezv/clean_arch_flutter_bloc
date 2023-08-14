import 'package:clean_arch_bloc/src/features/feed/presentation/blocs/discover/discover_bloc.dart';
import 'package:clean_arch_bloc/src/shared/domain/entities/user/user_entity.dart';
import 'package:clean_arch_bloc/src/shared/presentation/widgets/custom_gradient_overlay.dart';
import 'package:clean_arch_bloc/src/shared/presentation/widgets/custom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const CustomNavBar(),
      body: BlocBuilder<DiscoverBloc, DiscoverState>(
        builder: (context, state) {
          if (state is DiscoverLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is DiscoverLoaded) {
            print("users");
            print(state.users);
            return MasonryGridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              itemCount: state.users.length,
              itemBuilder: (context, index) {
                User user = state.users[index];
                return _DiscoverUserCard(user: user, index: index);
              },
            );
          }
          return Text("Something went wrong");
        },
      ),
    );
  }
}

class _DiscoverUserCard extends StatelessWidget {
  final int index;

  const _DiscoverUserCard({super.key, required this.user, required this.index});

  final User user;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: index == 0 ? 250 : 300,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: user.imagePath == null
                  ? AssetImage('assets/images_1.jpg')
                  : AssetImage(user.imagePath!),
            ),
          ),
        ),
        CustomGradientOverLay(
          stops: [0.4, 1],
          colors: [Colors.transparent, Colors.black],
        ),
        Positioned(
          left: 10,
          bottom: 10,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundImage:
                user.imagePath == null ? null : AssetImage(user.imagePath!),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "${user.username.value}",
                style: Theme
                    .of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
