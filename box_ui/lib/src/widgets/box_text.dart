// ignore_for_file: use_key_in_widget_constructors

import 'package:box_ui/src/shared/app_colors.dart';
import 'package:box_ui/src/shared/styles.dart';
import 'package:flutter/material.dart';

class BoxText extends StatelessWidget {
  final String text;
  final TextStyle style;

  BoxText.headingOne(this.text, {Color color = kcMediumGray}) : style = heading1Style.copyWith(color: color);
  BoxText.headingTwo(this.text, {Color color = kcMediumGray}) : style = heading2Style.copyWith(color: color);
  BoxText.headingThree(this.text, {Color color = kcMediumGray}) : style = heading3Style.copyWith(color: color);
  BoxText.headingFour(this.text, {Color color = kcMediumGray}) : style = heading4Style.copyWith(color: color);
  BoxText.headingFive(this.text, {Color color = kcMediumGray}) : style = heading5Style.copyWith(color: color);
  BoxText.headingSix(this.text, {Color color = kcMediumGray}) : style = heading6Style.copyWith(color: color);
  BoxText.body(this.text, {Color color = kcMediumGray}) : style = bodyStyle.copyWith(color: color);
  BoxText.buttonStyle(this.text, {Color color = kcMediumGray}) : style = buttonStyle.copyWith(color: color);

  @override
  Widget build(BuildContext context) {
    return Text(
      text, style: style,
    );
  }
}