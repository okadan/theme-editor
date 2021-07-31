import 'package:flutter/material.dart';
import 'package:theme_editor/source_node.dart';

class SelectEditor<T> extends StatelessWidget {
  SelectEditor(this.name, this.node, this.onChanged, this.options);

  final String name;

  final SourceNode<T> node;

  final ValueChanged<SourceNode<T>> onChanged;

  final Iterable<SourceNode<T>> options;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(name),
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4),
                  child: Text(
                    node.buildSource().split('.').last,
                    textAlign: TextAlign.end,
                  ),
                ),
              ),
              SizedBox(width: 22, height: 22, child: PopupMenuButton<SourceNode<T>>(
                tooltip: 'Select value',
                icon: Icon(Icons.arrow_drop_down, size: 20),
                padding: EdgeInsets.zero,
                itemBuilder: (context) => options.map((e) => PopupMenuItem<SourceNode<T>>(
                  value: e,
                  child: Text(e.buildSource().split('.').last),
                )).toList(),
                onSelected: (value) => value == node ? null : onChanged(value),
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
  SourceNode('Brightness.dark'),
  SourceNode('Brightness.light'),
];
