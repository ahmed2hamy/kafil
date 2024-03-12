import 'package:flutter/material.dart';
import 'package:kafil/constants/constants.dart';

class Dialogs {
  Dialogs._();

  static void showMessage(
    BuildContext context, {
    GlobalKey<ScaffoldMessengerState>? key,
    required String? message,
    int duration = 3,
  }) {
    if (key != null) {
      key.currentState
          ?.showSnackBar(_messageSnackBarWidget(message, duration));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        _messageSnackBarWidget(message, duration),
      );
    }
  }

  static SnackBar _messageSnackBarWidget(String? message, int duration) {
    return SnackBar(
      duration: Duration(seconds: duration),
      content: Text(message ?? kUnexpectedErrorString),
    );
  }
}
