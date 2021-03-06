import 'package:box_ui/box_ui.dart';
import 'package:box_ui/src/shared/app_colors.dart';
import 'package:flutter/material.dart';

class BoxInputField extends StatelessWidget {
  final TextEditingController? controller;
  final String? placeHolder;
  final bool isPassword;
  final bool enabled;
  final bool passwordVisibility;
  final String? label;
  final FocusNode? focusNode;
  final int maxLines;
  final TextInputType? keyboardType;
  final void Function()? onVisibilityPressed;
  final void Function(String value)? onChanged;
  final String? Function(String?)? validator;
  const BoxInputField(
      {Key? key,
      this.passwordVisibility = false,
      this.controller,
      this.placeHolder,
      this.onChanged,
      this.keyboardType,
      this.validator,
      this.label,
      this.focusNode,
      this.maxLines = 1,
      this.isPassword = false,
      this.enabled = true,
      this.onVisibilityPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final circularBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
  );
    return Column(
      children: [
        if (label != null)
          Column(
            children: [
              Align(
                  alignment: Alignment.centerLeft,
                  child: BoxText.body(label ?? '',)),
              const SizedBox(
                height: 2,
              )
            ],
          ),
        Stack(
          children: [
            TextFormField(
              controller: controller,
              style: const TextStyle(height: 1),
              keyboardType: keyboardType,
              validator: validator,
              focusNode: focusNode,
              onChanged: onChanged,
              enabled: enabled,
              maxLines: maxLines,
              obscureText: passwordVisibility,
              decoration: InputDecoration(
                hintText: placeHolder,
                errorMaxLines: 3,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                border: circularBorder.copyWith(
                    borderSide: const BorderSide(color: kcMiniGray)),
                disabledBorder: circularBorder.copyWith(
                    borderSide: const BorderSide(color: kcMiniGray)),
                errorBorder: circularBorder.copyWith(
                    borderSide: const BorderSide(color: kcNegavitiveColor)),
              ),
            ),
            if (isPassword)
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                    onPressed: onVisibilityPressed,
                    icon: Icon(passwordVisibility
                        ? Icons.visibility_off
                        : Icons.visibility)),
              )
          ],
        ),
      ],
    );
  }
}
