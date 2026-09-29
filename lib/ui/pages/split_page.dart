import 'package:flutter/material.dart';
import 'package:wall_box_2/ui/widgets/predecorated/background_card.dart';

class SplitPage extends StatelessWidget {
  final Widget left;
  final Widget right;
  const SplitPage({
    super.key,
    required this.left,
    required this.right,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 500, child: left),
        Expanded(
          child: right,
        ),
      ],
    );
  }
}
