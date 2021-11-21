import 'package:box_ui/box_ui.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../app/app.router.dart';
import '../../../../model/note_model.dart';
import '../../../shared/const_color_helper.dart';
import '../../../shared/const_ui_helper.dart';
import 'note_view_model.dart';
import 'package:stacked/stacked.dart';

class ReadNoteView extends StatelessWidget {
  final Note note;
  final int noteIndex;
  final NoteViewModel model;
  const ReadNoteView(
      {Key? key,
      required this.note,
      required this.noteIndex,
      required this.model})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final focusNode = FocusNode();
    final _arg =
        ModalRoute.of(context)!.settings.arguments as ReadNoteViewArguments;
    final noteArg = _arg.note;
    final noteIndex = _arg.noteIndex;
    final noteModel = _arg.model;
    final TextEditingController _textController =
        TextEditingController(text: noteArg.text);
    final TextEditingController _titleController =
        TextEditingController(text: noteArg.title);

    return ViewModelBuilder<NoteViewModel>.reactive(
      viewModelBuilder: () => NoteViewModel(),
      onDispose: (model) {
        _titleController.dispose();
        _textController.dispose();
        focusNode.dispose();
      },
      builder: (
        BuildContext context,
        NoteViewModel model,
        Widget? child,
      ) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  noteModel.navigateBack();
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                )),
            title: Text(
              'Note',
              style: heading6Style.copyWith(
                color: Colors.black,
              ),
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    focusNode.requestFocus();
                    model.setIsEditing(true);
                  },
                  icon: !model.isEditingNote
                      ? const Icon(
                          Icons.edit,
                          color: Colors.black,
                        )
                      : IconButton(
                          onPressed: () {
                           
                            noteModel.updateNote(
                                noteIndex,
                                noteArg.copyWith(
                                  text: _textController.text,
                                  title: _titleController.text,
                                ));
                            model.setIsEditing(false);
                          },
                          icon: const Icon(
                            Icons.save,
                            color: kcPrimaryColor,
                            size: 24,
                            
                          ))),
              if (!model.isEditingNote)
                IconButton(
                    onPressed: () => noteModel.deleteNote(noteArg, true),
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.black,
                    )),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  verticalSpaceVeryTiny,
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        DateFormat('d${model.dateSuffix()} MMM, yyyy  h:mma')
                            .format(noteArg.date!),
                        style: heading6Style.copyWith( color: kcNeutral4,
                            fontSize: 15, fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                  TextField(
                    controller: _titleController,
                    autocorrect: true,
                    style: heading5Style,
                    onTap: () => model.setIsEditing(true),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                    ),
                  ),
                  SizedBox(
                    height: screenHeiht(context) * 0.75,
                    child: TextField(
                      scrollPadding: const EdgeInsets.only(bottom: 20.0),
                      focusNode: focusNode,
                      onTap: () => model.setIsEditing(true),
                      keyboardType: TextInputType.multiline,
                      controller: _textController,
                      maxLines: 9999,
                      decoration: InputDecoration(
                          hintStyle: heading6Style.copyWith(),
                          hintText: 'Enter Text',
                          border: const OutlineInputBorder(
                              borderSide: BorderSide.none)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
