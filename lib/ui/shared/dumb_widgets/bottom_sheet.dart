import 'package:box_ui/box_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:money_management/constants/app_image_path.dart';
import 'package:money_management/constants/app_string.dart';
import '../const_color_helper.dart';
import '../const_ui_helper.dart';


class BuildBottomSheet extends StatelessWidget {
  final int selectedFilterIndex;
  final Function(int index) setSelectedFilterIndex;
  final VoidCallback setShowBottomSheet;
  BuildBottomSheet(
      {Key? key,
      required this.selectedFilterIndex,
      required this.setSelectedFilterIndex,
      required this.setShowBottomSheet})
      : super(key: key);

  final List<String> _date = [
    DateFormat('MMM dd').format(DateTime.now()),
    DateFormat('MMM dd')
        .format(DateTime.now().subtract(const Duration(days: 1))),
    '${DateFormat('MMM dd').format(DateTime.now().subtract(Duration(days: DateTime.now().weekday)))} - ${DateFormat('MMM dd').format(DateTime.now())}',
  ];

  String getMonth() {
    final int _currentMonthIndex = DateTime.now().month;
    switch (_currentMonthIndex) {
      case 1:
        return 'Jan 1 - 31';
      case 2:
        return 'Feb 1 - 29';
      case 3:
        return 'Mar 1 - 31';
      case 4:
        return 'Apr 1 - 30';
      case 5:
        return 'May 1 - 31';
      case 6:
        return 'Jun 1 - 30';
      case 7:
        return 'Jul 1 - 31';
      case 8:
        return 'Aug 1 - 31';
      case 9:
        return 'Sep 1 - 31';
      case 10:
        return 'Oct 1 - 31';
      case 11:
        return 'Nov 1 - 30';
      case 12:
        return 'Dec 1 - 31';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
          height: screenHeiht(context) * 0.45,
          padding: const EdgeInsets.symmetric(vertical: 15),
          decoration: const BoxDecoration(
              borderRadius: 
              BorderRadius.only(
                  topRight: Radius.circular(30), topLeft: Radius.circular(30)),
              color: Colors.white
              ),
          child: Column(
            children: [
              Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: IconButton(
                        icon: const Icon(
                          Icons.close,
                          size: 25,
                        ),
                        onPressed: setShowBottomSheet),
                  )),
              BoxText.headingSix(filterByDateText),
              verticalSpaceVeryTiny,
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Filter(
                      text: todayText,
                      date: _date[0],
                      isSelected: selectedFilterIndex == 0,
                      onTap: () => setSelectedFilterIndex(0),
                    ),
                    Filter(
                      text: yesterdayText,
                      date: _date[1],
                      isSelected: selectedFilterIndex == 1,
                      onTap: () => setSelectedFilterIndex(1),
                    ),
                    Filter(
                      text: thisWeekText,
                      date: _date[2],
                      isSelected: selectedFilterIndex == 2,
                      onTap: () => setSelectedFilterIndex(2),
                    ),
                    Filter(
                      text: lastMonthText,
                      date: getMonth(),
                      isSelected: selectedFilterIndex == 3,
                      onTap: () => setSelectedFilterIndex(3),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      }
      }


class Filter extends StatelessWidget {
  final String text, date;
  final bool isSelected;
  final VoidCallback? onTap;
  const Filter(
      {Key? key,
      required this.text,
      required this.date,
      this.isSelected = false,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 37.0),
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          children: [
            SvgPicture.asset(
              calenderSvg,
              height: 20,
              width: 15,
              fit: BoxFit.cover,
            ),
            horizontalSpaceSmall,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  text,
                  style: heading6Style.copyWith(
                      fontSize: 15, color: kcPrimaryColor),
                ),
                Text(
                  date,
                  style:
                      heading6Style.copyWith(fontSize: 15, color: kcNeutral5),
                ),
              ],
            ),
            const Spacer(),
            if (isSelected)
              const Padding(
                  padding: EdgeInsets.only(),
                  child: Icon(
                    Icons.check,
                    color: kcPrimaryColor,
                  ))
          ],
        ),
      ),
    );
  }
}
