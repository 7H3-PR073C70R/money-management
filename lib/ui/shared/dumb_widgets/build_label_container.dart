import 'package:box_ui/box_ui.dart';
import 'package:flutter/material.dart';

import '../const_color_helper.dart';
import '../const_ui_helper.dart';

class BuildLabelContainer extends StatelessWidget {
  final Widget child;
  final String label;
  const BuildLabelContainer(
      {Key? key, required this.label, required this.child,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Column(
        children: [
          Align(
              alignment: Alignment.centerLeft,
              child: Text(
                label,
                style: heading6Style.copyWith(
                    fontSize: 16, fontWeight: FontWeight.w400, color: kcNeutral3),
              )),
          verticalSpaceVeryTiny,
          Container(
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: kcNeutral4)),
              alignment: Alignment.centerLeft,
              padding:
                  EdgeInsets.symmetric(horizontal: screenWidth(context) * 0.05),
              child: child)
        ],
      ),
    );
  }
}
