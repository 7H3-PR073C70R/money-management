import 'package:box_ui/box_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_management/constants/app_string.dart';
import 'package:money_management/ui/shared/const_color_helper.dart';
import 'package:money_management/ui/shared/const_ui_helper.dart';
import 'package:money_management/ui/shared/dumb_widgets/no_item.dart';
import 'package:money_management/ui/shared/dumb_widgets/statusbar.dart';
import 'package:money_management/ui/views/main/notes/note_view_model.dart';
import 'package:stacked/stacked.dart';
import 'add_note_view.dart';

class NoteView extends StatelessWidget {
  const NoteView({Key? key, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<NoteViewModel>.reactive(
      viewModelBuilder: ()=>NoteViewModel(), 
      onModelReady: (model) => model.init(),
    builder:(context, model, child) => StatusBar(
      child: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () => model.navigateToAddNoteView(model),
            backgroundColor: kcPrimaryColor,
            child: const Icon(
              Icons.add,
              size: 35,
            ),
          ),
          appBar: AppBar(
              leading: IconButton(
                  onPressed: model.navigateBack,
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  )),
              title: Text(
                'Home',
                style: heading6Style.copyWith(
                  color: Colors.black,
                ),
              ),
              actions: [
                if(model.showSearchFieldForNote)
                SizedBox(width: screenWidth(context) * 0.5,
                child: BoxInputField(
                  onChanged: model.setNoteQuery,
                ),
                ),
                IconButton(
                  onPressed: model.setShowSearchField,
                  icon:  Icon(
                    model.showSearchFieldForNote ? Icons.close : Icons.search,
                    color: Colors.black,
                  ),
                )
              ]),
          body: model.notes.isEmpty
              ? NoItem(
                  text: noNoteText,
                  buttonText: noNoteButtonText,
                  onTap: () => model.navigateToAddNoteView(model),
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 35.0, vertical: 10),
                  child: ListView.separated(
                      itemBuilder: (context, index) => Container(
                            height: 97,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                            decoration: BoxDecoration(
                                border: Border.all(color: kcNeutral4),
                                borderRadius: BorderRadius.circular(8)),
                            child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    model.notes[index].title ?? 'No Title',
                                    style: heading6Style.copyWith(
                                      color: kcPrimaryColor,
                                      fontSize: 18,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        DateFormat(
                                                'd${model.dateSuffix()} MMM, yyyy  h:mma')
                                            .format(model.notes[index].date!),
                                        style: heading6Style.copyWith(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      const Spacer(),
                                      IconButton(
                                          onPressed: () {
                                            model
                                                .deleteNote(model.notes[index]);
                                          },
                                          icon: const Icon(Icons.delete))
                                    ],
                                  )
                                ]),
                          ),
                      separatorBuilder: (context, _) => verticalSpaceVeryTiny,
                      itemCount: model.notes.length),
                )),
    ) );
  }
}
