import 'package:box_ui/box_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:money_management/ui/shared/const_ui_helper.dart';
import 'package:money_management/ui/shared/dumb_widgets/statusbar.dart';


class AddNoteView extends StatelessWidget {
  const AddNoteView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
        return StatusBar(
            child: Scaffold(
                appBar: AppBar(
                  leading: IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                      )),
                  title: Text(
                    'Add Notes',
                    style: heading6Style.copyWith(
                      color: Colors.black,
                    ),
                  ),
                  actions: [
                    TextButton(onPressed: (){}, child: Text(
                            'Save',
                            style: heading6Style.copyWith(color: kcPrimaryColor,fontWeight: FontWeight.w400),
                          ))
                  ],
                ),
                body: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 35.0),
                  child: SingleChildScrollView(
                    child: Form(
                        child: Column(
                      children: [
                        TextFormField(
                          decoration: InputDecoration(
                              label: Text(
                            'Title',
                            style: heading6Style.copyWith(),
                          )),
                        ),
                        verticalSpaceVeryTiny,
                        TextFormField(
                          scrollPadding: const EdgeInsets.all(20.0),
                          keyboardType: TextInputType.multiline,
                          maxLines: 100,
                          decoration: InputDecoration(
                              hintStyle: heading6Style.copyWith(),
                              hintText: 'Enter Text',
                              border: const OutlineInputBorder(
                                  borderSide: BorderSide.none)),
                        ),
                      ],
                    )),
                  ),
                )));
}
}