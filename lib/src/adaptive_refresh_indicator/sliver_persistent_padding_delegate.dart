import "package:flutter/material.dart";
import "package:flutter/widgets.dart";

class SliverPersistentPaddingDelegate extends SliverPersistentHeaderDelegate {
  final EdgeInsets padding;

  SliverPersistentPaddingDelegate({required this.padding});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Padding(padding: padding);
  }

  @override
  double get maxExtent => padding.vertical;

  @override
  double get minExtent => maxExtent;

  @override
  bool shouldRebuild(covariant SliverPersistentPaddingDelegate oldDelegate) {
    return oldDelegate.padding != padding;
  }
}
