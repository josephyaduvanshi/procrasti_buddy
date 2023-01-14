import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';

class HumanMessagePromptWidget extends StatelessWidget {
  final String? message;
  const HumanMessagePromptWidget({Key? key, required this.message})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = context.isDarkMode;
    return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            "Procrasti Buddy".text.bold.xl2.make().px(8).shimmer(
                primaryColor: Colors.blue,
                secondaryColor: Colors.purple,
                duration: const Duration(seconds: 5)),
            (message.isEmptyOrNull
                    ? "Hello, I am ProcrastiBuddy. I am here to help you with your procrastination and overall perosonal management. Go ahead and ask me anything."
                    : message)
                .toString()
                .text
                .lg
                .textStyle(GoogleFonts.roboto(fontWeight: FontWeight.w500))
                .make()
                .px(10)
                .py(8)
                .box
                .withDecoration(BoxDecoration(
                    color: isDarkMode ? Colors.blue[400] : Colors.blue[100],
                    borderRadius: BorderRadius.circular(10)))
                .make()
                .px(8),
          ],
        ));
  }
}
