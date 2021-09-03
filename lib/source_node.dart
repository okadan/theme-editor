import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

part 'source_node.g.dart';

class SourceNode<T> {
  SourceNode([this.source = '', this.children = const {}]) : value = _value(source, children);

  SourceNode.raw(this.source, this.value, this.children);

  final String source;

  final T? value;

  final Map<String, SourceNode> children;

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
