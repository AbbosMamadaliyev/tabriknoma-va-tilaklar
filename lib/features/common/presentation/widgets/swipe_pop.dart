import 'package:flutter/material.dart';

class SwipePop extends StatefulWidget {
  final Widget child;
  final VoidCallback? onPop;

  const SwipePop({required this.child, this.onPop, super.key});

  @override
  State<SwipePop> createState() => _SwipePopState();
}

class _SwipePopState extends State<SwipePop> {
  bool canPop = false;
  double lastX = 0;

  @override
  Widget build(BuildContext context) => GestureDetector(
        behavior: HitTestBehavior.opaque,
        onHorizontalDragEnd: (details) {
          if (canPop) {
            if (widget.onPop != null) {
              widget.onPop!();
            } else {
              Navigator.of(context).pop();
            }
          }
        },
        onHorizontalDragUpdate: (details) {
          if (lastX < details.localPosition.dx &&
              details.localPosition.dx < MediaQuery.of(context).size.width / 3 &&
              details.localPosition.dx > 0) {
            canPop = true;
          } else {
            canPop = false;
          }
          lastX = details.localPosition.dx;
        },
        child: widget.child,
      );
}
