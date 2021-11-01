import 'package:box_ui/box_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:money_management/constants/app_string.dart';
import 'package:money_management/ui/shared/const_color_helper.dart';
import 'package:money_management/ui/shared/const_ui_helper.dart';
import 'package:money_management/ui/shared/dumb_widgets/build_label_container.dart';
import 'budget_view_model.dart';

class CreateBudgetView extends StatelessWidget {
  final BudgetViewModel model;
  const CreateBudgetView({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              model.setShowCreateBudget();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
        title: Text(
          budgetText,
          style: heading6Style.copyWith(
            color: Colors.black,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              verticalSpaceSmall,
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: screenWidth(context) * 0.05),
                child: Form(
                    child: Column(
                  children: [
                    BoxInputField(
                        label: 'Amount',
                        onChanged: model.setAmount,
                        keyboardType: TextInputType.number),
                    verticalSpaceVeryTiny,
                    BuildLabelContainer(
                      label: 'Category',
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          alignment: Alignment.bottomCenter,
                          value: model.categoryValue,
                          underline: null,
                          isExpanded: true,
                          onTap: () {
                            FocusScope.of(context).unfocus();
                          },
                          onChanged: model.setCategoryValue,
                          menuMaxHeight: 250,
                          items: model.category
                              .map<DropdownMenuItem<String>>(
                                  (String value) => DropdownMenuItem(
                                        value: value,
                                        child: Text(
                                          value,
                                          style: heading6Style.copyWith(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              color: kcNeutral2),
                                        ),
                                      ))
                              .toList(),
                        ),
                      ),
                    ),
                    verticalSpaceVeryTiny,
                    GestureDetector(
                        onTap: () {
                          FocusScope.of(context).unfocus();
                          showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.utc(2020),
                                  lastDate: DateTime.utc(2100))
                              .then((value) => model.setDate(value!))
                              .onError((error, stackTrace) => null);
                        },
                        child: BuildLabelContainer(
                            label: 'Date',
                            child: Text(
                              model.date,
                              style: heading6Style.copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: kcNeutral2),
                            ))),
                    verticalSpaceVeryTiny,
                    BoxInputField(
                      label: 'Description',
                      maxLines: 5,
                      onChanged: model.setDescription,
                    ),
                    verticalSpaceMedium,
                    BoxButton(
                        title: 'Save',
                        isBusy: model.isBusy,
                        onTap: () {
                          model.createBudget();
                        })
                  ],
                )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
