import 'package:box_ui/src/shared/app_colors.dart';
import 'package:flutter/material.dart';

class BoxInputField extends StatelessWidget {
  final TextEditingController? controller;
  final String placeHolder;
  final bool isPassword;
  final bool passwordVisibility;
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
      required this.placeHolder,
      this.onChanged,
      this.keyboardType,
      this.isPassword = false,
      this.onVisibility})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        TextField(
          controller: controller,
          style: const TextStyle(height: 1),
          keyboardType: keyboardType,
          onChanged: onChanged,
          obscureText: passwordVisibility,
          decoration: InputDecoration(
            hintText: placeHolder,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            border: circularBorder.copyWith(
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
                icon: Icon(
                    passwordVisibility ? Icons.visibility_off : Icons.visibility)),
          )
      ],
    );
  }
}
