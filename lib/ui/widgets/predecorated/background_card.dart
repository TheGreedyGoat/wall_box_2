import 'package:flutter/material.dart';

class BackgroundCard extends StatelessWidget {
  final Widget child;
  const BackgroundCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.primaryContainer,
      child: child,
    );
  }
}
