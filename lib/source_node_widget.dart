import 'package:flutter/material.dart';
import 'package:flutter_theme_editor/editor.dart';
import 'package:flutter_theme_editor/editor_children.dart';
import 'package:flutter_theme_editor/editor_color.dart';
import 'package:flutter_theme_editor/editor_select.dart';
import 'package:flutter_theme_editor/source_node.dart';

Widget buildEditorField(BuildContext context, Iterable<String> path, SourceNode node) {
  final onChanged = (SourceNode value) => Editor.of(context).onChanged(path, value);
  if (node is SourceNode<MaterialColor>)
    return ColorEditorField<MaterialColor>(path, node);
  if (node is SourceNode<Color>)
    return ColorEditorField<Color>(path, node);
  if (node is SourceNode<bool>)
    return SelectEditorField<bool>(path, node, onChanged, boolOptions);
  if (node is SourceNode<Brightness>)
    return SelectEditorField<Brightness>(path, node, onChanged, brightnessOptions);
  if (node is SourceNode<VisualDensity>)
    return SelectEditorField<VisualDensity>(path, node, onChanged, visualDensityOptions);
  if (node is SourceNode<ColorScheme>)
    return ChildrenEditorField<ColorScheme>(path, node);
  if (node is SourceNode<AppBarTheme>)
    return ChildrenEditorField<AppBarTheme>(path, node);
  if (node is SourceNode<TabBarTheme>)
    return ChildrenEditorField<TabBarTheme>(path, node);
  if (node is SourceNode<BottomNavigationBarThemeData>)
    return ChildrenEditorField<BottomNavigationBarThemeData>(path, node);
  if (node is SourceNode<SliderThemeData>)
    return ChildrenEditorField<SliderThemeData>(path, node);
  if (node is SourceNode<CheckboxThemeData>)
    return ChildrenEditorField<CheckboxThemeData>(path, node);
  if (node is SourceNode<RadioThemeData>)
    return ChildrenEditorField<RadioThemeData>(path, node);
  if (node is SourceNode<SwitchThemeData>)
    return ChildrenEditorField<SwitchThemeData>(path, node);
  if (node is SourceNode<ElevatedButtonThemeData>)
    return ChildrenEditorField<ElevatedButtonThemeData>(path, node);
  if (node is SourceNode<OutlinedButtonThemeData>)
    return ChildrenEditorField<OutlinedButtonThemeData>(path, node);
  if (node is SourceNode<TextButtonThemeData>)
    return ChildrenEditorField<TextButtonThemeData>(path, node);
  if (node is SourceNode<ButtonStyle>)
    return ChildrenEditorField<ButtonStyle>(path, node);
  if (node is SourceNode<InputDecorationTheme>)
    return ChildrenEditorField(path, node);
  if (node is SourceNode<MaterialStateProperty<Color>>)
    return _MaterialStatePropertyAllColorWrapper(path, node, onChanged).buildEditorField();
  throw('unsupported: path=$path node=$node');
}

Widget buildEditor(BuildContext context, Iterable<String> path, SourceNode node) {
  final onChanged = (SourceNode value) => Editor.of(context).onChanged(path, value);
  if (node is SourceNode<MaterialColor>)
    return ColorEditor<MaterialColor>(path, node, onChanged);
  if (node is SourceNode<Color>)
    return ColorEditor<Color>(path, node, onChanged);
  if (node is SourceNode<ColorScheme>)
    return SelectableChildrenEditor<ColorScheme>(path, node, onChanged, colorSchemeOptions);
  if (node is SourceNode<AppBarTheme>)
    return SelectableChildrenEditor<AppBarTheme>(path, node, onChanged, appBarThemeOptions);
  if (node is SourceNode<TabBarTheme>)
    return SelectableChildrenEditor<TabBarTheme>(path, node, onChanged, tabBarThemeOptions);
  if (node is SourceNode<BottomNavigationBarThemeData>)
    return SelectableChildrenEditor<BottomNavigationBarThemeData>(path, node, onChanged, bottomNavigationBarThemeDataOptions);
  if (node is SourceNode<SliderThemeData>)
    return SelectableChildrenEditor<SliderThemeData>(path, node, onChanged, sliderThemeDataOptions);
  if (node is SourceNode<CheckboxThemeData>)
    return SelectableChildrenEditor<CheckboxThemeData>(path, node, onChanged, checkboxThemeDataOptions);
  if (node is SourceNode<RadioThemeData>)
    return SelectableChildrenEditor<RadioThemeData>(path, node, onChanged, radioThemeDataOptions);
  if (node is SourceNode<SwitchThemeData>)
    return SelectableChildrenEditor<SwitchThemeData>(path, node, onChanged, switchThemeDataOptions);
  if (node is SourceNode<ElevatedButtonThemeData>)
    return SelectableChildrenEditor<ElevatedButtonThemeData>(path, node, onChanged, elevatedButtonThemeDataOptions);
  if (node is SourceNode<OutlinedButtonThemeData>)
    return SelectableChildrenEditor<OutlinedButtonThemeData>(path, node, onChanged, outlinedButtonThemeDataOptions);
  if (node is SourceNode<TextButtonThemeData>)
    return SelectableChildrenEditor<TextButtonThemeData>(path, node, onChanged, textButtonThemeDataOptions);
  if (node is SourceNode<ButtonStyle>)
    return SelectableChildrenEditor<ButtonStyle>(path, node, onChanged, buttonStyleOptions);
  if (node is SourceNode<InputDecorationTheme>)
    return SelectableChildrenEditor(path, node, onChanged, inputDecorationThemeOptions);
  if (node is SourceNode<MaterialStateProperty<Color>>)
    return _MaterialStatePropertyAllColorWrapper(path, node, onChanged).buildEditor();
  throw('unsupported: path=$path node=$node');
}

class _MaterialStatePropertyAllColorWrapper {
  _MaterialStatePropertyAllColorWrapper(this.path, this.node, this.onChanged);

  final Iterable<String> path;

  final SourceNode<MaterialStateProperty<Color>> node;

  final ValueChanged<SourceNode<MaterialStateProperty<Color>>> onChanged;

  static const source = 'MaterialStateProperty.all<Color>';

  static const childIdentifier = '_!#value';

  SourceNode<Color> get childNode =>
    node.children[childIdentifier] as SourceNode<Color>? ?? SourceNode();

  Widget buildEditorField() {
    return ColorEditorField<Color>(path, childNode);
  }

  Widget buildEditor() {
    return ColorEditor<Color>(path, childNode, (value) =>
      onChanged(value.source.isEmpty
        ? SourceNode()
        : SourceNode.raw(source, MaterialStateProperty.all<Color>(value.value!), {childIdentifier: value}),
      ),
    );
  }
}
