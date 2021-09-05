import 'package:flutter/material.dart';
import 'package:theme_editor/constants.dart' as constants;

class ButtonsPreview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _ElevatedButtonPreview(),
        SizedBox(height: constants.previewLayoutGap),
        _OutlinedButtonPreview(),
        SizedBox(height: constants.previewLayoutGap),
        _TextButtonPreview(),
        SizedBox(height: constants.previewLayoutGap),
        _ToggleButtonsPreview(),
        SizedBox(height: constants.previewLayoutGap),
        _FloatingActionButtonPreview(),
      ],
    );
  }
}

class _ElevatedButtonPreview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Align(
            child: ElevatedButton(
              child: Text('BUTTON'),
              onPressed: () {},
            ),
          ),
        ),
        SizedBox(width: constants.previewLayoutGap),
        Expanded(
          child: Align(
            child: ElevatedButton(
              child: Text('BUTTON'),
              onPressed: null,
            ),
          ),
        ),
      ],
    );
  }
}

class _OutlinedButtonPreview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Align(
            child: OutlinedButton(
              child: Text('BUTTON'),
              onPressed: () {},
            ),
          ),
        ),
        SizedBox(width: constants.previewLayoutGap),
        Expanded(
          child: Align(
            child: OutlinedButton(
              child: Text('BUTTON'),
              onPressed: null,
            ),
          ),
        ),
      ],
    );
  }
}

class _TextButtonPreview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Align(
            child: TextButton(
              child: Text('BUTTON'),
              onPressed: () {},
            ),
          ),
        ),
        SizedBox(width: constants.previewLayoutGap),
        Expanded(
          child: Align(
            child: TextButton(
              child: Text('BUTTON'),
              onPressed: null,
            ),
          ),
        ),
      ],
    );
  }
}

class _ToggleButtonsPreview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Align(
            child: ToggleButtons(
              children: [Icon(Icons.star), Icon(Icons.star)],
              isSelected: [true, false],
              onPressed: (_) {},
            ),
          ),
        ),
        Expanded(
          child: Align(
            child: ToggleButtons(
              children: [Icon(Icons.star), Icon(Icons.star)],
              isSelected: [true, false],
              onPressed: null,
            ),
          ),
        ),
      ],
    );
  }
}

class _FloatingActionButtonPreview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Align(
            child: FloatingActionButton(
              child: Icon(Icons.star),
              onPressed: () {},
            ),
          ),
        ),
        SizedBox(width: constants.previewLayoutGap),
        Expanded(
          child: Align(
            child: FloatingActionButton.extended(
              label: Text('BUTTON'),
              icon: Icon(Icons.star),
              onPressed: () {},
            ),
          ),
        ),
      ],
    );
  }
}
