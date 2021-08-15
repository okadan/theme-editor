import 'package:flutter/material.dart';
import 'package:theme_editor/editor.dart';
import 'package:theme_editor/editor_children.dart';
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

class SelectableChildrenEditor<T> extends StatefulWidget {
  SelectableChildrenEditor(this.path, this.node, this.options);

  final Iterable<String> path;

  final SourceNode<T> node;

  final Iterable<SourceNode<T>> options;

  @override
  State<StatefulWidget> createState() => _SelectableChildrenEditorState<T>();
}

class _SelectableChildrenEditorState<T> extends State<SelectableChildrenEditor<T>> {
  late Iterable<SourceNode<T>> options;

  @override
  void initState() {
    super.initState();
    options = widget.options.toList()
      ..[widget.options.toList().indexWhere((e) => e.source == widget.node.source)] = widget.node;
  }

  @override
  void didUpdateWidget(SelectableChildrenEditor<T> old) {
    super.didUpdateWidget(old);
    options = widget.options.toList()
      ..[widget.options.toList().indexWhere((e) => e.source == widget.node.source)] = widget.node;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text('Select Value'),
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
                  SizedBox(width: 22, height: 22, child: PopupMenuButton<SourceNode<T>>(
                    tooltip: 'Select value',
                    icon: Icon(Icons.arrow_drop_down, size: 20),
                    padding: EdgeInsets.zero,
                    itemBuilder: (context) => options.map((e) => PopupMenuItem<SourceNode<T>>(
                      value: e,
                      child: Text(e.source.isEmpty ? 'null' : e.source),
                    )).toList(),
                    onSelected: (value) => value == widget.node
                      ? null
                      : Editor.of(context).onChanged<T>(widget.path, value),
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

final Iterable<SourceNode<bool>> boolOptions = [
  SourceNode(),
  SourceNode('true'),
  SourceNode('false'),
];

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

final Iterable<SourceNode<ColorScheme>> colorSchemeOptions = [
  SourceNode(),
  colorSchemeLightNode,
  colorSchemeDarkNode,
  colorSchemeFromSwatchNode,
];

final Iterable<SourceNode<AppBarTheme>> appBarThemeOptions = [
  SourceNode(),
  appBarThemeNode,
];

final Iterable<SourceNode<TabBarTheme>> tabBarThemeOptions = [
  SourceNode(),
  tabBarThemeNode,
];

final Iterable<SourceNode<BottomNavigationBarThemeData>> bottomNavigationBarThemeDataOptions = [
  SourceNode(),
  bottomNavigationBarThemeDataNode,
];

final Iterable<SourceNode<SliderThemeData>> sliderThemeDataOptions = [
  SourceNode(),
  sliderThemeDataNode,
];

final Iterable<SourceNode<ElevatedButtonThemeData>> elevatedButtonThemeDataOptions = [
  SourceNode(),
  elevatedButtonThemeDataNode,
];

final Iterable<SourceNode<OutlinedButtonThemeData>> outlinedButtonThemeDataOptions = [
  SourceNode(),
  outlinedButtonThemeDataNode,
];

final Iterable<SourceNode<TextButtonThemeData>> textButtonThemeDataOptions = [
  SourceNode(),
  textButtonThemeDataNode,
];

final Iterable<SourceNode<ButtonStyle>> buttonStyleOptions = [
  SourceNode(),
  elevatedButtonStyleFromNode,
  outlinedButtonStyleFromNode,
  textButtonStyleFromNode,
];
