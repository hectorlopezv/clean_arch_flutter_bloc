import 'package:clean_arch_bloc/src/shared/domain/entities/user/user_entity.dart';
import 'package:flutter/material.dart';

class CustomerUserInformation extends StatelessWidget {
  final User user;

  const CustomerUserInformation({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundColor: Colors.white,
          backgroundImage:
              (user.imagePath == null) ? null : AssetImage(user.imagePath!),
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 75),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildUserInfo(
                  context,
                  '${user.followers} Followers',
                ),
                _buildUserInfo(
                  context,
                  '${user.following} Following',
                ),
              ],
            )),
      ],
    );
  }

  Text _buildUserInfo(BuildContext context, String value) {
    return Text(
      value,
      style: Theme.of(context)
          .textTheme
          .titleMedium!
          .copyWith(fontWeight: FontWeight.bold),
    );
  }
}
