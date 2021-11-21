import 'package:box_ui/box_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import '../../../../app/app.router.dart';
import '../../../../model/note_model.dart';
import '../../../shared/const_ui_helper.dart';
import '../../../shared/dumb_widgets/statusbar.dart';
import 'note_view_model.dart';
import 'package:stacked/stacked.dart';

class AddNoteView extends StatelessWidget {
  final NoteViewModel? model;
  AddNoteView({Key? key, this.model}) : super(key: key);
  final _titleController = TextEditingController();
  final _textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final _args = ModalRoute.of(context)!.settings.arguments as AddNoteViewArguments;
    final argModel =  _args.model; 
    final focusScope = FocusScope.of(context);
    return ViewModelBuilder.nonReactive(
      viewModelBuilder: ()=> argModel!,
      onDispose: (model){
        _textController.dispose();
        _titleController.dispose();
      },
      builder: (context, _, child) => StatusBar(
        child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                  onPressed: (){
                    focusScope.unfocus();
                    argModel!.navigateBack();
                  },
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
                      focusScope.unfocus();
                      argModel!.createNote(Note(
                        text: _textController.text,
                        title: _titleController.text,
                      ));
                    },
                    child: Text(
                      'Save',
                      style: heading6Style.copyWith(
                          color: kcPrimaryColor, fontWeight: FontWeight.w400),
                    ))
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
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
                    Padding(
                      padding: const EdgeInsets.only(bottom: 18.0),
                      child: TextFormField(
                        scrollPadding: const EdgeInsets.all(20.0),
                        keyboardType: TextInputType.multiline,
                        controller: _textController,
                        maxLines: 999,
                        decoration: InputDecoration(
                            hintStyle: heading6Style.copyWith(),
                            hintText: 'Enter Text',
                            border: const OutlineInputBorder(
                                borderSide: BorderSide.none)),
                      ),
                    ),
                  ],
                )),
              ),
            ))));
  }
}
