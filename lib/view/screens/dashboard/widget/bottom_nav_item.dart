import 'package:flutter/material.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/styles.dart';

class BottomNavItem extends StatelessWidget {
  final String selectedIcon;
  final String unSelectedIcon;
  final String title;
  final Function? onTap;
  final bool isSelected;
  final bool hasOrders;
  const BottomNavItem({
    Key? key,
    this.onTap,
    this.isSelected = false,
    required this.title,
    required this.selectedIcon,
    required this.unSelectedIcon,
    this.hasOrders = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InkWell(
          onTap: onTap as void Function()?,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Image.asset(
              isSelected ? selectedIcon : unSelectedIcon,
              height: 25,
              width: 25,
              color: isSelected
                  ? Theme.of(context).primaryColor
                  : Colors.grey.shade700,
            ),
            SizedBox(
                height: isSelected
                    ? Dimensions.paddingSizeExtraSmall
                    : Dimensions.paddingSizeSmall),
            Text(
              title,
              style: robotoRegular.copyWith(
                  color: isSelected
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).textTheme.bodyMedium!.color!,
                  fontSize: 12),
            ),
          ]),
        ), 

        if(hasOrders) 
       const  Positioned(
            right: 6,
            top: 10,
            child: CircleAvatar(
              radius: 4,
              backgroundColor: Colors.red,
            ))
      ],
    );
  }
}
