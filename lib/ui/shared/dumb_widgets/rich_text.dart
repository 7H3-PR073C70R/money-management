import 'package:box_ui/box_ui.dart';
import 'package:flutter/material.dart';

class RichTexts extends StatelessWidget {
  final String? text1;
  final String text2;
  const RichTexts(this.text1, this.text2, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
          text: text1,
          style: heading4Style.copyWith(color: kcSecondaryColor),
          children: [
            TextSpan(
                text: ' $text2',
                style: heading4Style.copyWith(color: kcMaxGray))
          ]),
    );
  }
}
