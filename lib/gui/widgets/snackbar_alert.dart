import 'package:fondos_app/data/models/type_alert_snackbar_model.dart';
import 'package:flutter/material.dart';

enum TypeAlert { success, error }

const Map<String, TypeAlertSnackBar> typeAlert = {
  'success': TypeAlertSnackBar(
    label: 'Success',
    color: Colors.green,
    icon: Icons.check_circle,
  ),
  'error': TypeAlertSnackBar(
    label: 'Error',
    icon: Icons.error,
    color: Colors.red,
  ),
};

class SnackBarFloating {
  static void show(
    BuildContext context,
    String message, {
    IconData? icon,
    Color? backgroundColor,
    TypeAlert type = TypeAlert.success,
    Duration duration = const Duration(seconds: 3),
  }) {
    final typeAlert = _getTypeAlertSnackBar(
      type,
    ).copyWith(icon: icon, label: message, color: backgroundColor);

    final snackBar = SnackBar(
      content: Row(
        children: [
          Icon(typeAlert.icon, size: 22, color: Colors.white),
          const SizedBox(width: 10),
          Text(typeAlert.label),
        ],
      ),
      duration: duration,
      backgroundColor: typeAlert.color,
      behavior: SnackBarBehavior.floating,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static TypeAlertSnackBar _getTypeAlertSnackBar(TypeAlert type) {
    switch (type) {
      case TypeAlert.error:
        return typeAlert['error']!;
      default:
        return typeAlert['success']!;
    }
  }
}
