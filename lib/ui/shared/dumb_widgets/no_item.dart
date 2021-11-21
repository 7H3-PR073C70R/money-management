import 'package:box_ui/box_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../constants/app_image_path.dart';
import '../const_ui_helper.dart';

class NoItem extends StatelessWidget {
  final String text;
  final String? buttonText;
  final VoidCallback? onTap;
  const NoItem({Key? key, required this.text, this.onTap, this.buttonText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(noItemSvg),
          verticalSpaceMedium,
          Text(text,
          maxLines: 3,
              style: heading6Style.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center),
              verticalSpaceSmall,
        if(buttonText != null)
          BoxButton(
            title: buttonText!,
            onTap: onTap,
          )
        ],
      ),
    );
  }
}
