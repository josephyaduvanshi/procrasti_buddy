import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class SettingItemsCard extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  final String subtitle;
  final double? elevation;
  final IconData icon;
  final double? borderRadius;
  final Color? splashColor;
  final double? iconAllPadding;
  final double? iconPaddingOnlyRight;
  final double? iconPaddingOnlyLeft;
  final double? iconPaddingOnlyTop;
  final double? iconPaddingOnlyBottom;
  final double? cardPaddingOnlyRight;
  final double? cardPaddingOnlyLeft;
  final double? cardPaddingOnlyTop;
  final double? cardPaddingOnlyBottom;
  final double? cardPaddingAll;
  const SettingItemsCard(
      {Key? key,
      this.elevation,
      required this.title,
      required this.subtitle,
      this.borderRadius,
      this.splashColor,
      this.iconAllPadding,
      this.iconPaddingOnlyRight,
      this.iconPaddingOnlyLeft,
      this.iconPaddingOnlyTop,
      this.iconPaddingOnlyBottom,
      this.cardPaddingOnlyRight,
      this.cardPaddingOnlyLeft,
      this.cardPaddingOnlyTop,
      this.cardPaddingOnlyBottom,
      this.cardPaddingAll,
      required this.icon,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: elevation ?? 1,
      child: Material(
        borderRadius: BorderRadius.circular(borderRadius ?? 15),
        elevation: 1,
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(borderRadius ?? 15),
          splashColor: splashColor ?? context.primaryColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(icon).p(iconAllPadding ?? 10).pOnly(
                      right: iconPaddingOnlyRight ?? 5,
                      left: iconPaddingOnlyLeft ?? 0,
                      top: iconPaddingOnlyTop ?? 0,
                      bottom: iconPaddingOnlyBottom ?? 0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      title.text.medium.bold.make(),
                      2.heightBox,
                      subtitle.text.caption(context).make()
                    ],
                  ),
                ],
              ),
            ],
          ).p(5),
        ),
      ),
    ).p(cardPaddingAll ?? 5).pOnly(
        right: cardPaddingOnlyRight ?? 0,
        left: cardPaddingOnlyLeft ?? 0,
        top: cardPaddingOnlyTop ?? 0,
        bottom: cardPaddingOnlyBottom ?? 0);
  }
}
