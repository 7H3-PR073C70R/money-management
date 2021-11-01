import 'package:box_ui/box_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:money_management/model/note_model.dart';
import 'package:money_management/ui/shared/const_ui_helper.dart';
import 'package:money_management/ui/shared/dumb_widgets/statusbar.dart';
import 'package:money_management/ui/views/main/main_views/home/home_view_model.dart';

class AddNoteView extends StatelessWidget {
  final HomeViewModel model;
  AddNoteView({Key? key, required this.model}) : super(key: key);
  final _titleController = TextEditingController();
  final _textController = TextEditingController();
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
                TextButton(
                    onPressed: () {
                      model.createNote(Note(
                        text: _textController.text,
                        title: _titleController.text,
                        
                      ));
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Save',
                      style: heading6Style.copyWith(
                          color: kcPrimaryColor, fontWeight: FontWeight.w400),
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
                      controller: _titleController,
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
                      controller: _textController,
                      maxLines: 80,
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
