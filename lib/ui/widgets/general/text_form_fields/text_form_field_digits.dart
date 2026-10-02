import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wall_box_2/ui/decorators/text_field_decoration.dart';

class MyTextFormField<T> extends StatefulWidget {
  final T? initialValue;
  final String? Function(T? value)? serializer;
  final T? Function(String? text) parser;
  final void Function(T? value) onChanged;
  final String? label;
  final String? errorText;
  final List<TextInputFormatter>? formatters;

  MyTextFormField({
    super.key,
    this.initialValue,
    this.serializer,
    required this.parser,
    required this.onChanged,
    this.label,
    this.errorText,
    this.formatters,
  });

  static MyTextFormField<int> digits({
    int? initialValue,
    required void Function(int? value) onChanged,
    String? label,
    String? errorText,
  }) {
    return MyTextFormField<int>(
      initialValue: initialValue,
      serializer: (int? value) {
        return value?.toString();
      },
      parser: (text) => int.tryParse(text ?? ''),
      onChanged: onChanged,
      label: label,
      errorText: errorText,
      formatters: [FilteringTextInputFormatter.digitsOnly],
    );
  }

  static MyTextFormField<String> text({
    String? initialValue,
    required void Function(String? value) onChanged,
    String? label,
    String? errorText,
    List<TextInputFormatter>? formatters,
  }) {
    return MyTextFormField<String>(
      initialValue: initialValue,
      serializer: (value) => value,
      parser: (text) => text,
      onChanged: onChanged,
      label: label,
      errorText: errorText,
      formatters: formatters,
    );
  }

  @override
  State<MyTextFormField<T>> createState() => _MyTextFormFieldState<T>();
}

class _MyTextFormFieldState<T> extends State<MyTextFormField<T>> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: textFieldDecoration.copyWith(
        label: widget.label != null ? Text(widget.label!) : null,
        errorText: widget.errorText,
      ),
      initialValue: serialize(widget.initialValue),
      onChanged: (text) => widget.onChanged(parse(text)),
    );
  }

  T? parse(String? text) => widget.parser(text);

  String? serialize(T? value) {
    if (value == null) return null;
    if (widget.serializer == null) return value.toString();
    return widget.serializer!.call(value);
  }
}
