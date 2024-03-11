import 'package:flutter/material.dart';

class CircleIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;

  const CircleIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 24.0,
      height: 24.0,
      child: RawMaterialButton(
        onPressed: onPressed,
        elevation: 2.0,
        fillColor: Colors.white,
        shape: const CircleBorder(),
        child: Icon(
          icon,
          size: 12.0,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}