import 'dart:convert';
import 'dart:io';

import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';

void main() async {
  final packageConfig = jsonDecode(File('.dart_tool/package_config.json').readAsStringSync());
  final packages = List<Map<String, dynamic>>
    .from(packageConfig['packages']).where((e) => ['flutter', 'sky_engine'].contains(e['name']));
  final analyzedFilePaths = AnalysisContextCollection(
    includedPaths: packages.map((e) => Uri.parse(e['rootUri'] + '/lib').path).toList(),
  ).contexts.map((e) => e.contextRoot.analyzedFiles()).expand((e) => e);

  final inputData = jsonDecode(File('bin/generate_source_node_data.json').readAsStringSync());
  final typeNames = List<String>.from(inputData['typeNames']);
  final executableNames = List<String>.from(inputData['executableNames']);
  final options = List<String>.from(inputData['options']);

  final context = AnalysisContextCollection(
    includedPaths: [Directory.current.absolute.path],
  ).contexts.first;

  final buffers = <StringBuffer>[];
  final buildBuffers = <StringBuffer>[];

  for (final filePath in analyzedFilePaths) {
    final result = await context.currentSession.getResolvedLibrary(filePath);
    if (result is! ResolvedLibraryResult) continue;
    for (final element in result.element.topLevelElements) {
      if (element is! ClassElement || element.isPrivate) continue;
      final executables = <ExecutableElement>[
        ...element.constructors,
        ...element.methods.where((e) => e.isStatic),
      ].where((e) => e.isPublic);
      for (final executable in executables) {
        final executableName = element.name + (executable.name.isEmpty ? '' : '.${executable.name}');
        if (!executableNames.contains(executableName)) continue;
        final nodeName = _buildNodeName(executableName);
        final returnTypeName = executable.returnType.getDisplayString(withNullability: false);
        final parameters = executable.parameters.where((e) => !e.hasDeprecated);

        buffers.add(() {
          final buffer = StringBuffer();
          buffer.writeln("final $nodeName = SourceNode<$returnTypeName>('$executableName', Map.unmodifiable({");
          for (final parameter in parameters) {
            final typeName = parameter.type.getDisplayString(withNullability: false);
            if (!typeNames.contains(typeName)) continue;
            final identifier = _buildIdentifier(parameter);
            buffer.writeln("  '$identifier': SourceNode<$typeName>(),");
          }
          buffer.writeln("}));");
          return buffer;
        } ());

        buildBuffers.add(() {
          final buffer = StringBuffer();
          buffer.writeln("  source == '$executableName' ? $executableName(");
          for (final parameter in parameters) {
            final typeName = parameter.type.getDisplayString(withNullability: false);
            if (!typeNames.contains(typeName)) continue;
            final identifier = _buildIdentifier(parameter);
            final label = parameter.isPositional ? '' : '${parameter.name}: ';
            final defaultValueCode = parameter.hasDefaultValue ? ' ?? ${parameter.defaultValueCode}' : '';
            buffer.writeln("    ${label}children['$identifier']!.value$defaultValueCode,");
          }
          buffer.writeln("  ) :");
          return buffer;
        } ());
      }
    }
  }

  final buffer = StringBuffer();
  buffer.writeln("// GENERATED CODE - DO NOT EDIT BY HAND");
  buffer.writeln();
  buffer.writeln("part of 'source_node.dart';");
  buffer.writeln();
  buffer.writeln("// " + '*' * 70);
  buffer.writeln("// Generated by '${Platform.script.pathSegments.last}'");
  buffer.writeln("// " + '*' * 70);
  buffer.writeln();

  buffers.forEach((b) => buffer.writeln(b.toString()));

  buffer.writeln("Object? _buildValue(String source, Map<String, SourceNode> children) =>");
  buildBuffers.forEach((b) => buffer.write(b.toString()));
  buffer.writeln("  null;");
  buffer.writeln();

  buffer.writeln("final _sourceValues = Map<String, dynamic>.unmodifiable({");
  options.forEach((e) => buffer.writeln("  '$e': $e,"));
  buffer.writeln("});");

  File('lib/source_node.g.dart').writeAsString(buffer.toString());
}

String _buildNodeName(String executableName) {
  late String nodeName;
  final index = executableName.indexOf('.');
  if (index < 0) {
    nodeName = executableName[0].toLowerCase() +
      executableName.substring(1);
  } else {
    final klass = executableName.substring(0, index);
    final executable = executableName.substring(index + 1);
    nodeName = klass[0].toLowerCase() + klass.substring(1) +
      executable[0].toUpperCase() + executable.substring(1);
  }
  return nodeName + 'Node';
}

String _buildIdentifier(ParameterElement parameter) {
  return (
    (parameter.hasDefaultValue ? '@' : '') +
    (parameter.isPositional ? '_' : '') +
    (parameter.isOptional ? '?' : '') +
    (parameter.type.nullabilitySuffix == NullabilitySuffix.none ? '!' : '')
  ) + '#${parameter.name}';
}
