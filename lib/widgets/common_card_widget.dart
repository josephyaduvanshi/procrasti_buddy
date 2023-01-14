import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:procrasti_buddy/utils/constants/constants.dart';
import 'package:procrasti_buddy/utils/utils.dart';
import 'package:velocity_x/velocity_x.dart';

class CommonCardWidget extends StatelessWidget {
  final String title;
  final String description;
  final String type;
  final DateTime date;
  final VoidCallback? onTap;
  final VoidCallback onDismissed;
  const CommonCardWidget({
    Key? key,
    this.onTap,
    required this.title,
    required this.description,
    required this.type,
    required this.date, required this.onDismissed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Slidable(
      dragStartBehavior: DragStartBehavior.start,
      key: Key(title),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        extentRatio: 0.25,
        children: [
          IconButton(
              onPressed: onDismissed,
              icon: const Icon(
                Icons.delete,
                size: 30,
                color: Colors.red,
              )),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Container(
          color: Color.alphaBlend(
            const Color.fromARGB(165, 255, 255, 255),
            isDarkMode
                ? Constants
                    .darkColors[Random().nextInt(Constants.darkColors.length)]
                : Constants.lightColors[
                    Random().nextInt(Constants.lightColors.length)],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              title.text.bold.xl
                  .color(Colors.black.withOpacity(0.8))
                  .overflow(TextOverflow.ellipsis)
                  .make()
                  .pOnly(top: 2),
              3.heightBox,
              Row(
                children: [
                  Expanded(
                    child: description.text
                        .color(isDarkMode
                            ? Colors.black.withOpacity(0.8)
                            : Colors.blueGrey.withOpacity(0.8))
                        .caption(context)
                        .medium
                        .overflow(TextOverflow.ellipsis)
                        .make(),
                  ),
                  Expanded(
                    child: type.text
                        .align(TextAlign.center)
                        .medium
                        .color(Colors.blueGrey)
                        .caption(context)
                        .make()
                        .box
                        .alignCenterRight
                        .make(),
                  ),
                ],
              ),
              3.heightBox,
              date.onlyTime.text.bold
                  .color(Colors.blueGrey.withOpacity(1))
                  .caption(context)
                  .make(),
            ],
          ).px(15).py(16),
        ),
      ).px(8).py(5).onTap(onTap),
    );
  }
}
