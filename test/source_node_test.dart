import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_theme_editor/source_node.dart';

void main() {
  group('has the correct source and value: ', () {
    test('default', () {
      final node = themeDataNode;
      expect(node.value, ThemeData());
      expect(node.buildSource(), 'ThemeData()');
    });

    test('update child', () {
      final node = themeDataNode
        .updateDescendant('?#primaryColor', SourceNode<Color>('Colors.red'));
      expect(node.value, ThemeData(primaryColor: Colors.red));
      expect(node.buildSource(), 'ThemeData(primaryColor:Colors.red)');
    });

    test('update child with explicit null', () {
      final node = themeDataNode
        .updateDescendant('?#primaryColor', SourceNode<Color>('null'));
      expect(node.value, ThemeData(brightness: null));
      expect(node.buildSource(), 'ThemeData(primaryColor:null)');
    });

    test('update multi child', () {
      final node = themeDataNode
        .updateDescendant('?#primaryColor', SourceNode<Color>('Colors.red'))
        .updateDescendant('?#primaryColorLight', SourceNode<Color>('Colors.red'));
      expect(node.value, ThemeData(primaryColor: Colors.red, primaryColorLight: Colors.red));
      expect(node.buildSource(), 'ThemeData(primaryColor:Colors.red,primaryColorLight:Colors.red)');
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
        .updateDescendant('?#appBarTheme.?#color', SourceNode<Color>('Colors.red'));
      expect(node.value, ThemeData(appBarTheme: AppBarTheme(color: Colors.red)));
      expect(node.buildSource(), 'ThemeData(appBarTheme:AppBarTheme(color:Colors.red))');
    });

    test('update complex nested child with explicit null', () {
      final node = themeDataNode
        .updateDescendant('?#appBarTheme', appBarThemeNode)
        .updateDescendant('?#appBarTheme.?#color', SourceNode<Color>('null'));
      expect(node.value, ThemeData(appBarTheme: AppBarTheme(color: null)));
      expect(node.buildSource(), 'ThemeData(appBarTheme:AppBarTheme(color:null))');
    });
  });
}
