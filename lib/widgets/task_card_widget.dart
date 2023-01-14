import 'dart:math';

import 'package:flutter/material.dart';
import 'package:procrasti_buddy/utils/constants/constants.dart';
import 'package:procrasti_buddy/utils/utils.dart';
import 'package:velocity_x/velocity_x.dart';

import '../database/task_manager/task_manager.dart';

class TaskCardWidget extends StatelessWidget {
  final TaskModel taskModel;
  final VoidCallback? onTap;
  const TaskCardWidget({Key? key, this.onTap, required this.taskModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Container(
        color: Color.alphaBlend(
          const Color.fromARGB(165, 255, 255, 255),
          isDarkMode
              ? Constants
                  .darkColors[Random().nextInt(Constants.darkColors.length)]
              : Constants
                  .lightColors[Random().nextInt(Constants.lightColors.length)],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            taskModel.title.text.bold.xl
                .color(Colors.black.withOpacity(0.8))
                .overflow(TextOverflow.ellipsis)
                .make()
                .pOnly(top: 2),
            3.heightBox,
            Row(
              children: [
                Expanded(
                  child: taskModel.description.text
                      .color(isDarkMode
                          ? Colors.black.withOpacity(0.8)
                          : Colors.blueGrey.withOpacity(0.8))
                      .caption(context)
                      .medium
                      .overflow(TextOverflow.ellipsis)
                      .make(),
                ),
                Expanded(
                  child: '${taskModel.type}'
                      .text
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
            taskModel.date.onlyTime.text.bold
                .color(Colors.blueGrey.withOpacity(1))
                .caption(context)
                .make(),
          ],
        ).px(15).py(16),
      ),
    ).px(8).py(5).onTap(onTap);
  }
}
