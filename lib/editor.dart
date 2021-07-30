import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:theme_editor/editor_children.dart';
import 'package:theme_editor/source_node.dart';

class Editor extends StatefulWidget {
  Editor(this.node, this.onChanged);

  final SourceNode<ThemeData> node;

  final ValueChanged<SourceNode<ThemeData>> onChanged;

  @override
  State<StatefulWidget> createState() => EditorState();
}

class EditorState extends State<Editor> {
  final List<String> _names = [];

  static void push(BuildContext context, String name) {
    final state = context.findAncestorStateOfType<EditorState>()!;
    state.setState(() => state._names.add(name));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          constraints: BoxConstraints(minHeight: 26),
          decoration: BoxDecoration(color: Theme.of(context).hoverColor),
          padding: EdgeInsets.symmetric(horizontal: 4),
          child: RichText(
            text: TextSpan(
              style: Theme.of(context).textTheme.caption!.copyWith(fontWeight: FontWeight.w600),
              children: [
                TextSpan(
                  text: widget.node.source,
                  style: _names.isEmpty ? null : TextStyle(color: Theme.of(context).accentColor),
                  recognizer: _names.isEmpty ? null : (TapGestureRecognizer()
                    ..onTap = () => setState(() => _names.clear())),
                ),
                ...List.generate(_names.length * 2, (i) {
                  if (i.isEven)
                    return TextSpan(text: ' > ');
                  return TextSpan(
                    text: _names[i ~/ 2],
                    style: i ~/ 2 + 1 == _names.length ? null : TextStyle(color: Theme.of(context).accentColor),
                    recognizer: i ~/ 2 + 1 == _names.length ? null : (TapGestureRecognizer()
                      ..onTap = () => setState(() => _names.removeRange(i ~/ 2 + 1, _names.length))),
                  );
                }),
              ],
            ),
          ),
        ),
        Expanded(
          child: Navigator(
            transitionDelegate: _NoAnimationTransitionDelegate(),
            pages: [
              MaterialPage(
                child: Padding(
                  padding: EdgeInsets.all(4),
                  child: ChildrenEditorView(widget.node, widget.onChanged),
                ),
              ),
              ...List.generate(_names.length, (i) {
                final path = _names.sublist(0, i + 1).join('.');
                return MaterialPage(
                  child: Padding(
                    padding: EdgeInsets.all(4),
                    child: buildEditorView(path, widget.node, widget.onChanged),
                  ),
                );
              }),
            ],
            onPopPage: (route, result) {
              if (!route.didPop(result))
                return false;
              setState(() => _names.removeLast());
              return true;
            },
          ),
        ),
      ],
    );
  }
}

// Everything bellow is boilerplate.
// See: https://medium.com/flutter/learning-flutters-new-navigation-and-routing-system-7c9068155ade
class _NoAnimationTransitionDelegate extends TransitionDelegate<void> {
  @override
  Iterable<RouteTransitionRecord> resolve({
    required List<RouteTransitionRecord> newPageRouteHistory,
    required Map<RouteTransitionRecord?, RouteTransitionRecord> locationToExitingPageRoute,
    required Map<RouteTransitionRecord?, List<RouteTransitionRecord>> pageRouteToPagelessRoutes,
  }) {
    final results = <RouteTransitionRecord>[];

    for (final pageRoute in newPageRouteHistory) {
      if (pageRoute.isWaitingForEnteringDecision) {
        pageRoute.markForAdd();
      }
      results.add(pageRoute);
    }

    for (final exitingPageRoute in locationToExitingPageRoute.values) {
      if (exitingPageRoute.isWaitingForExitingDecision) {
        exitingPageRoute.markForRemove();
        final pagelessRoutes = pageRouteToPagelessRoutes[exitingPageRoute];
        if (pagelessRoutes != null) {
          for (final pagelessRoute in pagelessRoutes) {
            pagelessRoute.markForRemove();
          }
        }
      }
      results.add(exitingPageRoute);
    }

    return results;
  }
}
