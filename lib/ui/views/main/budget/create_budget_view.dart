import 'package:box_ui/box_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../app/app.router.dart';
import '../../../../constants/app_string.dart';
import '../../../shared/const_color_helper.dart';
import '../../../shared/const_ui_helper.dart';
import '../../../shared/dumb_widgets/build_label_container.dart';
import '../../../shared/dumb_widgets/nav_bar.dart';
import '../main_view_model.dart';
import 'package:stacked/stacked.dart';
import 'budget_view_model.dart';

class CreateBudgetView extends StatelessWidget {
  final BudgetViewModel model;
  const CreateBudgetView({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _args = ModalRoute.of(context)!.settings.arguments as CreateBudgetViewArguments;
    final argModel =  _args.model;
    return ViewModelBuilder<BudgetViewModel>.reactive(
      viewModelBuilder: () => BudgetViewModel(), builder: (context, model, child)=>Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: model.navigateBack,
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
                        onChanged: argModel.setAmount,
                        keyboardType: TextInputType.number),
                    verticalSpaceVeryTiny,
                    BuildLabelContainer(
                      label: 'Category',
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          alignment: Alignment.bottomCenter,
                          value: argModel.categoryValue,
                          underline: null,
                          isExpanded: true,
                          onTap: () {
                            FocusScope.of(context).unfocus();
                          },
                          onChanged:(index){
                             argModel.setCategoryValue(index);
                             model.setState();
                          },
                          menuMaxHeight: 250,
                          items: argModel.category
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
                        onTap: () async {
                          FocusScope.of(context).unfocus();
                          await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.utc(2020),
                                  lastDate: DateTime.utc(2100))
                              .then((value) => argModel.setDate(value!))
                              .onError((error, stackTrace) => null);
                          model.setState();
                        },
                        child: BuildLabelContainer(
                            label: 'Date',
                            child: Text(
                              argModel.date,
                              style: heading6Style.copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: kcNeutral2),
                            ))),
                    verticalSpaceVeryTiny,
                    BoxInputField(
                      label: 'Description',
                      maxLines: 5,
                      onChanged: argModel.setDescription,
                    ),
                    verticalSpaceMedium,
                    BoxButton(
                        title: 'Save',
                        isBusy: argModel.isBusy,
                        onTap: () {
                          argModel.createBudget();
                        })
                  ],
                )),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
