import 'package:flutter/cupertino.dart';
import 'package:formz/formz.dart';

class GridPaginator extends StatelessWidget {
  final FormzSubmissionStatus paginatorStatus;
  final Widget Function(BuildContext context, int index) itemBuilder;
  final int itemCount;
  final VoidCallback fetchMoreFunction;
  final bool hasMoreToFetch;
  final Widget errorWidget;
  final EdgeInsetsGeometry? padding;
  final Widget? emptyWidget;
  final Widget Function(BuildContext context, int index)? separatorBuilder;
  final Axis scrollDirection;
  final Widget? loadingWidget;
  final SliverGridDelegate gridDelegate;
  final ScrollPhysics? physics;
  final bool? shrinkWrap;

  const GridPaginator({
    required this.paginatorStatus,
    required this.itemBuilder,
    required this.itemCount,
    this.shrinkWrap,
    required this.fetchMoreFunction,
    required this.hasMoreToFetch,
    required this.errorWidget,
    required this.gridDelegate,
    this.padding,
    this.scrollDirection = Axis.vertical,
    this.separatorBuilder,
    this.emptyWidget,
    this.loadingWidget,
    this.physics,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (paginatorStatus == FormzSubmissionStatus.inProgress) {
      return loadingWidget ?? const Center(child: CupertinoActivityIndicator());
    } else if (paginatorStatus == FormzSubmissionStatus.failure) {
      return errorWidget;
    } else if (paginatorStatus == FormzSubmissionStatus.success) {
      return itemCount == 0
          ? emptyWidget ?? const SizedBox()
          : GridView.builder(
              gridDelegate: gridDelegate,
              scrollDirection: scrollDirection,
              physics: physics ?? const AlwaysScrollableScrollPhysics(),
              padding: padding ?? const EdgeInsets.only(bottom: 25),
              itemBuilder: (context, index) {
                if (itemCount == 0) {
                  return emptyWidget ?? const SizedBox.shrink();
                }
                if (index == itemCount) {
                  if (hasMoreToFetch) {
                    fetchMoreFunction();
                    return const Center(child: CupertinoActivityIndicator());
                  } else {
                    return const SizedBox();
                  }
                }
                return itemBuilder(context, index);
              },
              itemCount: (!hasMoreToFetch) ? itemCount + itemCount % 2 : itemCount + 1,
              shrinkWrap: shrinkWrap ?? true,
            );
    } else {
      return const SizedBox();
    }
  }
}
