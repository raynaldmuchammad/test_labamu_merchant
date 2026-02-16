import 'package:flutter/material.dart';
import 'package:mobile_app_labamu/core/constant/utils.dart';
import 'package:mobile_app_labamu/core/app/palette.dart';

Future showProgressDialog({
  required BuildContext context,
  bool isDismissible = false,
}) {
  return showDialog(
    context: context,
    barrierDismissible: isDismissible,
    barrierColor: Palette.black.withOpacity(0.45),
    builder: (context) => PopScope(
      canPop: isDismissible,
      child: Dialog(
        elevation: 0,
        insetPadding: EdgeInsets.all(Util.basePaddingMargin64),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Util.basePaddingMargin10),
        ),
        child: Builder(
          builder: (context) => Container(
            width: Util.baseWidthHeight100,
            height: Util.baseWidthHeight110,
            decoration: BoxDecoration(
              color: Palette.white,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  child: Text(
                    "Loading...",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(height: Util.baseWidthHeight16),
                Container(
                  width: Util.baseWidthHeight38,
                  height: Util.baseWidthHeight38,
                  child: CircularProgressIndicator(
                    color: Palette.red,
                    backgroundColor: Palette.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

Widget circularProgress(BuildContext context) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CircularProgressIndicator(
          color: Palette.red,
          backgroundColor: Palette.white,
        )
      ],
    ),
  );
}
