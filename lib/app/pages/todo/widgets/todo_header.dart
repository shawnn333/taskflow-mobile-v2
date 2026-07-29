import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taskflow_mobile/app/pages/todo/todo_colors.dart';

/// Brand row — mirrors .sidebar-brand (icon badge, gradient wordmark, PRO chip).
class TodoBrand extends StatelessWidget {
  const TodoBrand({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(9),
          decoration: BoxDecoration(
            gradient: TodoColors.primaryGradient,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: TodoColors.primary.withValues(alpha: 0.25),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: const Icon(FontAwesomeIcons.solidCircleCheck,
              color: Colors.white, size: 18),
        ),
        const SizedBox(width: 10),
        ShaderMask(
          shaderCallback: (bounds) =>
              TodoColors.brandTextGradient.createShader(bounds),
          child: Text(
            'TaskFlow',
            style: GoogleFonts.inter(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.6,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(width: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
          decoration: BoxDecoration(
            gradient: TodoColors.primaryGradient,
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Text(
            'PRO',
            style: TextStyle(
              color: Colors.white,
              fontSize: 9,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5,
            ),
          ),
        ),
      ],
    );
  }
}

/// Mirrors .todo-header — nav label with pencil icon + task-stats pill.
class TodoHeaderRow extends StatelessWidget {
  const TodoHeaderRow({
    super.key,
    required this.label,
    required this.done,
    required this.total,
    this.trailing,
  });

  final String label;
  final int done;
  final int total;

  /// Optional widget placed after the stats pill (e.g. the logout button)
  /// — laid out inline in the same row instead of floating on top, so it
  /// never overlaps the pill.
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                decoration: BoxDecoration(
                  gradient: TodoColors.primaryGradient,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(FontAwesomeIcons.penToSquare,
                    color: Colors.white, size: 15),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ShaderMask(
                  shaderCallback: (bounds) =>
                      TodoColors.brandTextGradient.createShader(bounds),
                  child: Text(
                    label,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.5,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 10),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
          decoration: BoxDecoration(
            color: TodoColors.primary.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: TodoColors.primary.withValues(alpha: 0.06)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(FontAwesomeIcons.solidCircleCheck,
                  size: 12, color: TodoColors.green),
              const SizedBox(width: 6),
              Text('$done',
                  style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                      color: TodoColors.primary)),
              Text(' / ', style: TextStyle(color: Colors.black.withValues(alpha: 0.2))),
              Text('$total',
                  style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                      color: TodoColors.primary)),
            ],
          ),
        ),
        if (trailing != null) ...[
          const SizedBox(width: 10),
          trailing!,
        ],
      ],
    );
  }
}
