import 'package:flutter/material.dart';
import 'package:theme_editor/source_node.dart';

class Preview extends StatelessWidget {
  Preview(this.node);

  final SourceNode<ThemeData> node;

  @override
  Widget build(BuildContext context) {
    final widgets = <Widget>[
      _BarsPreview(),
      _ButtonsPreview(),
      _ControlsPreview(),
      _PlaceholderPreview(),
    ];
    return ColoredBox(
      color: Theme.of(context).cardColor,
      child: Theme(
        data: node.value ?? ThemeData(),
        child: LayoutBuilder(builder: (context, constraints) => GridView.count(
          padding: EdgeInsets.all(4),
          crossAxisCount: constraints.maxWidth < 280 ? 1 : constraints.maxWidth ~/ 280,
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
          childAspectRatio: 0.9,
          children: widgets.map((e) => Align(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 420, maxHeight: 420),
              child: Card(
                margin: EdgeInsets.zero,
                shape: RoundedRectangleBorder(),
                color: Theme.of(context).scaffoldBackgroundColor,
                child: Center(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(4),
                    child: e,
                  ),
                ),
              ),
            ),
          )).toList(),
        )),
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
                  Tab(text: 'TAB'),
                  Tab(text: 'TAB'),
                  Tab(text: 'TAB'),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 4),
        BottomNavigationBar(
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Item'),
            BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Item'),
            BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Item'),
          ],
        ),
        SizedBox(height: 4),
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
          SizedBox(width: 4),
          Expanded(child: Center(child: ElevatedButton(child: Text('BUTTON'), onPressed: null))),
        ]),
        SizedBox(height: 4),
        Row(children: [
          Expanded(child: Center(child: OutlinedButton(child: Text('BUTTON'), onPressed: () {}))),
          SizedBox(width: 4),
          Expanded(child: Center(child: OutlinedButton(child: Text('BUTTON'), onPressed: null))),
        ]),
        SizedBox(height: 4),
        Row(children: [
          Expanded(child: Center(child: TextButton(child: Text('BUTTON'), onPressed: () {}))),
          SizedBox(width: 4),
          Expanded(child: Center(child: TextButton(child: Text('BUTTON'), onPressed: null))),
        ]),
        SizedBox(height: 4),
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
        SizedBox(height: 4),
        Row(children: [
          Expanded(child: Center(child: FloatingActionButton(child: Icon(Icons.star), onPressed: () {}))),
          SizedBox(width: 4),
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
        SizedBox(height: 4),
        Row(children: [
          Expanded(child: Center(child: Checkbox(value: true, onChanged: (_) {}))),
          Expanded(child: Center(child: Checkbox(value: false, onChanged: (_) {}))),
          Expanded(child: Center(child: Checkbox(value: true, onChanged: null))),
          Expanded(child: Center(child: Checkbox(value: false, onChanged: null))),
        ]),
        SizedBox(height: 4),
        Row(children: [
          Expanded(child: Center(child: Switch(value: true, onChanged: (_) {}))),
          Expanded(child: Center(child: Switch(value: false, onChanged: (_) {}))),
          Expanded(child: Center(child: Switch(value: true, onChanged: null))),
          Expanded(child: Center(child: Switch(value: false, onChanged: null))),
        ]),
        SizedBox(height: 4),
        Row(children: [
          Expanded(child: Center(child: Slider(value: 0.5, onChanged: (_) {}))),
          Expanded(child: Center(child: Slider(value: 0.5, onChanged: null))),
        ]),
        SizedBox(height: 4),
        Row(children: [
          Expanded(child: Center(child: Slider(divisions: 6, value: 0.5, onChanged: (_) {}))),
          Expanded(child: Center(child: Slider(divisions: 6, value: 0.5, onChanged: null))),
        ]),
        SizedBox(height: 4),
        Row(children: [
          Expanded(child: Center(child: LinearProgressIndicator(value: 0.5))),
          Expanded(child: Center(child: CircularProgressIndicator(value: 0.5))),
        ]),
      ],
    );
  }
}

class _PlaceholderPreview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('TODO: More previews...'),
    );
  }
}
