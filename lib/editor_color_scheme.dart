import 'package:flutter/material.dart';
import 'package:theme_editor/editor.dart';
import 'package:theme_editor/editor_children.dart';
import 'package:theme_editor/source_node.dart';

class ColorSchemeEditor extends StatefulWidget {
  ColorSchemeEditor(this.path, this.node);

  final Iterable<String> path;

  final SourceNode<ColorScheme> node;

  @override
  State<StatefulWidget> createState() => _ColorSchemeEditorState();
}

class _ColorSchemeEditorState extends State<ColorSchemeEditor> {
  Map<String, SourceNode<ColorScheme>> _nodes = {
    '': SourceNode(),
    colorSchemeFromSwatchNode.source: colorSchemeFromSwatchNode,
    colorSchemeLightNode.source: colorSchemeLightNode,
    colorSchemeDarkNode.source: colorSchemeDarkNode,
  };

  @override
  void initState() {
    super.initState();
    _nodes[widget.node.source] = widget.node;
  }

  @override
  void didUpdateWidget(ColorSchemeEditor old) {
    super.didUpdateWidget(old);
    _nodes[widget.node.source] = widget.node;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text('constructor'),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4),
                      child: Text(
                        widget.node.source.isEmpty ? 'null' : widget.node.source,
                        textAlign: TextAlign.end,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  SizedBox(width: 22, height: 22, child: PopupMenuButton<String>(
                    tooltip: 'Select value',
                    icon: Icon(Icons.arrow_drop_down, size: 20),
                    padding: EdgeInsets.zero,
                    itemBuilder: (context) => _nodes.keys.map((e) => PopupMenuItem<String>(
                      value: e,
                      child: Text(e.isEmpty ? 'null' : e),
                    )).toList(),
                    onSelected: (value) => value == widget.node.source
                      ? null
                      : Editor.of(context).onChanged(widget.path, _nodes[value]!),
                  )),
                ],
              ),
            ),
          ],
        ),
        if (widget.node.source.isNotEmpty)
          Expanded(child: ChildrenEditor<ColorScheme>(widget.path, widget.node)),
      ],
    );
  }
}
