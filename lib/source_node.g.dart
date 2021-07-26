// todo: generate this file automatically.

part of 'source_node.dart';

final themeDataNode = SourceNode<ThemeData>('ThemeData', Map.unmodifiable({
  'brightness': SourceNode<Brightness>(),
  'primarySwatch': SourceNode<MaterialColor>(),
  'primaryColor': SourceNode<Color>(),
  'primaryColorLight': SourceNode<Color>(),
  'primaryColorDark': SourceNode<Color>(),
  'primaryColorBrightness': SourceNode<Brightness>(),
  'accentColor': SourceNode<Color>(),
  'accentColorBrightness': SourceNode<Brightness>(),
  'elevatedButtonTheme': elevatedButtonThemeDataNode,
  'outlinedButtonTheme': outlinedButtonThemeDataNode,
  'textButtonTheme': textButtonThemeDataNode,
}));

final elevatedButtonThemeDataNode = SourceNode<ElevatedButtonThemeData>('ElevatedButtonThemeData', Map.unmodifiable({
  'style': elevatedButtonStyleFromNode,
}));

final outlinedButtonThemeDataNode = SourceNode<OutlinedButtonThemeData>('OutlinedButtonThemeData', Map.unmodifiable({
  'style': outlinedButtonStyleFromNode,
}));

final textButtonThemeDataNode = SourceNode<TextButtonThemeData>('TextButtonThemeData', Map.unmodifiable({
  'style': textButtonStyleFromNode,
}));

final elevatedButtonStyleFromNode = SourceNode<ButtonStyle>('ElevatedButton.styleFrom', Map.unmodifiable({
  'primary': SourceNode<Color>(),
  'onPrimary': SourceNode<Color>(),
  'onSurface': SourceNode<Color>(),
}));

final outlinedButtonStyleFromNode = SourceNode<ButtonStyle>('OutlinedButton.styleFrom', Map.unmodifiable({
  'primary': SourceNode<Color>(),
  'onSurface': SourceNode<Color>(),
}));

final textButtonStyleFromNode = SourceNode<ButtonStyle>('TextButton.styleFrom', Map.unmodifiable({
  'primary': SourceNode<Color>(),
  'onSurface': SourceNode<Color>(),
}));

dynamic _buildValue(String source, Map<String, dynamic> children) =>
  source == 'ThemeData' ? ThemeData(
    brightness: children['brightness']!.value,
    primarySwatch: children['primarySwatch']!.value,
    primaryColor: children['primaryColor']!.value,
    primaryColorLight: children['primaryColorLight']!.value,
    primaryColorDark: children['primaryColorDark']!.value,
    primaryColorBrightness: children['primaryColorBrightness']!.value,
    accentColor: children['accentColor']!.value,
    accentColorBrightness: children['accentColorBrightness']!.value,
    elevatedButtonTheme: children['elevatedButtonTheme']!.value,
    outlinedButtonTheme: children['outlinedButtonTheme']!.value,
    textButtonTheme: children['textButtonTheme']!.value,
  ) :
  source == 'ElevatedButtonThemeData' ? ElevatedButtonThemeData(
    style: children['style']!.value,
  ) :
  source == 'OutlinedButtonThemeData' ? OutlinedButtonThemeData(
    style: children['style']!.value,
  ) :
  source == 'TextButtonThemeData' ? TextButtonThemeData(
    style: children['style']!.value,
  ) :
  source == 'ElevatedButton.styleFrom' ? ElevatedButton.styleFrom(
    primary: children['primary']!.value,
    onPrimary: children['onPrimary']!.value,
    onSurface: children['onSurface']!.value,
  ) :
  source == 'OutlinedButton.styleFrom' ? OutlinedButton.styleFrom(
    primary: children['primary']!.value,
    onSurface: children['onSurface']!.value,
  ) :
  source == 'TextButton.styleFrom' ? TextButton.styleFrom(
    primary: children['primary']!.value,
    onSurface: children['onSurface']!.value,
  ) :
  throw('unsupported: source=$source children=$children');
