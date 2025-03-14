import 'package:flutter/material.dart';

class SpecialDayWidget extends StatelessWidget {
  final String specialDay;

  const SpecialDayWidget({super.key, required this.specialDay});

  @override
  Widget build(BuildContext context) {
    if (specialDay.isEmpty) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary, // Theme-based color
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).colorScheme.secondary,
        ), // Use theme color
      ),
      child: Text(
        specialDay,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.bold,
          color:
              Theme.of(
                context,
              ).colorScheme.onSecondary, // Text color from theme
        ),
      ),
    );
  }
}
