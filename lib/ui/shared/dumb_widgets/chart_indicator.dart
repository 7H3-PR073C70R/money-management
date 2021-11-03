import 'package:box_ui/box_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:intl/intl.dart';
import 'package:money_management/app/app.locator.dart';
import 'package:money_management/service/user_service.dart';
import 'package:money_management/ui/shared/const_ui_helper.dart';

class ChartIndicator extends StatelessWidget {
  final Color color;
  final double amount;
  final String value;
  const ChartIndicator(
      {Key? key,
      required this.color,
      required this.amount,
      required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
     final currencySymbol = locator<UserService>().currency;
    return Row(children: [
      Container(
        height: 20,
        width: 20,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: color),
      ),
      horizontalSpaceSmall,
      Text(value,
          style: heading6Style.copyWith(
              fontWeight: FontWeight.w400, fontSize: 16)),
      const Spacer(),
      SizedBox(
        width: screenWidth(context) * 0.3,
        child: Text('$currencySymbol${NumberFormat('#,###.##').format(amount)}',
            maxLines: 2,
            textAlign: TextAlign.right,
            overflow: TextOverflow.ellipsis,
            style: heading6Style.copyWith(
                fontWeight: FontWeight.w400, fontSize: 16)),
      )
    ]);
  }
}
