import 'package:flutter/material.dart';
import 'package:wall_box_2/ui/decorators/text_field_decoration.dart';
import 'package:wall_box_2/ui/language/language.dart';

class CustomerContact extends StatelessWidget {
  const CustomerContact({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 8.0,
      children: [
        TextField(
          decoration: textFieldDecoration.copyWith(
            label: Text(currentLanguage.email),
          ),
        ),
        TextField(
          decoration: textFieldDecoration.copyWith(
            label: Text(currentLanguage.phone),
          ),
        ),
        TextField(
          decoration: textFieldDecoration.copyWith(
            label: Text(currentLanguage.mobile),
          ),
        ),
        TextField(
          decoration: textFieldDecoration.copyWith(
            label: Text(currentLanguage.fax),
          ),
        ),
        TextField(
          decoration: textFieldDecoration.copyWith(
            label: Text(currentLanguage.website),
          ),
        ),
      ],
    );
  }
}
