import 'package:flutter/material.dart';

class RoundedCard extends StatelessWidget {
  final double radius;
  final double elevation;
  final double margin;
  final Color? color;
  final Widget child;

  const RoundedCard(
      {this.radius = 8.0,
      this.elevation = 1,
      this.margin = 0,
      this.color,
      required this.child,
      super.key});

  @override
  Widget build(BuildContext context) => Card(
        elevation: elevation,
        margin: EdgeInsets.all(margin),
        color: color,
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(radius))),
        child: child,
      );
}
