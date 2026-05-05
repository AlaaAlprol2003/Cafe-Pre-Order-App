import 'package:dash_cup/core/resources/colors_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toastification/toastification.dart';

class UiUtils {
  static void showLoading({required BuildContext context}) {
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) => AlertDialog(
        content: PopScope(
          canPop: false,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(color: ColorsManager.darkChocolate),
              ],
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
      ),
    );
  }

  static void hideLoading({required BuildContext context}) {
    Navigator.pop(context);
  }

  static void showMessage({
    required BuildContext context,
    ToastificationType type = ToastificationType.success,
    required String message,
    IconData icon = Icons.check_circle,
    Color bgColor = ColorsManager.charcoalBlue,
    Color fgColor = ColorsManager.white,
  }) {
    toastification.show(
      context: context,
      type: type,
      style: ToastificationStyle.flat,
      autoCloseDuration: const Duration(seconds: 5),
      title: Text(
        message,
        style: GoogleFonts.roboto(fontSize: 16.sp, color: ColorsManager.white),
      ),

      alignment: Alignment.topCenter,
      direction: TextDirection.ltr,

      icon: Icon(icon),
      showIcon: true,

      backgroundColor: bgColor,
      foregroundColor: fgColor,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      borderRadius: BorderRadius.circular(12),
      boxShadow: const [
        BoxShadow(
          color: Color(0x07000000),
          blurRadius: 16,
          offset: Offset(0, 16),
          spreadRadius: 0,
        ),
      ],
      showProgressBar: true,
      closeButton: ToastCloseButton(
        showType: CloseButtonShowType.onHover,
        buttonBuilder: (context, onClose) {
          return OutlinedButton.icon(
            onPressed: onClose,
            icon: const Icon(Icons.close, size: 20),
            label: const Text('Close'),
          );
        },
      ),
      closeOnClick: true,

      dragToClose: true,
      applyBlurEffect: true,
      borderSide: BorderSide(color: ColorsManager.burntOrange),
    );
  }
}
