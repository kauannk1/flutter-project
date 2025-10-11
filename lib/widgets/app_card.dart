import 'package:flutter/material.dart';

class AppCard extends StatelessWidget {
  final String title;
  final Widget child;
  final IconData? icon;
  const AppCard(
      {super.key, required this.title, required this.child, this.icon});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            if (icon != null)
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.all(8),
                child: Icon(icon),
              ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.w600),
              ),
            ),
          ]),
          const SizedBox(height: 12),
          child,
        ]),
      ),
    );
  }
}
