import 'package:flutter/material.dart';

class ScrollableFillRemainingWidget extends StatelessWidget {
  final bool hasScrollBody;
  final Widget child;

  const ScrollableFillRemainingWidget({
    super.key,
    this.hasScrollBody = false,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
          hasScrollBody: hasScrollBody,
          child: child,
        ),
      ],
    );
  }
}
