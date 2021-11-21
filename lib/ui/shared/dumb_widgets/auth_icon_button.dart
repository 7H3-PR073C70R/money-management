import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../const_color_helper.dart';

class BuildAuthButtomIcon extends StatelessWidget {
  final String svgImagePath;
  final VoidCallback? onTap;
  const BuildAuthButtomIcon({Key? key, required this.svgImagePath, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: CircleAvatar(
          backgroundColor: kcNeutral9,
          child: Center(child: SvgPicture.asset(svgImagePath))),
    );
  }
}
