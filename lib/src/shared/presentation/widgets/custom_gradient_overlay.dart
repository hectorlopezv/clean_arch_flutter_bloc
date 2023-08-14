import 'package:flutter/material.dart';

class CustomGradientOverLay extends StatelessWidget {
  final List<double> stops;
  final List<Color> colors;

  const CustomGradientOverLay({
    super.key,
    this.colors = const [
      Colors.black,
      Colors.transparent,
      Colors.transparent,
      Colors.black
    ],
    this.stops = const [0.0, 0.2, 0.8, 1.0],
  });

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: stops,
            colors: colors,
          ),
        ),
      ),
    );
  }
}
