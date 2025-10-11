import 'package:flutter/material.dart';

class EmptyState extends StatelessWidget {
  final String text;
  const EmptyState(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
          child: Text(text,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: Colors.black54))),
    );
  }
}
