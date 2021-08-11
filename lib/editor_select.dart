import 'package:flutter/material.dart';
import 'package:theme_editor/editor.dart';
import 'package:theme_editor/source_node.dart';

class SelectEditorField<T> extends StatelessWidget {
  SelectEditorField(this.path, this.node, this.options);

  final Iterable<String> path;

  final SourceNode<T> node;

  final Iterable<SourceNode<T>> options;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(extractName(path.last)),
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4),
                  child: Text(
                    node.buildSource().split('.').last,
                    textAlign: TextAlign.end,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              SizedBox(width: 22, height: 22, child: PopupMenuButton<SourceNode<T>>(
                tooltip: 'Select value',
                icon: Icon(Icons.arrow_drop_down, size: 20),
                padding: EdgeInsets.zero,
                itemBuilder: (context) => options.map((e) => PopupMenuItem<SourceNode<T>>(
                  value: e,
                  child: Text(e.source.isEmpty ? 'null' : e.source.split('.').last),
                )).toList(),
                onSelected: (value) => value == node
                  ? null
                  : Editor.of(context).onChanged<T>(path, value),
              )),
            ],
          ),
        ),
      ],
    );
  }
}

final Iterable<SourceNode<Brightness>> brightnessOptions = [
  SourceNode(),
  SourceNode('Brightness.light'),
  SourceNode('Brightness.dark'),
];

final Iterable<SourceNode<VisualDensity>> visualDensityOptions = [
  SourceNode(),
  SourceNode('VisualDensity.adaptivePlatformDensity'),
  SourceNode('VisualDensity.comfortable'),
  SourceNode('VisualDensity.compact'),
  SourceNode('VisualDensity.standard'),
];
