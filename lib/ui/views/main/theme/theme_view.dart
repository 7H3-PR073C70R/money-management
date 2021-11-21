// import 'package:box_ui/box_ui.dart';
// import 'package:flutter/material.dart';
// import 'package:money_management/constants/app_string.dart';
// import 'package:money_management/ui/shared/dumb_widgets/radio.dart';
// import 'package:stacked/stacked.dart';
// import 'theme_view_model.dart';

// class ThemeView extends StatelessWidget {
//   const ThemeView({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ViewModelBuilder<ThemeViewModel>.reactive(
//       viewModelBuilder: () => ThemeViewModel(),
//       builder: (
//         BuildContext context,
//         ThemeViewModel model,
//         Widget? child,
//       ) {
//         return Scaffold(
//             appBar: AppBar(
//               leading: IconButton(
//                   onPressed: () => Navigator.of(context).pop(),
//                   icon: const Icon(
//                     Icons.arrow_back,
//                     color: Colors.black,
//                   )),
//               title: Text(
//                 themeText,
//                 style: heading6Style.copyWith(
//                   color: kcPrimaryColor,
//                 ),
//               ),
//               centerTitle: true,
//             ),
//             body: Padding(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 35, vertical: 26),
//                 child: ListView.builder(
//                   itemCount: model.themes.length,
//                     itemBuilder: (context, index) => RadioButton(
//                         isSelected: model.selectedIndex == index,
//                         title: model.themeText[index],
//                         onTap: () =>
//                             model.setSelectedTheme(model.themes[index]),
//                         value: model.themes[index],
//                         groupValue: model.selectedThem,
//                         onChange: (value) {
//                           model.setSelectedTheme(value);
//                         }))));
//       },
//     );
//   }
// }
