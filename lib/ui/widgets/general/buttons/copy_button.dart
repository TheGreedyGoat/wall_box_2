import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CopyButton extends StatelessWidget {
  final double size;
  final String Function() getData;
  final String dataDescription;
  const CopyButton({
    super.key,
    this.size = 30,
    required this.getData,
    required this.dataDescription,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: size,
      child: IconButton(
        onPressed: () async {
          await Clipboard.setData(
            ClipboardData(text: getData()),
          );
          if (!context.mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              duration: Duration(seconds: 1),
              content: Text('$dataDescription'),
            ),
          );
        },
        icon: Icon(Icons.copy),
        padding: const EdgeInsets.all(0),
        iconSize: size - 5,
        tooltip: '$dataDescription kopieren',
      ),
    );
  }
}
