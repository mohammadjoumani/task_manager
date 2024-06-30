import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

enum MessageType { error, success, info }

void showMessage({
  required BuildContext context,
  required String message,
  MessageType messageType = MessageType.error,
}) {
  switch (messageType) {
    case MessageType.error:
      showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.error(
          message: message,
        ),
      );
      break;
    case MessageType.success:
      showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.success(
          message: message,
        ),
      );
      break;
    case MessageType.info:
      showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.info(
          message: message,
        ),
      );
      break;
  }
}

//
// void showMessage({
//   required String message,
//   bool isError = true,
// }) {
//   final mContext = navigatorKey!.currentState!.context;
//   ScaffoldMessenger.of(mContext).removeCurrentSnackBar();
//   ScaffoldMessenger.of(mContext).showSnackBar(
//     SnackBar(
//       behavior: SnackBarBehavior.floating,
//       shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadius.all(Radius.circular(5))),
//       duration: const Duration(milliseconds: 2000),
//       backgroundColor: isError ? Colors.red : ColorManager.colorPrimary,
//       content: Center(
//         child: Text(
//           message,
//           style: Styles.getMediumStyle(
//             color: ColorManager.colorWhite,
//           ).copyWith(fontFamily: FontConstants.fontCairo),
//         ),
//       ),
//     ),
//   );
// }
