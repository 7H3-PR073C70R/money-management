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
  final int? maxLines;
  final TextInputType? keyboardType;
  final void Function()? onVisibility;
  final void Function(String value)? onChanged;
  final circularBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
  );
  BoxInputField(
      {Key? key,
      this.passwordVisibility = false,
      this.controller,
      this.placeHolder,
      this.onChanged,
      this.keyboardType,
      this.label,
      this.maxLines,
      this.isPassword = false,
      this.enabled = true,
      this.onVisibility})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (label != null)
          Column(
            children: [
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    label ?? '',
                    style: heading6Style.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: const Color.fromRGBO(73, 80, 90, 1)),
                  )),
              const SizedBox(
                height: 2,
              )
            ],
          ),
        Stack(
          children: [
            TextField(
              controller: controller,
              style: const TextStyle(height: 1),
              keyboardType: keyboardType,
              onChanged: onChanged,
              enabled: enabled,
              maxLines: maxLines,
              obscureText: passwordVisibility,
              decoration: InputDecoration(
                hintText: placeHolder,
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
                    onPressed: onVisibility,
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
