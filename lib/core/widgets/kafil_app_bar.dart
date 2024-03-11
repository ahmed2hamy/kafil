import 'package:flutter/material.dart';

class KafilAppBar {
  KafilAppBar._();

  static AppBar appBar(
    BuildContext context, {
    String? title,
    List<Widget>? actions,
  }) {
    return AppBar(
      title: title != null ? Text(title) : null,
      centerTitle: false,
      actions: actions,
    );
  }
}
