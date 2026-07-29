import 'package:flutter/material.dart';

/// Colors and gradients lifted directly from the web app's App.css so the
/// mobile app carries the same visual identity.
class TodoColors {
  TodoColors._();

  static const primary = Color(0xFF1A4CFF);
  static const primaryLight = Color(0xFF3B7CFF);
  static const green = Color(0xFF26A56B);
  static const red = Color(0xFFE45A6B);
  static const amber = Color(0xFFF39C12);

  static const textDark = Color(0xFF0A1A33);
  static const textBody = Color(0xFF1A2A44);
  static const textMuted = Color(0xFF4A5A72);
  static const textFaint = Color(0xFFAAB8D0);

  static const bgTop = Color(0xFFE8EDFF);
  static const bgBottom = Color(0xFFF8FAFF);

  static const primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primary, primaryLight],
  );

  static const brandTextGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [textDark, primary],
  );

  static const bodyGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [bgTop, bgBottom],
  );

  static const saveGradient = LinearGradient(
    colors: [green, Color(0xFF2ECC71)],
  );

  static const cancelGradient = LinearGradient(
    colors: [red, Color(0xFFFF6B7A)],
  );
}
