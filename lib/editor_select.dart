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
        Expanded(
          child: Text(name),
        ),
        IntrinsicWidth(
          child: DropdownButtonFormField<SourceNode<T>>(
            value: node,
            items: [SourceNode<T>(), ...options].map((e) => DropdownMenuItem(
              value: e,
              child: Text(e.buildSource().split('.').last),
              onTap: node == e ? null : () => onChanged(e),
            )).toList(),
            onChanged: (_) {},
          ),
        ),
      ],
    );
  }
}
