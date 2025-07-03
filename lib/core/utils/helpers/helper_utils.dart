import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class HelperUtils {
  static showToast({
    required BuildContext context,
    required String headingTitle,
    String description = '',
    required Color backgroundColor,
  }) {
    return toastification.show(
      context: context,
      type: ToastificationType.success,
      style: ToastificationStyle.flat,
      autoCloseDuration: const Duration(seconds: 10),
      title: Text(headingTitle),

      description: Text(description),
    );
  }
}
