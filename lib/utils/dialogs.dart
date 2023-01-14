import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class DialogsProcrastiBudddy {
  static showBreakRequest(
      {required BuildContext context,
      required VoidCallback onTapYes,
      required VoidCallback onTapNo}) async {
    AlertDialog alert = AlertDialog(
      contentPadding: const EdgeInsets.all(12),
      content: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            "Want to take a short break?"
                .text
                .bold
                .xl2
                .make()
                .centered()
                .px(8)
                .pOnly(top: 8, bottom: 5),
            Divider(thickness: 1, color: context.primaryColor)
                .pOnly(top: 8)
                .px(8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Flexible(
                  child: ElevatedButton(
                    onPressed: onTapYes,
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: "Yes".text.make(),
                  ),
                ),
                Flexible(
                  child: ElevatedButton(
                    onPressed: onTapNo,
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: "No".text.make(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
    await showGeneralDialog(
      pageBuilder: (context, anim1, anim2) {
        return Container();
      },
      context: context,
      transitionBuilder: (ctx, a1, a2, child) {
        var curve = Curves.easeInOut.transform(a1.value);
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 04, sigmaY: 04),
          child: Transform.scale(
            scale: curve,
            child: Container(child: alert),
          ),
        );
      },
    );
  }
}
