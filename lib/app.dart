import 'dart:async';
import 'dart:html' as html; // ignore: avoid_web_libraries_in_flutter
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:theme_editor/editor.dart';
import 'package:theme_editor/preview.dart';
import 'package:theme_editor/source_node.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Theme Editor',
      home: _Home(),
      // todo: define color schemes.
      // theme: ThemeData(colorScheme: ColorScheme.light()),
      // darkTheme: ThemeData(colorScheme: ColorScheme.dark()),
      theme: ThemeData(colorScheme: ColorScheme.dark()),
    );
  }
}

class _Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<_Home> {
  final GlobalKey<EditorState> _editorKey = GlobalKey();
  SourceNode<ThemeData> _node = themeDataNode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Theme Editor'),
        actions: [
          TextButton(
            style: TextButton.styleFrom(minimumSize: Size.fromWidth(85)),
            child: Text('RESET'),
            onPressed: _node == themeDataNode ? null : () {
              _editorKey.currentState!.path.clear();
              setState(() => _node = themeDataNode);
            },
          ),
          TextButton(
            style: TextButton.styleFrom(minimumSize: Size.fromWidth(85)),
            child: Text('EXPORT'),
            onPressed: () => showDialog(
              context: context,
              builder: (context) => _ExportDialog(_node),
            ),
          ),
          TextButton(
            style: TextButton.styleFrom(minimumSize: Size.fromWidth(85)),
            child: Row(children: [
              Text('GITHUB '),
              Icon(Icons.open_in_new, size: 16),
            ]),
            onPressed: () => html.window.open('https://github.com/okadan/theme-editor', 'new'),
          ),
        ],
      ),
      body: LayoutBuilder(builder: (context, constraints) => Row(
        children: [
          Expanded(
            child: Preview(_node),
          ),
          SizedBox(
            width: math.min(constraints.maxWidth / 2, 300),
            child: Editor(_editorKey, _node, (value) => setState(() => _node = value)),
          ),
        ],
      )),
    );
  }
}

class _ExportDialog extends StatefulWidget {
  _ExportDialog(this.node);

  final SourceNode node;

  @override
  State<StatefulWidget> createState() => _ExportDialogState();
}

class _ExportDialogState extends State<_ExportDialog> {
  Timer? _copiedTimer;

  @override
  void dispose() {
    _copiedTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: Border.all(color: Colors.transparent),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 600, maxHeight: 400),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ColoredBox(
                color: Theme.of(context).hoverColor,
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(8),
                  child: Text(widget.node.buildSource()),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(shape: RoundedRectangleBorder()),
                    child: Text('CANCEL'),
                    onPressed: () => Navigator.pop(context),
                  ),
                  SizedBox(width: 8),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(shape: RoundedRectangleBorder()),
                    child: Text(_copiedTimer != null ? 'COPIED!' : 'COPY ALL'),
                    onPressed: _copiedTimer != null ? () {} : () async {
                      await Clipboard.setData(ClipboardData(text: widget.node.buildSource()));
                      setState(() => _copiedTimer = Timer(
                        Duration(seconds: 3),
                        () => setState(() => _copiedTimer = null),
                      ));
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
