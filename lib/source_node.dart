import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:theme_editor/editor_children.dart';
import 'package:theme_editor/editor_color.dart';
import 'package:theme_editor/editor_select.dart';

part 'source_node.g.dart';

class SourceNode<T> {
  SourceNode([this.source = '', this.children = const {}])
    : value = _getValue(source, children);

  final String source;

  final Map<String, SourceNode> children;

  final T? value;

  @override
  int get hashCode => hashValues(source, children, value);

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType)
      return false;
    return other is SourceNode<T>
      && other.source == source
      && mapEquals(other.children, children)
      && other.value == value;
  }

  SourceNode<S> descendantOf<S>(String path) {
    final index = path.indexOf('.');
    if (index < 0)
      return children[path] as SourceNode<S>;
    final childName = path.substring(0, index);
    final childPath = path.substring(index + 1);
    return children[childName]!.descendantOf(childPath);
  }

  SourceNode<T> updateDescendant<S>(String path, SourceNode<S> node) {
    final index = path.indexOf('.');
    if (index < 0)
      return SourceNode(source, Map.unmodifiable(Map.of(children)..[path] = node));
    final childName = path.substring(0, index);
    final childPath = path.substring(index + 1);
    final child = children[childName]!.updateDescendant<S>(childPath, node);
    return SourceNode(source, Map.unmodifiable(Map.of(children)..[childName] = child));
  }

  String buildSource([String? name]) {
    final label = name == null || name.isEmpty || name.startsWith('_') ? '' : '$name:';
    if (source.isEmpty)
      return '${label}null';
    if (children.isEmpty)
      return '$label$source';
    final entries = children.entries
      .where((e) => e.value.source == 'null' || e.value.value != null);
    if (entries.isEmpty)
      return '${label}null';
    return '$label$source('
      + entries.map((e) => e.value.buildSource(e.key)).join(',')
      + ')';
  }

  static dynamic _getValue(String source, Map<String, SourceNode> children) {
    if (children.isEmpty) {
      if (source.isEmpty || source == 'null') return null;
      if (num.tryParse(source) != null) return num.parse(source);
      if (_sourceValues.containsKey(source)) return _sourceValues[source];
      throw('unsupported: source=$source children=$children');
    } else {
      if (children.entries.any((e) =>
        e.key.startsWith('_') && e.value.source != 'null' && e.value.value == null
      )) return null;
      if (!children.entries.any((e) =>
        e.value.source == 'null' || e.value.value != null
      )) return null;
      return _buildValue(source, children);
    }
  }
}

Widget buildEditor<T>(String name, SourceNode<T> node, ValueChanged<SourceNode<T>> onChanged) {
  final descendant = node.descendantOf(name);
  final descendantOnChanged = (value) => onChanged(node.updateDescendant(name, value));
  if (descendant is SourceNode<Color>)
    return ColorEditor(name, descendant, descendantOnChanged);
  if (descendant is SourceNode<Brightness>)
    return SelectEditor<Brightness>(name, descendant, descendantOnChanged, brightnessOptions);
  if (descendant.children.length > 1)
    return ChildrenEditor(name, descendant, descendantOnChanged);
  if (descendant.children.length == 1)
    return buildEditor<T>('$name.${descendant.children.keys.first}', node, onChanged);
  throw('unsupported: name=$name node=$descendant');
}

Widget buildEditorView<T>(String path, SourceNode<T> node, ValueChanged<SourceNode<T>> onChanged) {
  final descendant = node.descendantOf(path);
  final descendantOnChanged = (value) => onChanged(node.updateDescendant(path, value));
  if (descendant is SourceNode<Color>)
    return ColorEditorView(descendant, descendantOnChanged);
  if (descendant.children.isNotEmpty)
    return ChildrenEditorView(descendant, descendantOnChanged);
  throw('unsupported: path=$path node=$descendant');
}
