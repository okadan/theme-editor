import 'package:flutter/material.dart';
import 'package:theme_editor/constants.dart' as constants;

class TextFieldsPreview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          decoration: InputDecoration(
            hintText: 'Hint Text',
            helperText: 'Helper Text',
          ),
        ),
        SizedBox(height: constants.previewLayoutGap),
        TextFormField(
          enabled: false,
          initialValue: 'Text (Disabled)',
          decoration: InputDecoration(
            labelText: 'Label Text',
          ),
        ),
        SizedBox(height: constants.previewLayoutGap),
        TextFormField(
          initialValue: 'Text',
          decoration: InputDecoration(
            labelText: 'Label Text',
            errorText: 'Error Text',
          ),
        ),
      ],
    );
  }
}
