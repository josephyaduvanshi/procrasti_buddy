import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';

class ShowSnackBar {
  static materialSnackbar(
      {required BuildContext context,
      required String title,
      required String message,
      ContentType? type}) {
    final materialBanner = SnackBar(
      elevation: 4,
      duration: const Duration(seconds: 1),
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: title,
        message: message,
        contentType: type ?? ContentType.success,
        inMaterialBanner: true,
      ),
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentMaterialBanner()
      ..showSnackBar(materialBanner);
  }
}
