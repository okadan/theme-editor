import 'package:flutter/material.dart';
import 'package:flutter_theme_editor/editor.dart';
import 'package:flutter_theme_editor/source_node.dart';
import 'package:flutter_theme_editor/source_node_widget.dart';

class ChildrenEditorField<T> extends StatelessWidget {
  ChildrenEditorField(this.path, this.node);

  final Iterable<String> path;

  final SourceNode<T> node;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(path.last.split('#').last),
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4),
                  child: Text(
                    node.buildSource(),
                    textAlign: TextAlign.end,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              InkWell(
                child: Text('Edit', style: TextStyle(color: Theme.of(context).colorScheme.secondary)),
                onTap: () => Editor.of(context).push(path.last),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ChildrenEditor<T> extends StatelessWidget {
  ChildrenEditor(this.path, this.node);

  final Iterable<String> path;

  final SourceNode<T> node;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: node.children.entries.map((e) => ConstrainedBox(
        constraints: BoxConstraints(minHeight: 26),
        child: buildEditorField(context, [...path, e.key], e.value),
      )).toList(),
    );
  }
}
