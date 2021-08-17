import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:theme_editor/source_node.dart';

void main() {
  group('has the correct source and value: ', () {
    test('default', () {
      final node = themeDataNode;
      expect(node.value, ThemeData());
      expect(node.buildSource(), 'ThemeData()');
    });

    test('update child', () {
      final node = themeDataNode
        .updateDescendant('?#brightness', SourceNode<Brightness>('Brightness.dark'));
      expect(node.value, ThemeData(brightness: Brightness.dark));
      expect(node.buildSource(), 'ThemeData(brightness:Brightness.dark)');
    });

    test('update child with explicit null', () {
      final node = themeDataNode
        .updateDescendant('?#brightness', SourceNode<Brightness>('null'));
      expect(node.value, ThemeData(brightness: null));
      expect(node.buildSource(), 'ThemeData(brightness:null)');
    });

    test('update multi child', () {
      final node = themeDataNode
        .updateDescendant('?#brightness', SourceNode<Brightness>('Brightness.dark'))
        .updateDescendant('?#primaryColorBrightness', SourceNode<Brightness>('Brightness.dark'));
      expect(node.value, ThemeData(brightness: Brightness.dark, primaryColorBrightness: Brightness.dark));
      expect(node.buildSource(), 'ThemeData(brightness:Brightness.dark,primaryColorBrightness:Brightness.dark)');
    });

    test('update complex child', () {
      final node = themeDataNode
        .updateDescendant('?#appBarTheme', appBarThemeNode);
      expect(node.value, ThemeData(appBarTheme: AppBarTheme()));
      expect(node.buildSource(), 'ThemeData(appBarTheme:AppBarTheme())');
    });

    test('update complex nested child', () {
      final node = themeDataNode
        .updateDescendant('?#appBarTheme', appBarThemeNode)
        .updateDescendant('?#appBarTheme.?#brightness', SourceNode<Brightness>('Brightness.dark'));
      expect(node.value, ThemeData(appBarTheme: AppBarTheme(brightness: Brightness.dark)));
      expect(node.buildSource(), 'ThemeData(appBarTheme:AppBarTheme(brightness:Brightness.dark))');
    });

    test('update complex nested child with explicit null', () {
      final node = themeDataNode
        .updateDescendant('?#appBarTheme', appBarThemeNode)
        .updateDescendant('?#appBarTheme.?#brightness', SourceNode<Brightness>('null'));
      expect(node.value, ThemeData(appBarTheme: AppBarTheme(brightness: null)));
      expect(node.buildSource(), 'ThemeData(appBarTheme:AppBarTheme(brightness:null))');
    });
  });
}
