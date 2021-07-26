import 'package:flutter/material.dart';
import 'package:theme_editor/editor.dart';
import 'package:theme_editor/source_node.dart';

class ColorEditor extends StatelessWidget {
  ColorEditor(this.name, this.node, this.onChanged);

  final String name;

  final SourceNode<Color> node;

  final ValueChanged<SourceNode<Color>> onChanged;

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
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    border: Border.all(color: Theme.of(context).disabledColor),
                    color: node.value,
                  ),
                  child: SizedBox(width: 22, height: 22),
                ),
                onTap: () => EditorState.push(context, name),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ColorEditorView extends StatelessWidget {
  ColorEditorView(this.node, this.onChanged);

  final SourceNode<Color> node;

  final ValueChanged<SourceNode<Color>> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).disabledColor),
            color: node.value,
          ),
          child: SizedBox(width: 44, height: 44),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(node.buildSource()),
              if (node.value != null)
                InkWell(
                  child: Icon(Icons.clear, size: 14),
                  onTap: () => onChanged(node is SourceNode<MaterialColor>
                    ? SourceNode<MaterialColor>()
                    : SourceNode(),
                  ),
                ),
            ],
          ),
        ),
        Expanded(
          child: node is SourceNode<MaterialColor>
            ? _MaterialColorPicker(node as SourceNode<MaterialColor>, onChanged)
            : _ColorPicker(node, onChanged),
        ),
      ],
    );
  }
}

class _ColorPicker extends StatelessWidget {
  _ColorPicker(this.node, this.onChanged);

  final SourceNode<Color> node;

  final ValueChanged<SourceNode<Color>> onChanged;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 16,
      children: colorsOptions.map((e) => e.value == null
        ? SizedBox.shrink()
        : _ColorTile<Color>(e, onChanged, e == node),
      ).toList(),
    );
  }
}

class _MaterialColorPicker extends StatelessWidget {
  _MaterialColorPicker(this.node, this.onChanged);

  final SourceNode<MaterialColor> node;

  final ValueChanged<SourceNode<MaterialColor>> onChanged;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 16,
      children: colorsMaterialOptions.map((e) =>
        _ColorTile<MaterialColor>(e, onChanged, e == node)).toList(),
    );
  }
}

class _ColorTile<T extends Color> extends StatelessWidget {
  _ColorTile(this.node, this.onChanged, this.selected);

  final SourceNode<T> node;

  final ValueChanged<SourceNode<T>> onChanged;

  final bool selected;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        margin: EdgeInsets.all(0.5),
        decoration: BoxDecoration(
          shape: selected ? BoxShape.circle : BoxShape.rectangle,
          border: Border.all(color: Theme.of(context).disabledColor),
          color: node.value,
        ),
      ),
      onTap: () => onChanged(selected ? SourceNode<T>() : node),
    );
  }
}
