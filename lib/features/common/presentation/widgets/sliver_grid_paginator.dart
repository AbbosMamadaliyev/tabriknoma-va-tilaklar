import 'package:flutter/cupertino.dart';
import 'package:formz/formz.dart';

class SliverGridPaginator extends StatelessWidget {
  final FormzSubmissionStatus listStatus;
  final FormzSubmissionStatus paginationStatus;
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

  const SliverGridPaginator({
    required this.listStatus,
    required this.itemBuilder,
    required this.itemCount,
    required this.fetchMoreFunction,
    required this.hasMoreToFetch,
    required this.errorWidget,
    required this.gridDelegate,
    required this.paginationStatus,
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
    if (listStatus == FormzSubmissionStatus.inProgress) {
      return SliverToBoxAdapter(child: loadingWidget ?? const SizedBox());
    } else if (listStatus == FormzSubmissionStatus.failure) {
      return SliverToBoxAdapter(child: errorWidget);
    } else if (listStatus == FormzSubmissionStatus.success) {
      return SliverGrid.builder(
        gridDelegate: gridDelegate,
        itemBuilder: (context, index) {
          if (itemCount == 0) {
            return emptyWidget ?? const SizedBox.shrink();
          }
          if (index == itemCount-1) {
            if (hasMoreToFetch) {
              fetchMoreFunction();
            }
          }
          return itemBuilder(context, index);
        },
        itemCount: itemCount,
      );
    } else {
      return const SliverToBoxAdapter(child: SizedBox());
    }
  }
}
