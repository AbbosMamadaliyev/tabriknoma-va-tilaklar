import 'package:flutter/material.dart';
import 'package:formz/formz.dart';

class Paginator extends StatelessWidget {
  final FormzSubmissionStatus paginatorStatus;
  final Widget Function(BuildContext context, int index) itemBuilder;
  final Widget Function(BuildContext context, int index)? separatorBuilder;
  final Widget? emptyBuilder;
  final int itemCount;
  final VoidCallback fetchMoreFunction;
  final bool hasMoreToFetch;
  final Widget? errorWidget;
  final ScrollPhysics? physics;
  final bool shrinkWrap;
  final EdgeInsets? padding;
  final ScrollController? controller;
  final Axis? scrollDirection;

  const Paginator(
      {required this.paginatorStatus,
      required this.itemBuilder,
      this.separatorBuilder,
      this.errorWidget,
      required this.itemCount,
      required this.fetchMoreFunction,
      required this.hasMoreToFetch,
      this.shrinkWrap = false,
      this.padding,
      Key? key,
      this.physics,
      this.controller,
      this.scrollDirection,
      this.emptyBuilder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (paginatorStatus == FormzSubmissionStatus.inProgress) {
      return const Center(child: CircularProgressIndicator.adaptive(backgroundColor: Colors.transparent));
    } else if (paginatorStatus == FormzSubmissionStatus.failure) {
      return errorWidget ?? const SizedBox.shrink();
    } else if (paginatorStatus == FormzSubmissionStatus.success) {
      if (itemCount == 0) {
        return emptyBuilder ?? const SizedBox.shrink();
      } else {
        return ListView.separated(
          controller: controller,
          padding: padding,
          shrinkWrap: shrinkWrap,
          physics: physics ?? const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            if (index == itemCount) {
              if (hasMoreToFetch) {
                fetchMoreFunction();
                return const Center(child: CircularProgressIndicator.adaptive(backgroundColor: Colors.transparent));
              } else {
                return const SizedBox();
              }
            }
            return itemBuilder(context, index);
          },
          itemCount: itemCount + 1,
          separatorBuilder: separatorBuilder ?? (context, index) => const SizedBox(height: 24),
          scrollDirection: scrollDirection ?? Axis.vertical,
        );
      }
    } else {
      return const SizedBox.shrink();
    }
  }
}

enum PaginatorStatus {
  PAGINATOR_LOADING,
  PAGINATOR_SUCCESS,
  PAGINATOR_ERROR,
}
