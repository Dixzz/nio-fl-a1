import 'package:flutter/material.dart';
import 'package:nio_demo/tools/cards.dart';

class AppbarAction extends StatelessWidget {
  final Widget icon;
  final Function()? onTap;

  const AppbarAction({super.key, required this.icon, this.onTap = null});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.only(top: 48, left: 16),
        child: SizedBox.square(
          dimension: 36,
          child: InkWell(
            onTap: onTap,
            child: RoundedCard(
              radius: 12,
              child: Center(child: icon),
            ),
          ),
        ),
      ),
    );
  }
}
