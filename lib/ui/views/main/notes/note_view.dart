import 'package:box_ui/box_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_management/ui/shared/const_color_helper.dart';
import 'package:money_management/ui/shared/const_ui_helper.dart';
import 'package:money_management/ui/shared/dumb_widgets/statusbar.dart';
import 'package:money_management/ui/views/main/home/widgets/home/home_view_model.dart';

import 'add_note_view.dart';

class NoteView extends StatelessWidget {
  final HomeViewModel model;
  const NoteView({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
        return StatusBar(
          child: Scaffold(
            floatingActionButton: FloatingActionButton(onPressed: () => Navigator.of(context).push(CupertinoPageRoute(builder: (context)=> const AddNoteView())), backgroundColor: kcPrimaryColor, child: const Icon(Icons.add, size: 35,),),
              appBar: AppBar(
                  leading: IconButton(
                      onPressed: model.setShowNoteView,
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
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.search, color: Colors.black,),
                    )
                  ]),
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35.0, vertical: 10),
                child: ListView.separated(
                    itemBuilder: (context, index) => Container(
                      height: 97,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        border: Border.all(color: kcNeutral4),
                        borderRadius: BorderRadius.circular(8)
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('How I spent today', style: heading6Style.copyWith(color: kcPrimaryColor, fontSize: 18,),),
                          Row(
                            children: [
                              Text(DateFormat('do MMM, yyyy  h:mma').format(DateTime.now()), style: heading6Style.copyWith(fontSize: 15, fontWeight: FontWeight.w400),),
                              const Spacer(),
                              IconButton(onPressed: (){}, icon: const Icon(Icons.delete))
                            ],
                          )
                        ]
                      ),
                    ),
                    separatorBuilder: (context, _) => verticalSpaceVeryTiny,
                    itemCount: 15),
              )),
        );
  }
}
