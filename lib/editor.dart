import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_theme_editor/editor_children.dart';
import 'package:flutter_theme_editor/source_node.dart';
import 'package:flutter_theme_editor/source_node_widget.dart';

class Editor extends StatefulWidget {
  Editor(Key key, this.node, this.onChanged) : super(key: key);

  final SourceNode<ThemeData> node;

  final ValueChanged<SourceNode<ThemeData>> onChanged;

  static EditorState of(BuildContext context) =>
    context.findAncestorStateOfType<EditorState>()!;

  @override
  State<StatefulWidget> createState() => EditorState();
}

class EditorState extends State<Editor> {
  List<String> path = [];

  void push(String identifier) =>
    setState(() => path.add(identifier));

  void onChanged<T>(Iterable<String> path, SourceNode<T> node) =>
    widget.onChanged(widget.node.updateDescendant<T>(path.join('.'), node));

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) => Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            constraints: BoxConstraints(minHeight: 26),
            decoration: BoxDecoration(color: Theme.of(context).hoverColor),
            padding: EdgeInsets.all(4),
            child: RichText(
              text: TextSpan(
                style: Theme.of(context).textTheme.bodySmall!.copyWith(fontWeight: FontWeight.w600),
                children: [
                  TextSpan(
                    text: widget.node.source,
                    style: path.isEmpty ? null : TextStyle(color: Theme.of(context).colorScheme.secondary),
                    recognizer: path.isEmpty ? null : (TapGestureRecognizer()
                      ..onTap = () => setState(() => path.clear())),
                  ),
                  ...List.generate(path.length * 2, (i) {
                    if (i.isEven)
                      return TextSpan(text: ' > ');
                    return TextSpan(
                      text: path[i ~/ 2].split('#').last,
                      style: i ~/ 2 + 1 == path.length ? null : TextStyle(color: Theme.of(context).colorScheme.secondary),
                      recognizer: i ~/ 2 + 1 == path.length ? null : (TapGestureRecognizer()
                        ..onTap = () => setState(() => path.removeRange(i ~/ 2 + 1, path.length))),
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
                  ...List.generate(path.length, (i) {
                    final subpath = path.sublist(0, i + 1);
                    return MaterialPage(
                      child: Padding(
                        padding: EdgeInsets.all(4),
                        child: buildEditor(
                          context,
                          subpath,
                          subpath.fold(widget.node, (p, e) => p.children[e]!)),
                        ),
                      );
                  }),
                ],
                onPopPage: (route, result) {
                  if (!route.didPop(result))
                    return false;
                  setState(() => path.removeLast());
                  return true;
                },
              ),
            ),
          ),
        ],
      ),
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
