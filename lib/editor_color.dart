import 'package:flutter/material.dart';
import 'package:theme_editor/editor.dart';
import 'package:theme_editor/source_node.dart';

class ColorEditorField<T extends Color> extends StatelessWidget {
  ColorEditorField(this.path, this.node);

  final Iterable<String> path;

  final SourceNode<T> node;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(path.last.split('#').last),
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4),
                  child: Text(
                    node.buildSource(),
                    textAlign: TextAlign.end,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              InkWell(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    border: Border.all(color: Theme.of(context).disabledColor),
                    color: node.value,
                  ),
                  child: SizedBox(width: 22, height: 22),
                ),
                onTap: () => Editor.of(context).push(path.last),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ColorEditor<T extends Color> extends StatelessWidget {
  ColorEditor(this.path, this.node, this.onChanged);

  final Iterable<String> path;

  final SourceNode<T> node;

  final ValueChanged<SourceNode<T>> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).disabledColor),
            color: node.value,
          ),
          child: SizedBox(width: 44, height: 44),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(node.buildSource()),
              if (node.value != null)
                InkWell(
                  child: Icon(Icons.clear, size: 14),
                  onTap: () => onChanged(SourceNode<T>()),
                ),
            ],
          ),
        ),
        Expanded(
          child: GridView.count(
            crossAxisCount: 16,
            children: [
              if (node is SourceNode<MaterialColor>)
                ..._materialColorOptions.map((e) {
                  return _ColorTile<MaterialColor>(
                    e,
                    e == node,
                    (value) => onChanged(value as SourceNode<T>),
                  );
                })
              else
                ..._colorOptionsGrid.expand((options) => List.generate(16, (i) {
                  if (options.length <= i)
                    return SizedBox.shrink();
                  final o = options.elementAt(i);
                  return _ColorTile<Color>(
                    o,
                    o == node,
                    (value) => onChanged(value as SourceNode<T>),
                  );
                })),
            ],
          ),
        ),
      ],
    );
  }
}

class _ColorTile<T extends Color> extends StatelessWidget {
  _ColorTile(this.node, this.selected, this.onChanged);

  final SourceNode<T> node;

  final bool selected;

  final ValueChanged<SourceNode<T>> onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        margin: EdgeInsets.all(0.5),
        decoration: BoxDecoration(
          shape: selected ? BoxShape.circle : BoxShape.rectangle,
          border: Border.all(color: Theme.of(context).disabledColor),
          color: node.value,
        ),
      ),
      onTap: () => onChanged(selected ? SourceNode<T>() : node),
    );
  }
}

final Iterable<Iterable<SourceNode<Color>>> _colorOptionsGrid = [[
  SourceNode('Colors.red'),
  SourceNode('Colors.red.shade50'),
  SourceNode('Colors.red.shade100'),
  SourceNode('Colors.red.shade200'),
  SourceNode('Colors.red.shade300'),
  SourceNode('Colors.red.shade400'),
  SourceNode('Colors.red.shade500'),
  SourceNode('Colors.red.shade600'),
  SourceNode('Colors.red.shade700'),
  SourceNode('Colors.red.shade800'),
  SourceNode('Colors.red.shade900'),
  SourceNode('Colors.redAccent'),
  SourceNode('Colors.redAccent.shade100'),
  SourceNode('Colors.redAccent.shade200'),
  SourceNode('Colors.redAccent.shade400'),
  SourceNode('Colors.redAccent.shade700'),
], [
  SourceNode('Colors.pink'),
  SourceNode('Colors.pink.shade50'),
  SourceNode('Colors.pink.shade100'),
  SourceNode('Colors.pink.shade200'),
  SourceNode('Colors.pink.shade300'),
  SourceNode('Colors.pink.shade400'),
  SourceNode('Colors.pink.shade500'),
  SourceNode('Colors.pink.shade600'),
  SourceNode('Colors.pink.shade700'),
  SourceNode('Colors.pink.shade800'),
  SourceNode('Colors.pink.shade900'),
  SourceNode('Colors.pinkAccent'),
  SourceNode('Colors.pinkAccent.shade100'),
  SourceNode('Colors.pinkAccent.shade200'),
  SourceNode('Colors.pinkAccent.shade400'),
  SourceNode('Colors.pinkAccent.shade700'),
], [
  SourceNode('Colors.purple'),
  SourceNode('Colors.purple.shade50'),
  SourceNode('Colors.purple.shade100'),
  SourceNode('Colors.purple.shade200'),
  SourceNode('Colors.purple.shade300'),
  SourceNode('Colors.purple.shade400'),
  SourceNode('Colors.purple.shade500'),
  SourceNode('Colors.purple.shade600'),
  SourceNode('Colors.purple.shade700'),
  SourceNode('Colors.purple.shade800'),
  SourceNode('Colors.purple.shade900'),
  SourceNode('Colors.purpleAccent'),
  SourceNode('Colors.purpleAccent.shade100'),
  SourceNode('Colors.purpleAccent.shade200'),
  SourceNode('Colors.purpleAccent.shade400'),
  SourceNode('Colors.purpleAccent.shade700'),
], [
  SourceNode('Colors.deepPurple'),
  SourceNode('Colors.deepPurple.shade50'),
  SourceNode('Colors.deepPurple.shade100'),
  SourceNode('Colors.deepPurple.shade200'),
  SourceNode('Colors.deepPurple.shade300'),
  SourceNode('Colors.deepPurple.shade400'),
  SourceNode('Colors.deepPurple.shade500'),
  SourceNode('Colors.deepPurple.shade600'),
  SourceNode('Colors.deepPurple.shade700'),
  SourceNode('Colors.deepPurple.shade800'),
  SourceNode('Colors.deepPurple.shade900'),
  SourceNode('Colors.deepPurpleAccent'),
  SourceNode('Colors.deepPurpleAccent.shade100'),
  SourceNode('Colors.deepPurpleAccent.shade200'),
  SourceNode('Colors.deepPurpleAccent.shade400'),
  SourceNode('Colors.deepPurpleAccent.shade700'),
], [
  SourceNode('Colors.indigo'),
  SourceNode('Colors.indigo.shade50'),
  SourceNode('Colors.indigo.shade100'),
  SourceNode('Colors.indigo.shade200'),
  SourceNode('Colors.indigo.shade300'),
  SourceNode('Colors.indigo.shade400'),
  SourceNode('Colors.indigo.shade500'),
  SourceNode('Colors.indigo.shade600'),
  SourceNode('Colors.indigo.shade700'),
  SourceNode('Colors.indigo.shade800'),
  SourceNode('Colors.indigo.shade900'),
  SourceNode('Colors.indigoAccent'),
  SourceNode('Colors.indigoAccent.shade100'),
  SourceNode('Colors.indigoAccent.shade200'),
  SourceNode('Colors.indigoAccent.shade400'),
  SourceNode('Colors.indigoAccent.shade700'),
], [
  SourceNode('Colors.blue'),
  SourceNode('Colors.blue.shade50'),
  SourceNode('Colors.blue.shade100'),
  SourceNode('Colors.blue.shade200'),
  SourceNode('Colors.blue.shade300'),
  SourceNode('Colors.blue.shade400'),
  SourceNode('Colors.blue.shade500'),
  SourceNode('Colors.blue.shade600'),
  SourceNode('Colors.blue.shade700'),
  SourceNode('Colors.blue.shade800'),
  SourceNode('Colors.blue.shade900'),
  SourceNode('Colors.blueAccent'),
  SourceNode('Colors.blueAccent.shade100'),
  SourceNode('Colors.blueAccent.shade200'),
  SourceNode('Colors.blueAccent.shade400'),
  SourceNode('Colors.blueAccent.shade700'),
], [
  SourceNode('Colors.lightBlue'),
  SourceNode('Colors.lightBlue.shade50'),
  SourceNode('Colors.lightBlue.shade100'),
  SourceNode('Colors.lightBlue.shade200'),
  SourceNode('Colors.lightBlue.shade300'),
  SourceNode('Colors.lightBlue.shade400'),
  SourceNode('Colors.lightBlue.shade500'),
  SourceNode('Colors.lightBlue.shade600'),
  SourceNode('Colors.lightBlue.shade700'),
  SourceNode('Colors.lightBlue.shade800'),
  SourceNode('Colors.lightBlue.shade900'),
  SourceNode('Colors.lightBlueAccent'),
  SourceNode('Colors.lightBlueAccent.shade100'),
  SourceNode('Colors.lightBlueAccent.shade200'),
  SourceNode('Colors.lightBlueAccent.shade400'),
  SourceNode('Colors.lightBlueAccent.shade700'),
], [
  SourceNode('Colors.cyan'),
  SourceNode('Colors.cyan.shade50'),
  SourceNode('Colors.cyan.shade100'),
  SourceNode('Colors.cyan.shade200'),
  SourceNode('Colors.cyan.shade300'),
  SourceNode('Colors.cyan.shade400'),
  SourceNode('Colors.cyan.shade500'),
  SourceNode('Colors.cyan.shade600'),
  SourceNode('Colors.cyan.shade700'),
  SourceNode('Colors.cyan.shade800'),
  SourceNode('Colors.cyan.shade900'),
  SourceNode('Colors.cyanAccent'),
  SourceNode('Colors.cyanAccent.shade100'),
  SourceNode('Colors.cyanAccent.shade200'),
  SourceNode('Colors.cyanAccent.shade400'),
  SourceNode('Colors.cyanAccent.shade700'),
], [
  SourceNode('Colors.teal'),
  SourceNode('Colors.teal.shade50'),
  SourceNode('Colors.teal.shade100'),
  SourceNode('Colors.teal.shade200'),
  SourceNode('Colors.teal.shade300'),
  SourceNode('Colors.teal.shade400'),
  SourceNode('Colors.teal.shade500'),
  SourceNode('Colors.teal.shade600'),
  SourceNode('Colors.teal.shade700'),
  SourceNode('Colors.teal.shade800'),
  SourceNode('Colors.teal.shade900'),
  SourceNode('Colors.tealAccent'),
  SourceNode('Colors.tealAccent.shade100'),
  SourceNode('Colors.tealAccent.shade200'),
  SourceNode('Colors.tealAccent.shade400'),
  SourceNode('Colors.tealAccent.shade700'),
], [
  SourceNode('Colors.green'),
  SourceNode('Colors.green.shade50'),
  SourceNode('Colors.green.shade100'),
  SourceNode('Colors.green.shade200'),
  SourceNode('Colors.green.shade300'),
  SourceNode('Colors.green.shade400'),
  SourceNode('Colors.green.shade500'),
  SourceNode('Colors.green.shade600'),
  SourceNode('Colors.green.shade700'),
  SourceNode('Colors.green.shade800'),
  SourceNode('Colors.green.shade900'),
  SourceNode('Colors.greenAccent'),
  SourceNode('Colors.greenAccent.shade100'),
  SourceNode('Colors.greenAccent.shade200'),
  SourceNode('Colors.greenAccent.shade400'),
  SourceNode('Colors.greenAccent.shade700'),
], [
  SourceNode('Colors.lightGreen'),
  SourceNode('Colors.lightGreen.shade50'),
  SourceNode('Colors.lightGreen.shade100'),
  SourceNode('Colors.lightGreen.shade200'),
  SourceNode('Colors.lightGreen.shade300'),
  SourceNode('Colors.lightGreen.shade400'),
  SourceNode('Colors.lightGreen.shade500'),
  SourceNode('Colors.lightGreen.shade600'),
  SourceNode('Colors.lightGreen.shade700'),
  SourceNode('Colors.lightGreen.shade800'),
  SourceNode('Colors.lightGreen.shade900'),
  SourceNode('Colors.lightGreenAccent'),
  SourceNode('Colors.lightGreenAccent.shade100'),
  SourceNode('Colors.lightGreenAccent.shade200'),
  SourceNode('Colors.lightGreenAccent.shade400'),
  SourceNode('Colors.lightGreenAccent.shade700'),
], [
  SourceNode('Colors.lime'),
  SourceNode('Colors.lime.shade50'),
  SourceNode('Colors.lime.shade100'),
  SourceNode('Colors.lime.shade200'),
  SourceNode('Colors.lime.shade300'),
  SourceNode('Colors.lime.shade400'),
  SourceNode('Colors.lime.shade500'),
  SourceNode('Colors.lime.shade600'),
  SourceNode('Colors.lime.shade700'),
  SourceNode('Colors.lime.shade800'),
  SourceNode('Colors.lime.shade900'),
  SourceNode('Colors.limeAccent'),
  SourceNode('Colors.limeAccent.shade100'),
  SourceNode('Colors.limeAccent.shade200'),
  SourceNode('Colors.limeAccent.shade400'),
  SourceNode('Colors.limeAccent.shade700'),
], [
  SourceNode('Colors.yellow'),
  SourceNode('Colors.yellow.shade50'),
  SourceNode('Colors.yellow.shade100'),
  SourceNode('Colors.yellow.shade200'),
  SourceNode('Colors.yellow.shade300'),
  SourceNode('Colors.yellow.shade400'),
  SourceNode('Colors.yellow.shade500'),
  SourceNode('Colors.yellow.shade600'),
  SourceNode('Colors.yellow.shade700'),
  SourceNode('Colors.yellow.shade800'),
  SourceNode('Colors.yellow.shade900'),
  SourceNode('Colors.yellowAccent'),
  SourceNode('Colors.yellowAccent.shade100'),
  SourceNode('Colors.yellowAccent.shade200'),
  SourceNode('Colors.yellowAccent.shade400'),
  SourceNode('Colors.yellowAccent.shade700'),
], [
  SourceNode('Colors.amber'),
  SourceNode('Colors.amber.shade50'),
  SourceNode('Colors.amber.shade100'),
  SourceNode('Colors.amber.shade200'),
  SourceNode('Colors.amber.shade300'),
  SourceNode('Colors.amber.shade400'),
  SourceNode('Colors.amber.shade500'),
  SourceNode('Colors.amber.shade600'),
  SourceNode('Colors.amber.shade700'),
  SourceNode('Colors.amber.shade800'),
  SourceNode('Colors.amber.shade900'),
  SourceNode('Colors.amberAccent'),
  SourceNode('Colors.amberAccent.shade100'),
  SourceNode('Colors.amberAccent.shade200'),
  SourceNode('Colors.amberAccent.shade400'),
  SourceNode('Colors.amberAccent.shade700'),
], [
  SourceNode('Colors.orange'),
  SourceNode('Colors.orange.shade50'),
  SourceNode('Colors.orange.shade100'),
  SourceNode('Colors.orange.shade200'),
  SourceNode('Colors.orange.shade300'),
  SourceNode('Colors.orange.shade400'),
  SourceNode('Colors.orange.shade500'),
  SourceNode('Colors.orange.shade600'),
  SourceNode('Colors.orange.shade700'),
  SourceNode('Colors.orange.shade800'),
  SourceNode('Colors.orange.shade900'),
  SourceNode('Colors.orangeAccent'),
  SourceNode('Colors.orangeAccent.shade100'),
  SourceNode('Colors.orangeAccent.shade200'),
  SourceNode('Colors.orangeAccent.shade400'),
  SourceNode('Colors.orangeAccent.shade700'),
], [
  SourceNode('Colors.deepOrange'),
  SourceNode('Colors.deepOrange.shade50'),
  SourceNode('Colors.deepOrange.shade100'),
  SourceNode('Colors.deepOrange.shade200'),
  SourceNode('Colors.deepOrange.shade300'),
  SourceNode('Colors.deepOrange.shade400'),
  SourceNode('Colors.deepOrange.shade500'),
  SourceNode('Colors.deepOrange.shade600'),
  SourceNode('Colors.deepOrange.shade700'),
  SourceNode('Colors.deepOrange.shade800'),
  SourceNode('Colors.deepOrange.shade900'),
  SourceNode('Colors.deepOrangeAccent'),
  SourceNode('Colors.deepOrangeAccent.shade100'),
  SourceNode('Colors.deepOrangeAccent.shade200'),
  SourceNode('Colors.deepOrangeAccent.shade400'),
  SourceNode('Colors.deepOrangeAccent.shade700'),
], [
  SourceNode('Colors.brown'),
  SourceNode('Colors.brown.shade50'),
  SourceNode('Colors.brown.shade100'),
  SourceNode('Colors.brown.shade200'),
  SourceNode('Colors.brown.shade300'),
  SourceNode('Colors.brown.shade400'),
  SourceNode('Colors.brown.shade500'),
  SourceNode('Colors.brown.shade600'),
  SourceNode('Colors.brown.shade700'),
  SourceNode('Colors.brown.shade800'),
  SourceNode('Colors.brown.shade900'),
], [
  SourceNode('Colors.grey'),
  SourceNode('Colors.grey.shade50'),
  SourceNode('Colors.grey.shade100'),
  SourceNode('Colors.grey.shade200'),
  SourceNode('Colors.grey.shade300'),
  SourceNode('Colors.grey.shade400'),
  SourceNode('Colors.grey.shade500'),
  SourceNode('Colors.grey.shade600'),
  SourceNode('Colors.grey.shade700'),
  SourceNode('Colors.grey.shade800'),
  SourceNode('Colors.grey.shade900'),
], [
  SourceNode('Colors.blueGrey'),
  SourceNode('Colors.blueGrey.shade50'),
  SourceNode('Colors.blueGrey.shade100'),
  SourceNode('Colors.blueGrey.shade200'),
  SourceNode('Colors.blueGrey.shade300'),
  SourceNode('Colors.blueGrey.shade400'),
  SourceNode('Colors.blueGrey.shade500'),
  SourceNode('Colors.blueGrey.shade600'),
  SourceNode('Colors.blueGrey.shade700'),
  SourceNode('Colors.blueGrey.shade800'),
  SourceNode('Colors.blueGrey.shade900'),
], [
  SourceNode('Colors.white'),
  SourceNode('Colors.white10'),
  SourceNode('Colors.white12'),
  SourceNode('Colors.white24'),
  SourceNode('Colors.white30'),
  SourceNode('Colors.white38'),
  SourceNode('Colors.white54'),
  SourceNode('Colors.white60'),
  SourceNode('Colors.white70'),
], [
  SourceNode('Colors.black'),
  SourceNode('Colors.black12'),
  SourceNode('Colors.black26'),
  SourceNode('Colors.black38'),
  SourceNode('Colors.black45'),
  SourceNode('Colors.black54'),
  SourceNode('Colors.black87'),
]];

final Iterable<SourceNode<MaterialColor>> _materialColorOptions = [
  SourceNode('Colors.red'),
  SourceNode('Colors.pink'),
  SourceNode('Colors.purple'),
  SourceNode('Colors.deepPurple'),
  SourceNode('Colors.indigo'),
  SourceNode('Colors.blue'),
  SourceNode('Colors.lightBlue'),
  SourceNode('Colors.cyan'),
  SourceNode('Colors.teal'),
  SourceNode('Colors.green'),
  SourceNode('Colors.lightGreen'),
  SourceNode('Colors.lime'),
  SourceNode('Colors.yellow'),
  SourceNode('Colors.amber'),
  SourceNode('Colors.orange'),
  SourceNode('Colors.deepOrange'),
  SourceNode('Colors.brown'),
  SourceNode('Colors.grey'),
  SourceNode('Colors.blueGrey'),
];
