import 'package:box_ui/box_ui.dart';
import 'package:flutter/material.dart';
import 'package:money_management/constants/app_string.dart';
import 'package:money_management/constants/enums.dart';
import 'package:money_management/ui/shared/const_ui_helper.dart';
import 'package:money_management/ui/shared/dumb_widgets/radio.dart';
import 'package:stacked/stacked.dart';

import 'change_currency_view_mode.dart';

class ChangeCurrencyView extends StatelessWidget {
  const ChangeCurrencyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ChangeCurrencyViewModel>.reactive(
      viewModelBuilder: () => ChangeCurrencyViewModel(),
      builder: (
        BuildContext context,
        ChangeCurrencyViewModel model,
        Widget? child,
      ) {
        return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  )),
              title: Text(
                selectCurrenctText,
                style: heading6Style.copyWith(
                  color: kcPrimaryColor,
                ),
              ),
              centerTitle: true,
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  verticalSpaceSmall,
                  Row(
                    children: [
                      BoxText.body(ngnText),
                      const Spacer(),
                      TextButton(
                        onPressed: model.setDefaultCurrency,
                        child: Text(
                          defaultText,
                          style: bodyStyle.copyWith(
                              color: kcPrimaryColor,
                              fontStyle: FontStyle.italic),
                        ),
                      )
                    ],
                  ),
                  verticalSpaceSmall,
                  Text(
                    changeDefaultCurrencyText,
                    style: bodyStyle.copyWith(color: kcPrimaryColor),
                  ),
                  verticalSpaceSmall,
                  SizedBox(
                      height: screenHeiht(context) * 0.6,
                      child: ListView.separated(
                          shrinkWrap: true,
                          itemBuilder: (context, index) => RadioButton(
                              isSelected: model.selectedIndex == index,
                              title: model.currenciesName[index],
                              onTap: () {
                                model.setSelectedCurrency(
                                    model.currencies[index]);
                              },
                              value: model.currencies[index],
                              groupValue: model.selectedCurrency,
                              onChange: (value) {
                                model.setSelectedCurrency(value!);
                              }),
                          separatorBuilder: (context, _) => const SizedBox(
                                height: 6,
                              ),
                          itemCount: model.currencies.length))
                ],
              ),
            ));
      },
    );
  }
}
