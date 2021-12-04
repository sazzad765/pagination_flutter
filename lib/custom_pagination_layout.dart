import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomPaginationLayout extends StatefulWidget {
  CustomPaginationLayout({
    Key? key,
    required this.onScrollFinish,
    required this.child,
    this.query,
    // required this.isComplete,
    // required this.onRefresh
  }) : super(key: key);

  // final void Function() onScrollfinish;
  // final Future<void> Function() onRefresh;
  final Widget child;
  // final bool isComplete;
  final Future<int> Function(Map<String, int> query) onScrollFinish;
  Map<String, int>? query;

  @override
  _CustomPaginationLayoutState createState() => _CustomPaginationLayoutState();
}

class _CustomPaginationLayoutState extends State<CustomPaginationLayout> {
  ScrollController _scrollController = new ScrollController();

  int limit = 20;
  int page = 1;
  bool isComplete = false;

  @override
  void initState() {
    scrollIndicator();
    WidgetsBinding.instance!.addPostFrameCallback((_) => fetch());
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void fetch() {
    final map = {'page': page, 'limit': limit};
    map.addAll(widget.query ?? {});
    widget.onScrollFinish(map).then((value) {
      print(value);
      if (value > 50) isComplete = true;
    });
  }

  void scrollIndicator() {
    _scrollController.addListener(
      () {
        if (_scrollController.offset >=
                _scrollController.position.maxScrollExtent &&
            !_scrollController.position.outOfRange) {
          if (!isComplete) {
            page += 1;
            fetch();
          }
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RefreshIndicator(
        onRefresh: () async {
          isComplete = false;
          page = 1;
          fetch();
        },
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: [
              widget.child,
              isComplete
                  ? Container()
                  : Container(
                      height: 80,
                      child: Center(child: CircularProgressIndicator())),
            ],
          ),
        ),
      ),
    );
  }
}
