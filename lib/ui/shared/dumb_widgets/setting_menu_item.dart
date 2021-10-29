import 'package:box_ui/box_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../const_ui_helper.dart';

class SettingsMenuItem extends StatelessWidget {
  final String imgPath, text;
  final VoidCallback onTap;
  final bool showArrow;
  const SettingsMenuItem({ Key? key, required this.imgPath, required this.text, this.showArrow = true, required this.onTap }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          SvgPicture.asset(imgPath),
          horizontalSpaceSmall,
          BoxText.body(text),
          const Spacer(),
          if(showArrow)
          const Icon(Icons.arrow_forward_ios, size: 18,)
        ],
      ),
    );
  }
}
