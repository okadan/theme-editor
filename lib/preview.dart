import 'package:flutter/material.dart';
import 'package:flutter_theme_editor/constants.dart' as constants;
import 'package:flutter_theme_editor/preview_bars.dart';
import 'package:flutter_theme_editor/preview_buttons.dart';
import 'package:flutter_theme_editor/preview_controls.dart';
import 'package:flutter_theme_editor/preview_text_fields.dart';
import 'package:flutter_theme_editor/source_node.dart';

class Preview extends StatelessWidget {
  Preview(this.node);

  final SourceNode<ThemeData> node;

  @override
  Widget build(BuildContext context) {
    final previews = <Widget>[
      BarsPreview(),
      ButtonsPreview(),
      ControlsPreview(),
      TextFieldsPreview(),
    ];
    return Theme(
      data: node.value ?? ThemeData(),
      child: Builder(
        builder: (context) => ColoredBox(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: SizedBox.expand(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(8),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  const width = 300.0;
                  final maxWidth = constraints.maxWidth;
                  return Wrap(
                    spacing: constants.previewLayoutGap,
                    runSpacing: constants.previewLayoutGap,
                    children: previews.map((e) => SizedBox(
                      width: maxWidth < width * 2 ? maxWidth :
                        maxWidth < width * 3 ? maxWidth / 2 - constants.previewLayoutGap :
                        maxWidth < width * 4 ? maxWidth / 3 - constants.previewLayoutGap:
                        maxWidth / 4 - constants.previewLayoutGap,
                      child: Align(child: e),
                    )).toList(),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
