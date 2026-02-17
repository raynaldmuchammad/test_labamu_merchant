library alert;

import 'package:flutter/material.dart';
import 'package:mobile_app_labamu/core/app/palette.dart';
import 'package:mobile_app_labamu/core/constant/utils.dart';

SnackBar snackBarWidget({
  required BuildContext context,
  required String? message,
  required VoidCallback callback,
}) {
  return SnackBar(
    content: Text(message!),
    action: SnackBarAction(
      label: "Close",
      textColor: Palette.lightRed,
      onPressed: callback,
    ),
    margin: const EdgeInsets.all(Util.basePadding * 2),
    behavior: SnackBarBehavior.floating,
  );
}
