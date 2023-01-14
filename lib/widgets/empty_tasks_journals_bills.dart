import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:procrasti_buddy/gen/assets.gen.dart';
import 'package:velocity_x/velocity_x.dart';

class EmptyHolderWidget extends StatelessWidget {
  final VoidCallback onTap;
  final String buttonTitle;
  final String title;
  final double? scaleFactor;

  const EmptyHolderWidget(
      {Key? key,
      required this.onTap,
      required this.buttonTitle,
      this.scaleFactor,
      required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        20.heightBox,
        Lottie.asset(Assets.lottie.empty),
        15.heightBox,
        title.text.scale(scaleFactor ?? 1.5).red400.bold.makeCentered(),
        15.heightBox,
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onPressed: () => onTap(),
          child: buttonTitle.text.center.make(),
        )
      ],
    );
  }
}
