import 'package:flutter/material.dart';
import 'package:theme_editor/source_node.dart';

class Preview extends StatelessWidget {
  Preview(this.node);

  final SourceNode<ThemeData> node;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Theme.of(context).cardColor,
      child: SingleChildScrollView(
        padding: EdgeInsets.all(4),
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 400),
            child: Theme(
              data: node.value ?? ThemeData(),
              child: Builder(
                builder: (context) => Column(
                  children: [
                    DefaultTabController(
                      length: 3,
                      child: IntrinsicHeight(
                        child: AppBar(
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
                    Padding(padding: EdgeInsets.symmetric(vertical: 2)),
                    BottomNavigationBar(
                      items: [
                        BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Item1'),
                        BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Item2'),
                        BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Item3'),
                      ],
                    ),
                    Padding(padding: EdgeInsets.symmetric(vertical: 2)),
                    BottomAppBar(
                      child: Row(
                        children: [
                          IconButton(icon: Icon(Icons.star), onPressed: () {}),
                          IconButton(icon: Icon(Icons.star), onPressed: null),
                        ],
                      ),
                    ),
                    Padding(padding: EdgeInsets.symmetric(vertical: 2)),
                    Card(
                      margin: EdgeInsets.zero,
                      color: Theme.of(context).scaffoldBackgroundColor,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                      child: Padding(
                        padding: EdgeInsets.all(4),
                        child: Column(
                          children: [
                            Row(children: [
                              Expanded(child: Center(child: Radio(groupValue: true, value: true, onChanged: (_) {}))),
                              Expanded(child: Center(child: Radio(groupValue: true, value: false, onChanged: (_) {}))),
                              Expanded(child: Center(child: Radio(groupValue: true, value: true, onChanged: null))),
                              Expanded(child: Center(child: Radio(groupValue: true, value: false, onChanged: null))),
                            ]),
                            Padding(padding: EdgeInsets.symmetric(vertical: 2)),
                            Row(children: [
                              Expanded(child: Center(child: Checkbox(value: true, onChanged: (_) {}))),
                              Expanded(child: Center(child: Checkbox(value: false, onChanged: (_) {}))),
                              Expanded(child: Center(child: Checkbox(value: true, onChanged: null))),
                              Expanded(child: Center(child: Checkbox(value: false, onChanged: null))),
                            ]),
                            Padding(padding: EdgeInsets.symmetric(vertical: 2)),
                            Row(children: [
                              Expanded(child: Center(child: Switch(value: true, onChanged: (_) {}))),
                              Expanded(child: Center(child: Switch(value: false, onChanged: (_) {}))),
                              Expanded(child: Center(child: Switch(value: true, onChanged: null))),
                              Expanded(child: Center(child: Switch(value: false, onChanged: null))),
                            ]),
                            Padding(padding: EdgeInsets.symmetric(vertical: 2)),
                            Row(children: [
                              Expanded(child: Center(child: Slider(value: 0.5, onChanged: (_) {}))),
                              Expanded(child: Center(child: Slider(value: 0.5, onChanged: null))),
                            ]),
                            Padding(padding: EdgeInsets.symmetric(vertical: 2)),
                            Row(children: [
                              Expanded(child: Center(child: Slider(divisions: 6, value: 0.5, onChanged: (_) {}))),
                              Expanded(child: Center(child: Slider(divisions: 6, value: 0.5, onChanged: null))),
                            ]),
                            Padding(padding: EdgeInsets.symmetric(vertical: 2)),
                            Row(children: [
                              Expanded(child: Center(child: LinearProgressIndicator(value: 0.5))),
                              Expanded(child: Center(child: CircularProgressIndicator(value: 0.5))),
                            ]),
                          ],
                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.symmetric(vertical: 2)),
                    Card(
                      margin: EdgeInsets.zero,
                      color: Theme.of(context).scaffoldBackgroundColor,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                      child: Padding(
                        padding: EdgeInsets.all(4),
                        child: Column(
                          children: [
                            Row(children: [
                              Expanded(child: Center(child: ElevatedButton(child: Text('BUTTON'), onPressed: () {}))),
                              Expanded(child: Center(child: ElevatedButton(child: Text('BUTTON'), onPressed: null))),
                            ]),
                            Padding(padding: EdgeInsets.symmetric(vertical: 2)),
                            Row(children: [
                              Expanded(child: Center(child: OutlinedButton(child: Text('BUTTON'), onPressed: () {}))),
                              Expanded(child: Center(child: OutlinedButton(child: Text('BUTTON'), onPressed: null))),
                            ]),
                            Padding(padding: EdgeInsets.symmetric(vertical: 2)),
                            Row(children: [
                              Expanded(child: Center(child: TextButton(child: Text('BUTTON'), onPressed: () {}))),
                              Expanded(child: Center(child: TextButton(child: Text('BUTTON'), onPressed: null))),
                            ]),
                            Padding(padding: EdgeInsets.symmetric(vertical: 2)),
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
                            Padding(padding: EdgeInsets.symmetric(vertical: 2)),
                            Row(children: [
                              Expanded(child: Center(child: FloatingActionButton(child: Icon(Icons.star), onPressed: () {}))),
                              Expanded(child: Center(child: FloatingActionButton.extended(icon: Icon(Icons.star), label: Text('BUTTON'), onPressed: () {}))),
                            ]),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
