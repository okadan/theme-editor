import 'package:flutter/material.dart';
import 'package:theme_editor/editor.dart';
import 'package:theme_editor/source_node.dart';

class ChildrenEditor<T> extends StatelessWidget {
  ChildrenEditor(this.name, this.node, this.onChanged);

  final String name;

  final SourceNode<T> node;

  final ValueChanged<SourceNode<T>> onChanged;

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
                  child: Text(node.buildSource(), textAlign: TextAlign.end, overflow: TextOverflow.ellipsis),
                ),
              ),
              InkWell(
                child: Text('Edit', style: TextStyle(color: Theme.of(context).accentColor)),
                onTap: () => EditorState.push(context, name),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ChildrenEditorView<T> extends StatelessWidget {
  ChildrenEditorView(this.node, this.onChanged);

  final SourceNode<T> node;

  final ValueChanged<SourceNode<T>> onChanged;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: node.children.keys.map((e) => ConstrainedBox(
        constraints: BoxConstraints(minHeight: 26),
        child: buildEditor(
          e,
          node,
          (value) => onChanged(value as SourceNode<T>),
        ),
      )).toList(),
    );
  }
}
