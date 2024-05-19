import 'package:sixam_mart/helper/responsive_helper.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:flutter/material.dart';

class ItemShimmer extends StatelessWidget {
  final bool isEnabled;
  final bool isStore;
  final bool hasDivider;
  const ItemShimmer(
      {Key? key,
      required this.isEnabled,
      required this.hasDivider,
      this.isStore = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool desktop = ResponsiveHelper.isDesktop(context);

    return Container(
      height: 300,
                  width: 180,
      padding: ResponsiveHelper.isDesktop(context)
          ? const EdgeInsets.all(Dimensions.paddingSizeSmall)
          : null,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
        color: ResponsiveHelper.isDesktop(context)
            ? Theme.of(context).cardColor
            : null,
        boxShadow: ResponsiveHelper.isDesktop(context)
            ? [
                const BoxShadow(
                  color: Colors.black12,
                  spreadRadius: 1,
                  blurRadius: 5,
                )
              ]
            : null,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: desktop ? 0 : Dimensions.paddingSizeExtraSmall,
              ),
              child: Row(children: [
                Container(
                  height: 300,
                  width: 180,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                    color: Colors.grey[300],
                  ),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
