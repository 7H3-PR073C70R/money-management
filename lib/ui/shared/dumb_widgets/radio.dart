import 'package:box_ui/box_ui.dart';
import 'package:flutter/material.dart';

class RadioButton extends StatelessWidget {
  final bool isSelected;
  final VoidCallback onTap;
  final String title;
  final dynamic value;
  final dynamic groupValue;
  final Function(dynamic value)? onChange;
  const RadioButton(
      {Key? key,
      required this.isSelected,
      required this.title,
      required this.onTap,
      required this.value,
      required this.groupValue,
      required this.onChange})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Radio<dynamic>(
              value: value,
              groupValue: groupValue,
              onChanged: onChange),
          Text(
            title,
            style: bodyStyle.copyWith(
                color: isSelected ? kcPrimaryColor : null),
          ),
          const Spacer(),
          if (isSelected)
            const Icon(
              Icons.check,
              color: kcPrimaryColor,
            )
        ],
      ),
    );
  }
}
