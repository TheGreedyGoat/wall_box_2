import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

/// A button that opens a color picker
class ColorPickerButton extends StatefulWidget {
  /// Thell the opicker what to do with the selected color
  final void Function(Color color) onSubmit;

  /// set an optional initial color value
  final Color? initialColor;

  /// A button that opens a color picker
  const ColorPickerButton({
    super.key,
    required this.onSubmit,
    this.initialColor,
  });

  @override
  State<ColorPickerButton> createState() => _ColorPickerButtonState();
}

class _ColorPickerButtonState extends State<ColorPickerButton> {
  late Color selectedColor;
  @override
  void initState() {
    super.initState();
    selectedColor = widget.initialColor ?? Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            return Dialog(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    IntrinsicHeight(
                      child: IntrinsicWidth(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(width: 1.0),
                          ),
                          child: ColorPicker(
                            pickerColor: Colors.red,
                            onColorChanged: (value) {
                              setState(() {
                                selectedColor = value;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        widget.onSubmit(selectedColor);
                        Navigator.pop(context);
                      },
                      child: Text('OKAY'),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
      icon: Icon(Icons.color_lens),
    );
  }
}
