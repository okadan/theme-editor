import 'package:flutter/material.dart';
import 'package:theme_editor/editor.dart';
import 'package:theme_editor/source_node.dart';

class ChildrenEditorField<T> extends StatelessWidget {
  ChildrenEditorField(this.path, this.node);

  final Iterable<String> path;

  final SourceNode<T> node;

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
                    node.buildSource(),
                    textAlign: TextAlign.end,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              InkWell(
                child: Text('Edit', style: TextStyle(color: Theme.of(context).accentColor)),
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
        child: buildEditorField([...path, e.key], e.value),
      )).toList(),
    );
  }
}

class SelectableChildrenEditor<T> extends StatefulWidget {
  SelectableChildrenEditor(this.path, this.node, this.options);

  final Iterable<String> path;

  final SourceNode<T> node;

  final Map<String, SourceNode<T>> options;

  @override
  State<StatefulWidget> createState() => _SelectableChildrenEditorState<T>();
}

class _SelectableChildrenEditorState<T> extends State<SelectableChildrenEditor<T>> {
  late Map<String, SourceNode<T>> options;

  @override
  void initState() {
    super.initState();
    options = Map.of(widget.options);
    options[widget.node.source] = widget.node;
  }

  @override
  void didUpdateWidget(SelectableChildrenEditor<T> old) {
    super.didUpdateWidget(old);
    options[widget.node.source] = widget.node;
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
                    itemBuilder: (context) => options.keys.map((e) => PopupMenuItem<String>(
                      value: e,
                      child: Text(e.isEmpty ? 'null' : e),
                    )).toList(),
                    onSelected: (value) => value == widget.node.source
                      ? null
                      : Editor.of(context).onChanged<T>(widget.path, options[value]!),
                  )),
                ],
              ),
            ),
          ],
        ),
        if (widget.node.source.isNotEmpty)
          Expanded(child: ChildrenEditor<T>(widget.path, widget.node)),
      ],
    );
  }
}

final Map<String, SourceNode<ButtonStyle>> buttonStyleExecutableOptions = Map.unmodifiable(<String, SourceNode<ButtonStyle>>{
  '': SourceNode(),
  elevatedButtonStyleFromNode.source: elevatedButtonStyleFromNode,
  outlinedButtonStyleFromNode.source: outlinedButtonStyleFromNode,
  textButtonStyleFromNode.source: textButtonStyleFromNode,
});

final Map<String, SourceNode<ColorScheme>> colorSchemeExecutableOptions = Map.unmodifiable(<String, SourceNode<ColorScheme>>{
  '': SourceNode(),
  colorSchemeFromSwatchNode.source: colorSchemeFromSwatchNode,
  colorSchemeLightNode.source: colorSchemeLightNode,
  colorSchemeDarkNode.source: colorSchemeDarkNode,
});
