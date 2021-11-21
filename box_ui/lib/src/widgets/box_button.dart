import 'package:box_ui/box_ui.dart';
import 'package:box_ui/src/shared/app_colors.dart';
import 'package:flutter/material.dart';

class BoxButton extends StatelessWidget {
  final String title;
  final bool isBusy;
  final bool isLogin;
  final bool isSignUp;
  final void Function()? onTap;
  final Color? color;
  const BoxButton(
      {required this.title,
      this.isBusy = false,
      this.onTap,
      this.isLogin = false,
      this.isSignUp = false,
      this.color,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final buttonColor = isLogin
        ? Colors.white
        : isSignUp
            ? Colors.transparent
            : kcPrimaryColor;
    return InkWell(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 350),
        width: double.infinity,
        height: 48,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: color ?? buttonColor,
            border: Border.all(color: isSignUp ? Colors.white : kcPrimaryColor),
            borderRadius: BorderRadius.circular(8)),
        child: !isBusy
            ? BoxText.buttonStyle(
                title,
                color: isLogin ? kcPrimaryColor : Colors.white,
              )
            : const CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 8,
              ),
      ),
    );
  }
}
