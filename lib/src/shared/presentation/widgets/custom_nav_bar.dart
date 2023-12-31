import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomNavBar extends StatelessWidget {
  const CustomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      notchMargin: 10,
      color: Colors.black,
      child: SizedBox(
        height: 75,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () {
                context.goNamed("feed");
              },
              iconSize: 30,
              icon: Icon(Icons.home),
            ),
            IconButton(
              onPressed: () {
                context.goNamed("discover");
              },
              iconSize: 30,
              icon: Icon(Icons.search),
            ),
            IconButton(
              onPressed: () {
                print("add content");
                context.goNamed("add-content");
              },
              iconSize: 30,
              icon: Icon(Icons.add_circle),
            ),
            IconButton(
              onPressed: () {
                context.goNamed("chats");
              },
              iconSize: 30,
              icon: Icon(Icons.message),
            ),
            IconButton(
              onPressed: () async {
                context.goNamed("manage-content");
              },
              iconSize: 30,
              icon: Icon(Icons.person),
            ),
          ],
        ),
      ),
    );
  }
}
