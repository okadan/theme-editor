import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:theme_editor/editor_children.dart';
import 'package:theme_editor/editor_color.dart';
import 'package:theme_editor/editor_select.dart';

part 'source_node.g.dart';

class SourceNode<T> {
  SourceNode([this.source = '', this.children = const {}]) : value = _value(source, children);
  final String source;

  final Map<String, SourceNode> children;

  final T? value;

  @override
  int get hashCode => hashValues(source, children);

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType)
      return false;
    return other is SourceNode<T>
      && other.source == source
      && mapEquals(other.children, children);
  }

  SourceNode<T> updateDescendant<S>(String path, SourceNode<S> node) {
    final index = path.indexOf('.');
    if (index < 0) {
      assert(children[path]!.runtimeType == node.runtimeType);
      return SourceNode(source, Map.unmodifiable(Map.of(children)..[path] = node));
    }
    final childIdentifier = path.substring(0, index);
    final childPath = path.substring(index + 1);
    final child = children[childIdentifier]!.updateDescendant(childPath, node);
    return SourceNode(source, Map.unmodifiable(Map.of(children)..[childIdentifier] = child));
  }

  String buildSource([String? identifier]) {
    final symbols = identifier?.split('#').first ?? '';
    final name = identifier?.split('#').last ?? '';
    final label = name.isEmpty || symbols.contains('_') ? '' : '$name:';
    if (children.isEmpty) {
      if (source.isEmpty) return '${label}null';
      return '$label$source';
    } else {
      if (children.entries.any((e) {
        final symbols = e.key.split('#').first;
        return (symbols.contains('!') && source.isEmpty)
          || (!symbols.contains('?') && e.value.source == 'null')
          || (!symbols.contains('?') && !symbols.contains('@') && e.value.value == null);
      })) return '${label}null';
      final entries = children.entries
        .where((e) => e.value.source.isNotEmpty);
      return '$label$source('
        + entries.map((e) => e.value.buildSource(e.key)).join(',')
        + ')';
    }
  }

  static dynamic _value(String source, Map<String, SourceNode> children) {
    if (children.isEmpty) {
      if (source.isEmpty || source == 'null') return null;
      if (num.tryParse(source) != null) return num.parse(source);
      if (_sourceValues.containsKey(source)) return _sourceValues[source];
      throw('unsupported: source=$source');
    } else {
      if (children.entries.any((e) {
        final symbols = e.key.split('#').first;
        return (symbols.contains('!') && source.isEmpty)
          || (!symbols.contains('?') && e.value.source == 'null')
          || (!symbols.contains('?') && !symbols.contains('@') && e.value.value == null);
      })) return null;
      final value = _buildValue(source, children);
      if (value != null) return value;
      throw('unsupported: source=$source children=$children');
    }
  }
}

String extractName(String identifier) {
  return identifier.split('.').map((e) => e.split('#').last).join('.');
}

Widget buildEditorField(Iterable<String> path, SourceNode node) {
  if (node is SourceNode<MaterialColor>)
    return ColorEditorField<MaterialColor>(path, node);
  if (node is SourceNode<Color>)
    return ColorEditorField<Color>(path, node);
  if (node is SourceNode<bool>)
    return SelectEditorField<bool>(path, node, boolOptions);
  if (node is SourceNode<Brightness>)
    return SelectEditorField<Brightness>(path, node, brightnessOptions);
  if (node is SourceNode<VisualDensity>)
    return SelectEditorField<VisualDensity>(path, node, visualDensityOptions);
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
  if (node is SourceNode<ElevatedButtonThemeData>)
    return ChildrenEditorField<ElevatedButtonThemeData>(path, node);
  if (node is SourceNode<OutlinedButtonThemeData>)
    return ChildrenEditorField<OutlinedButtonThemeData>(path, node);
  if (node is SourceNode<TextButtonThemeData>)
    return ChildrenEditorField<TextButtonThemeData>(path, node);
  if (node is SourceNode<ButtonStyle>)
    return ChildrenEditorField<ButtonStyle>(path, node);
  throw('unsupported: path=$path node=$node');
}

Widget buildEditor(Iterable<String> path, SourceNode node) {
  if (node is SourceNode<MaterialColor>)
    return ColorEditor<MaterialColor>(path, node);
  if (node is SourceNode<Color>)
    return ColorEditor<Color>(path, node);
  if (node is SourceNode<ColorScheme>)
    return SelectableChildrenEditor<ColorScheme>(path, node, colorSchemeOptions);
  if (node is SourceNode<AppBarTheme>)
    return SelectableChildrenEditor<AppBarTheme>(path, node, appBarThemeOptions);
  if (node is SourceNode<TabBarTheme>)
    return SelectableChildrenEditor<TabBarTheme>(path, node, tabBarThemeOptions);
  if (node is SourceNode<BottomNavigationBarThemeData>)
    return SelectableChildrenEditor<BottomNavigationBarThemeData>(path, node, bottomNavigationBarThemeDataOptions);
  if (node is SourceNode<SliderThemeData>)
    return SelectableChildrenEditor<SliderThemeData>(path, node, sliderThemeDataOptions);
  if (node is SourceNode<ElevatedButtonThemeData>)
    return SelectableChildrenEditor<ElevatedButtonThemeData>(path, node, elevatedButtonThemeDataOptions);
  if (node is SourceNode<OutlinedButtonThemeData>)
    return SelectableChildrenEditor<OutlinedButtonThemeData>(path, node, outlinedButtonThemeDataOptions);
  if (node is SourceNode<TextButtonThemeData>)
    return SelectableChildrenEditor<TextButtonThemeData>(path, node, textButtonThemeDataOptions);
  if (node is SourceNode<ButtonStyle>)
    return SelectableChildrenEditor<ButtonStyle>(path, node, buttonStyleOptions);
  throw('unsupported: path=$path node=$node');
}
