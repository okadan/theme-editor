import 'package:flutter/material.dart';
import 'package:flutter_theme_editor/constants.dart' as constants;

class BarsPreview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _AppBarPreview(),
        SizedBox(height: constants.previewLayoutGap),
        _BottomNavigationBarPreview(),
        SizedBox(height: constants.previewLayoutGap),
        _BottomAppBarPreview(),
        SizedBox(height: constants.previewLayoutGap),
        _SnackBarPreview(),
      ],
    );
  }
}

class _AppBarPreview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
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
    );
  }
}

class _BottomNavigationBarPreview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Item'),
        BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Item'),
        BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Item'),
      ],
    );
  }
}

class _BottomAppBarPreview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Row(
        children: [
          IconButton(icon: Icon(Icons.star), onPressed: () {}),
          IconButton(icon: Icon(Icons.star), onPressed: null),
        ],
      ),
    );
  }
}

class _SnackBarPreview extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SnackBarPreviewState();
}

class _SnackBarPreviewState extends State<_SnackBarPreview> {
  bool isShown = false;

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: true,
      child: SizedBox(
        height: 46,
        child: ScaffoldMessenger(
          child: Scaffold(
            body: Builder(
              builder: (context) {
                if (!isShown) {
                  isShown = true;
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      duration: Duration(days: 1),
                      content: Text('SnackBar'),
                      action: SnackBarAction(label: 'Action', onPressed: () {}),
                    ));
                  });
                }
                return SizedBox.shrink();
              },
            ),
          ),
        ),
      ),
    );
  }
}
