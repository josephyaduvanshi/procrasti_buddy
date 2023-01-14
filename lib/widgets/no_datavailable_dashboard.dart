import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:velocity_x/velocity_x.dart';

class NoDataAvailableDashboardWidget extends StatelessWidget {
  final String title;
  final String buttonTitle;
  final VoidCallback onPressed;
  final String imageAsset;
  const NoDataAvailableDashboardWidget(
      {Key? key,
      required this.title,
      required this.buttonTitle,
      required this.imageAsset,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(
          imageAsset,
          width: MediaQuery.of(context).size.width * 0.5,
          height: MediaQuery.of(context).size.height * 0.1,
        ).pOnly(top: 20),
        title.text.make().px(9).pOnly(bottom: 8).px(7).pOnly(top: 12),
        OutlinedButton(
          onPressed: onPressed,
          style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: buttonTitle.text.make(),
        ).px(8),
      ],
    );
  }
}
