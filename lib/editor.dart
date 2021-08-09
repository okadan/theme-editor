import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:theme_editor/editor_children.dart';
import 'package:theme_editor/source_node.dart';

class Editor extends StatefulWidget {
  Editor(this.node, this.onChanged);

  final SourceNode<ThemeData> node;

  final ValueChanged<SourceNode<ThemeData>> onChanged;

  static EditorState of(BuildContext context) =>
    context.findAncestorStateOfType<EditorState>()!;

  @override
  State<StatefulWidget> createState() => EditorState();
}

class EditorState extends State<Editor> {
  List<String> _path = [];

  void push(String identifier) =>
    setState(() => _path.add(identifier));

  void onChanged<T>(Iterable<String> path, SourceNode<T> node) =>
    widget.onChanged(widget.node.updateDescendant<T>(path.join('.'), node));

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          constraints: BoxConstraints(minHeight: 26),
          decoration: BoxDecoration(color: Theme.of(context).hoverColor),
          padding: EdgeInsets.all(4),
          child: RichText(
            text: TextSpan(
              style: Theme.of(context).textTheme.caption!.copyWith(fontWeight: FontWeight.w600),
              children: [
                TextSpan(
                  text: widget.node.source,
                  style: _path.isEmpty ? null : TextStyle(color: Theme.of(context).accentColor),
                  recognizer: _path.isEmpty ? null : (TapGestureRecognizer()
                    ..onTap = () => setState(() => _path.clear())),
                ),
                ...List.generate(_path.length * 2, (i) {
                  if (i.isEven)
                    return TextSpan(text: ' > ');
                  return TextSpan(
                    text: extractName(_path[i ~/ 2]),
                    style: i ~/ 2 + 1 == _path.length ? null : TextStyle(color: Theme.of(context).accentColor),
                    recognizer: i ~/ 2 + 1 == _path.length ? null : (TapGestureRecognizer()
                      ..onTap = () => setState(() => _path.removeRange(i ~/ 2 + 1, _path.length))),
                  );
                }),
              ],
            ),
          ),
        ),
        Expanded(
          child: ClipRect(
            child: Navigator(
              transitionDelegate: _NoAnimationTransitionDelegate(),
              pages: [
                MaterialPage(
                  child: Padding(
                    padding: EdgeInsets.all(4),
                    child: ChildrenEditor<ThemeData>([], widget.node),
                  ),
                ),
                ...List.generate(_path.length, (i) {
                  final path = _path.sublist(0, i + 1);
                  return MaterialPage(
                    child: Padding(
                      padding: EdgeInsets.all(4),
                      child: buildEditor(
                        path,
                        path.join('.').split('.').fold(widget.node, (p, e) => p.children[e]!)),
                      ),
                    );
                }),
              ],
              onPopPage: (route, result) {
                if (!route.didPop(result))
                  return false;
                setState(() => _path.removeLast());
                return true;
              },
            ),
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
