import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:taskflow_mobile/app/pages/todo/todo_colors.dart';

/// A small centered popup — checkmark + message — that auto-dismisses
/// after a beat. Used for confirmations (e.g. a successful edit, or a
/// successful registration) instead of a bottom SnackBar, so the feedback
/// appears in the center of the screen rather than the edge.
Future<void> showCenteredSuccessDialog(
  BuildContext context, {
  required String message,
  Duration autoDismissAfter = const Duration(milliseconds: 1200),
}) async {
  final dialogFuture = showDialog<void>(
    context: context,
    barrierDismissible: true,
    builder: (dialogContext) => Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withValues(alpha: 0.15),
                blurRadius: 30,
                offset: const Offset(0, 10)),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                gradient: TodoColors.saveGradient,
                shape: BoxShape.circle,
              ),
              child: const Icon(FontAwesomeIcons.check, color: Colors.white, size: 20),
            ),
            const SizedBox(height: 14),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontWeight: FontWeight.w600, fontSize: 14, color: TodoColors.textBody),
            ),
          ],
        ),
      ),
    ),
  );

  Future.delayed(autoDismissAfter, () {
    if (context.mounted) Navigator.of(context, rootNavigator: true).maybePop();
  });

  await dialogFuture;
}
