import 'package:flutter/material.dart';
import 'package:theme_editor/source_node.dart';

class Preview extends StatelessWidget {
  Preview(this.node);

  final SourceNode<ThemeData> node;

  @override
  Widget build(BuildContext context) {
    final previews = <Widget>[
      _BarsPreview(),
      _ButtonsPreview(),
      _ControlsPreview(),
      _TextFieldsPreview(),
    ];
    return Theme(
      data: node.value ?? ThemeData(),
      child: Builder(
        builder: (context) => ColoredBox(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: SizedBox.expand(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(8),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  const space = 8.0;
                  const width = 280.0;
                  final maxWidth = constraints.maxWidth;
                  return Wrap(
                    spacing: space,
                    runSpacing: space,
                    children: previews.map((e) => SizedBox(
                      width: maxWidth < width * 2 ? maxWidth :
                        maxWidth < width * 3 ? maxWidth / 2 - space :
                        maxWidth < width * 4 ? maxWidth / 3 - space:
                        maxWidth / 4 - space,
                      child: Align(child: e),
                    )).toList(),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _BarsPreview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IntrinsicHeight(
          child: DefaultTabController(
            length: 3,
            child: AppBar(
              leading: IconButton(icon: Icon(Icons.menu), onPressed: () {}),
              title: Text('Title'),
              actions: [IconButton(icon: Icon(Icons.star), onPressed: () {})],
              bottom: TabBar(
                tabs: [
                  Tab(text: 'TAB1'),
                  Tab(text: 'TAB2'),
                  Tab(text: 'TAB3'),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 8),
        BottomNavigationBar(
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Item1'),
            BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Item2'),
            BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Item3'),
          ],
        ),
        SizedBox(height: 8),
        BottomAppBar(
          child: Row(
            children: [
              IconButton(icon: Icon(Icons.star), onPressed: () {}),
              IconButton(icon: Icon(Icons.star), onPressed: null),
            ],
          ),
        ),
      ],
    );
  }
}

class _ButtonsPreview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(children: [
          Expanded(child: Center(child: ElevatedButton(child: Text('BUTTON'), onPressed: () {}))),
          SizedBox(width: 8),
          Expanded(child: Center(child: ElevatedButton(child: Text('BUTTON'), onPressed: null))),
        ]),
        SizedBox(height: 8),
        Row(children: [
          Expanded(child: Center(child: OutlinedButton(child: Text('BUTTON'), onPressed: () {}))),
          SizedBox(width: 8),
          Expanded(child: Center(child: OutlinedButton(child: Text('BUTTON'), onPressed: null))),
        ]),
        SizedBox(height: 8),
        Row(children: [
          Expanded(child: Center(child: TextButton(child: Text('BUTTON'), onPressed: () {}))),
          SizedBox(width: 8),
          Expanded(child: Center(child: TextButton(child: Text('BUTTON'), onPressed: null))),
        ]),
        SizedBox(height: 8),
        Row(children: [
          Expanded(child: Center(child: ToggleButtons(
            children: [Icon(Icons.star), Icon(Icons.star)],
            isSelected: [true, false],
            onPressed: (_) {},
          ))),
          Expanded(child: Center(child: ToggleButtons(
            children: [Icon(Icons.star), Icon(Icons.star)],
            isSelected: [true, false],
            onPressed: null,
          ))),
        ]),
        SizedBox(height: 8),
        Row(children: [
          Expanded(child: Center(child: FloatingActionButton(child: Icon(Icons.star), onPressed: () {}))),
          SizedBox(width: 8),
          Expanded(child: Center(child: FloatingActionButton.extended(icon: Icon(Icons.star), label: Text('BUTTON'), onPressed: () {}))),
        ]),
      ],
    );
  }
}

class _ControlsPreview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(children: [
          Expanded(child: Center(child: Radio(groupValue: true, value: true, onChanged: (_) {}))),
          Expanded(child: Center(child: Radio(groupValue: true, value: false, onChanged: (_) {}))),
          Expanded(child: Center(child: Radio(groupValue: true, value: true, onChanged: null))),
          Expanded(child: Center(child: Radio(groupValue: true, value: false, onChanged: null))),
        ]),
        SizedBox(height: 8),
        Row(children: [
          Expanded(child: Center(child: Checkbox(value: true, onChanged: (_) {}))),
          Expanded(child: Center(child: Checkbox(value: false, onChanged: (_) {}))),
          Expanded(child: Center(child: Checkbox(value: true, onChanged: null))),
          Expanded(child: Center(child: Checkbox(value: false, onChanged: null))),
        ]),
        SizedBox(height: 8),
        Row(children: [
          Expanded(child: Center(child: Switch(value: true, onChanged: (_) {}))),
          Expanded(child: Center(child: Switch(value: false, onChanged: (_) {}))),
          Expanded(child: Center(child: Switch(value: true, onChanged: null))),
          Expanded(child: Center(child: Switch(value: false, onChanged: null))),
        ]),
        SizedBox(height: 8),
        Row(children: [
          Expanded(child: Center(child: Slider(value: 0.5, onChanged: (_) {}))),
          Expanded(child: Center(child: Slider(value: 0.5, onChanged: null))),
        ]),
        SizedBox(height: 8),
        Row(children: [
          Expanded(child: Center(child: Slider(divisions: 6, value: 0.5, onChanged: (_) {}))),
          Expanded(child: Center(child: Slider(divisions: 6, value: 0.5, onChanged: null))),
        ]),
        SizedBox(height: 8),
        Row(children: [
          Expanded(child: Center(child: LinearProgressIndicator(value: 0.5))),
          Expanded(child: Center(child: CircularProgressIndicator(value: 0.5))),
        ]),
      ],
    );
  }
}

class _TextFieldsPreview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextField(
          decoration: InputDecoration(hintText: 'Hint Text', helperText: 'Helper Text'),
        ),
        SizedBox(height: 8),
        TextFormField(
          initialValue: 'Text',
          decoration: InputDecoration(labelText: 'Label Text', errorText: 'Error Text'),
        ),
        SizedBox(height: 8),
        TextFormField(
          enabled: false,
          initialValue: 'Text (Disabled)',
          decoration: InputDecoration(labelText: 'Label Text'),
        ),
      ],
    );
  }
}
