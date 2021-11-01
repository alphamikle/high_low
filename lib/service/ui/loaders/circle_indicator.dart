import 'package:flutter/material.dart';

class CircleIndicator extends StatelessWidget {
  const CircleIndicator({
    required this.color,
    this.visible = true,
    Key? key,
  }) : super(key: key);

  final Color color;
  final bool visible;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20,
      width: 20,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 250),
        child: visible
            ? CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(color),
                strokeWidth: 2.5,
              )
            : const SizedBox(),
      ),
    );
  }
}
