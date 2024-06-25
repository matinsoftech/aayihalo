import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/styles.dart';

class PortionWidget extends StatelessWidget {
  final String icon;
  final String title;
  final bool hideDivider;
  final String route;
  final String? suffix;
  const PortionWidget({
    Key? key,
    required this.icon,
    required this.title,
    required this.route,
    this.hideDivider = false,
    this.suffix,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.toNamed(route),
      child: Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
          border: Border.all(width: 0.4),
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  height: 28,
                  width: 28,
                  child: Image.asset(
                    icon,
                    fit: BoxFit.cover,
                    filterQuality: FilterQuality.high,
                  ),
                ),
                const SizedBox(width: Dimensions.paddingSizeSmall),
                Expanded(child: Text(title, style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeLarge))),
                suffix != null
                    ? Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.error,
                          borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeExtraSmall, horizontal: Dimensions.paddingSizeSmall),
                        child: Text(
                          suffix!,
                          style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Colors.white),
                          textDirection: TextDirection.ltr,
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
            // hideDivider ? const SizedBox() : const Divider()
          ],
        ),
      ),
    );
  }
}
