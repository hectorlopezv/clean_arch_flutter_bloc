import 'package:clean_arch_bloc/src/shared/presentation/widgets/custom_nav_bar.dart';
import 'package:flutter/material.dart';

class DiscoverScreen extends StatelessWidget {
  final String title;

  const DiscoverScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      bottomNavigationBar: const CustomNavBar(),
    );
  }
}